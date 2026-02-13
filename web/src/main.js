import * as monaco from 'monaco-editor';
import initWasm, { check_bytecode, run_bytecode, source_stats } from './pkg/funk_wasm.js';

const DEFAULT_SOURCE = `# Funk Playground\nmain():\n    say("hello from browser")\n    0.\n`;
const DEFAULT_FUEL = 10_000_000;
const OUTPUT_LIMIT_BYTES = 64 * 1024;

const state = {
  wasmReady: false,
  pyodideReady: false,
  pyodide: null,
  editor: null,
  statusEl: null,
  outputEl: null,
  fuelEl: null,
  fuelLabelEl: null,
  statsEl: null,
};

renderLayout();
await boot();

async function boot() {
  setStatus('Initializing WASM runtime...');
  await initWasm();
  state.wasmReady = true;

  setStatus('Initializing browser compiler (Pyodide)...');
  state.pyodide = await initPyodideRuntime();
  state.pyodideReady = true;

  setStatus('Ready.');
  updateStats();
}

function renderLayout() {
  const app = document.getElementById('app');
  app.innerHTML = `
    <header class="topbar">
      <h1>Funk Playground</h1>
      <p>Browser-only compiler + bytecode VM (safe mode)</p>
    </header>
    <main class="layout">
      <aside class="sidebar">
        <details open>
          <summary>stdlib</summary>
          <ul id="stdlib-tree" class="tree"></ul>
        </details>
        <div class="sidebar-preview">
          <h3>Source Preview</h3>
          <pre id="stdlib-preview">Select a stdlib file.</pre>
        </div>
      </aside>
      <section class="workspace">
        <div class="controls">
          <button id="btn-check">Check</button>
          <button id="btn-run">Run</button>
          <label class="fuel-control">Fuel
            <input id="fuel" type="range" min="10000" max="50000000" step="10000" value="${DEFAULT_FUEL}" />
            <span id="fuel-label"></span>
          </label>
        </div>
        <div id="editor" class="editor"></div>
        <div class="meta">
          <div id="stats"></div>
          <div id="status"></div>
        </div>
        <pre id="output" class="output"></pre>
      </section>
    </main>
  `;

  registerFunkLanguage();
  state.editor = monaco.editor.create(document.getElementById('editor'), {
    value: DEFAULT_SOURCE,
    language: 'funk',
    theme: 'vs-dark',
    minimap: { enabled: false },
    automaticLayout: true,
    tabSize: 4,
    insertSpaces: true,
    folding: true,
  });

  state.statusEl = document.getElementById('status');
  state.outputEl = document.getElementById('output');
  state.fuelEl = document.getElementById('fuel');
  state.fuelLabelEl = document.getElementById('fuel-label');
  state.statsEl = document.getElementById('stats');

  const onFuel = () => {
    state.fuelLabelEl.textContent = Number(state.fuelEl.value).toLocaleString();
  };
  onFuel();
  state.fuelEl.addEventListener('input', onFuel);

  state.editor.onDidChangeModelContent(() => updateStats());

  document.getElementById('btn-check').addEventListener('click', async () => {
    await runCheck();
  });
  document.getElementById('btn-run').addEventListener('click', async () => {
    await runProgram();
  });

  populateStdlibTree();
}

function registerFunkLanguage() {
  monaco.languages.register({ id: 'funk' });
  monaco.languages.setMonarchTokensProvider('funk', {
    tokenizer: {
      root: [
        [/#[^\n]*/, 'comment'],
        [/"(?:[^"\\]|\\.)*"/, 'string'],
        [/-?\d+(?:\.\d+)?/, 'number'],
        [/\b(?:main|use|match)\b/, 'keyword'],
        [/\b[A-Za-z_][A-Za-z0-9_]*\b/, 'identifier'],
      ],
    },
  });

  monaco.languages.registerFoldingRangeProvider('funk', {
    provideFoldingRanges(model) {
      const ranges = [];
      const starts = [];
      for (let line = 1; line <= model.getLineCount(); line += 1) {
        const text = model.getLineContent(line);
        if (/^\s*[A-Za-z_][A-Za-z0-9_]*\s*\(.*\)\s*:/.test(text)) {
          starts.push(line);
        }
      }
      for (let i = 0; i < starts.length; i += 1) {
        const start = starts[i];
        const end = i + 1 < starts.length ? starts[i + 1] - 1 : model.getLineCount();
        if (end > start) {
          ranges.push({
            start,
            end,
            kind: monaco.languages.FoldingRangeKind.Region,
          });
        }
      }
      return ranges;
    },
  });
}

async function initPyodideRuntime() {
  const { loadPyodide } = await import('https://cdn.jsdelivr.net/pyodide/v0.27.2/full/pyodide.mjs');
  const pyodide = await loadPyodide();
  await pyodide.loadPackage('micropip');
  await pyodide.runPythonAsync(`
import micropip
await micropip.install('lark')
`);

  const manifest = await fetch('./runtime/manifest.json').then((r) => r.json());

  const ensureDir = (fullPath) => {
    const parts = fullPath.split('/').filter(Boolean);
    let current = '';
    for (const part of parts) {
      current += `/${part}`;
      try {
        pyodide.FS.mkdir(current);
      } catch (_) {
      }
    }
  };

  ensureDir('/runtime');
  ensureDir('/runtime/funk');
  ensureDir('/runtime/stdlib');

  for (const rel of manifest.pythonFiles) {
    const target = `/runtime/funk/${rel}`;
    ensureDir(target.split('/').slice(0, -1).join('/'));
    const content = await fetch(`./runtime/funk/${rel}`).then((r) => r.text());
    pyodide.FS.writeFile(target, content, { encoding: 'utf8' });
  }

  for (const rel of manifest.stdlibFiles) {
    const target = `/runtime/stdlib/${rel}`;
    ensureDir(target.split('/').slice(0, -1).join('/'));
    const content = await fetch(`./runtime/stdlib/${rel}`).then((r) => r.text());
    pyodide.FS.writeFile(target, content, { encoding: 'utf8' });
  }

  const top = await fetch('./runtime/funky.py').then((r) => r.text());
  pyodide.FS.writeFile('/runtime/funky.py', top, { encoding: 'utf8' });

  pyodide.runPython(`
import base64
import os
import sys

sys.path.insert(0, '/runtime')

from funk.backends.bytecode import BytecodeBackend


def __compile_funk_to_fkb(source):
    os.makedirs('/workspace', exist_ok=True)
    os.makedirs('/workspace/build', exist_ok=True)
    backend = BytecodeBackend()
    artifact = backend.compile_source(
        src_path='/workspace/main.f',
        src_text=source,
        build_path='/workspace/build',
        debug=False,
        exe_command=lambda cmd: None,
        include_paths=['/runtime/stdlib', '/workspace'],
    )
    binary_path = artifact[:-5] if artifact.endswith('.json') else artifact + '.fkb'
    with open(binary_path, 'rb') as f:
        return base64.b64encode(f.read()).decode('ascii')
`);

  return pyodide;
}

async function compileToBytecode(source) {
  const pyFn = state.pyodide.globals.get('__compile_funk_to_fkb');
  try {
    const encoded = pyFn(source);
    return base64ToBytes(encoded);
  } finally {
    pyFn.destroy();
  }
}

function base64ToBytes(base64) {
  const bin = atob(base64);
  const out = new Uint8Array(bin.length);
  for (let i = 0; i < bin.length; i += 1) {
    out[i] = bin.charCodeAt(i);
  }
  return out;
}

function setStatus(message) {
  if (state.statusEl) {
    state.statusEl.textContent = message;
  }
}

function setOutput(text) {
  state.outputEl.textContent = text;
}

async function runCheck() {
  try {
    setStatus('Checking...');
    const source = state.editor.getValue();
    const bytecode = await compileToBytecode(source);
    const result = check_bytecode(bytecode);
    if (result.ok) {
      setOutput('check: ok');
      setStatus('Check passed.');
    } else {
      setOutput(formatError(result.error));
      setStatus('Check failed.');
    }
  } catch (err) {
    setOutput(String(err));
    setStatus('Check failed.');
  }
}

async function runProgram() {
  try {
    setStatus('Compiling and running...');
    const source = state.editor.getValue();
    const bytecode = await compileToBytecode(source);
    const fuel = Number(state.fuelEl.value);
    const result = run_bytecode(bytecode, fuel, OUTPUT_LIMIT_BYTES);
    if (result.ok) {
      const lines = [];
      if (result.output && result.output.length > 0) {
        lines.push(result.output.trimEnd());
      }
      if (result.return_value !== null) {
        lines.push(`return: ${result.return_value}`);
      }
      setOutput(lines.join('\n'));
      setStatus('Run completed.');
    } else {
      setOutput(formatError(result.error));
      setStatus('Run failed.');
    }
  } catch (err) {
    setOutput(String(err));
    setStatus('Run failed.');
  }
}

function formatError(error) {
  if (!error) {
    return 'unknown error';
  }
  return `${error.code}: ${error.message}`;
}

async function populateStdlibTree() {
  const tree = document.getElementById('stdlib-tree');
  const preview = document.getElementById('stdlib-preview');
  const manifest = await fetch('./runtime/manifest.json').then((r) => r.json());

  for (const rel of manifest.stdlibFiles) {
    const li = document.createElement('li');
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.textContent = rel;
    btn.addEventListener('click', async () => {
      const text = await fetch(`./runtime/stdlib/${rel}`).then((r) => r.text());
      preview.textContent = text;
    });
    li.appendChild(btn);
    tree.appendChild(li);
  }
}

function updateStats() {
  if (!state.wasmReady) {
    return;
  }
  const stats = source_stats(state.editor.getValue());
  state.statsEl.textContent = `comments: ${stats.comments} | numbers: ${stats.numbers} | strings: ${stats.strings} | identifiers: ${stats.identifiers}`;
}
