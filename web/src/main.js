import * as monaco from 'monaco-editor';
import initWasm, { call_function, check_bytecode, run_bytecode, source_stats } from './pkg/funk_wasm.js';

const DEFAULT_SOURCE = `# Funk Playground\nmain():\n    say("hello from browser")\n    0.\n`;
const DEFAULT_GRAPHICS_DEMO = `use s2d\n\nspin(t):\n    x <- 255.0 + 120.0 * rand_float(-1.0, 1.0)\n    y <- 255.0 + 120.0 * rand_float(-1.0, 1.0)\n    s2d_set_color(50 + (t%200), 200, 120)\n    s2d_line(255, 255, x, y)\n    s2d_set_user_ctx(t + 1).\n\ns2d_render(ctx):\n    t <- ctx\n    spin(t)\n    1.\n\nmain():\n    s2d(510, 510, 0).\n`;
const DEFAULT_FUEL = 10_000_000;
const OUTPUT_LIMIT_BYTES = 64 * 1024;
const UNLIMITED_FUEL = Number.MAX_SAFE_INTEGER;
const ENABLE_HOST_EFFECTS = true;

const state = {
  wasmReady: false,
  pyodideReady: false,
  pyodide: null,
  editor: null,
  statusEl: null,
  outputEl: null,
  fuelEl: null,
  fuelLabelEl: null,
  fuelUnlimitedEl: null,
  statsEl: null,
  buildInfoEl: null,
  sourcePath: '/workspace/main.f',
  gfxWrapEl: null,
  gfxCanvasEl: null,
  gfxCtx: null,
  gfxColor: 'rgb(0,255,0)',
  gfxUserCtx: null,
  lastBytecode: null,
  s2dLoopActive: false,
  s2dRafId: null,
  frameFpsEl: null,
  frameFuelEl: null,
  frameLogEl: null,
  fpsEl: null,
  framePerfEl: null,
  lastFrameAtMs: 0,
  fpsLastMarkMs: 0,
  fpsFrames: 0,
  frameOkCount: 0,
  frameErrCount: 0,
  frameMsAvg: 0,
};

void start();

async function start() {
  renderLayout();
  try {
    await boot();
  } catch (err) {
    setStatus('Initialization failed.');
    setOutput(String(err));
  }
}

async function boot() {
  await loadBuildInfo();
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
  const localUnlimited = isLocalHost();
  const app = document.getElementById('app');
  app.innerHTML = `
    <header class="topbar">
      <h1>Funk Playground</h1>
      <p>Browser-only compiler + bytecode VM (safe mode)</p>
      <p id="build-info" class="build-info">build: loading...</p>
    </header>
    <main class="layout">
      <aside class="sidebar">
        <details open>
          <summary>stdlib</summary>
          <ul id="stdlib-tree" class="tree"></ul>
        </details>
        <details open>
          <summary>examples</summary>
          <ul id="examples-tree" class="tree"></ul>
        </details>
        <div class="sidebar-preview">
          <h3>Source Preview</h3>
          <pre id="stdlib-preview">Select a stdlib file.</pre>
        </div>
      </aside>
      <div id="sidebar-splitter" class="splitter splitter-v" title="Resize sidebar"></div>
      <section class="workspace">
        <div class="controls">
          <button id="btn-demo">Graphics Demo</button>
          <button id="btn-check">Check</button>
          <button id="btn-run">Run</button>
          <button id="btn-stop-loop">Stop Loop</button>
          <label class="fuel-control">Fuel
            <input id="fuel" type="range" min="10000" max="50000000" step="10000" value="${DEFAULT_FUEL}" />
            <span id="fuel-label"></span>
          </label>
          <label class="frame-control">FPS
            <input id="frame-fps" type="number" min="1" max="120" step="1" value="30" />
          </label>
          <label class="frame-control">Frame Fuel
            <input id="frame-fuel" type="number" min="1000" max="50000000" step="1000" value="1000000" />
          </label>
          <label class="frame-control">
            <input id="frame-log" type="checkbox" />
            Frame Log
          </label>
          <label class="fuel-unlimited ${localUnlimited ? '' : 'fuel-unlimited-disabled'}" title="Only available on localhost">
            <input id="fuel-unlimited" type="checkbox" ${localUnlimited ? '' : 'disabled'} />
            Unlimited
          </label>
        </div>
        <div id="editor" class="editor"></div>
        <div id="gfx-host" class="gfx-host hidden">
          <canvas id="gfx-canvas"></canvas>
        </div>
        <div class="meta">
          <div id="stats"></div>
          <div id="fps">fps: -</div>
          <div id="frame-perf">frame: -</div>
          <div id="status"></div>
        </div>
        <div id="output-splitter" class="splitter splitter-h" title="Resize output"></div>
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
  state.fuelUnlimitedEl = document.getElementById('fuel-unlimited');
  state.statsEl = document.getElementById('stats');
  state.buildInfoEl = document.getElementById('build-info');
  state.gfxWrapEl = document.getElementById('gfx-host');
  state.gfxCanvasEl = document.getElementById('gfx-canvas');
  state.frameFpsEl = document.getElementById('frame-fps');
  state.frameFuelEl = document.getElementById('frame-fuel');
  state.frameLogEl = document.getElementById('frame-log');
  state.fpsEl = document.getElementById('fps');
  state.framePerfEl = document.getElementById('frame-perf');

  const onFuel = () => {
    const isUnlimited = !!state.fuelUnlimitedEl?.checked;
    state.fuelLabelEl.textContent = isUnlimited ? '∞' : Number(state.fuelEl.value).toLocaleString();
  };
  onFuel();
  state.fuelEl.addEventListener('input', onFuel);
  state.fuelUnlimitedEl.addEventListener('change', () => {
    const isUnlimited = state.fuelUnlimitedEl.checked;
    state.fuelEl.disabled = isUnlimited;
    onFuel();
  });

  state.editor.onDidChangeModelContent(() => updateStats());

  document.getElementById('btn-check').addEventListener('click', async () => {
    await runCheck();
  });
  document.getElementById('btn-demo').addEventListener('click', async () => {
    state.editor.setValue(DEFAULT_GRAPHICS_DEMO);
    state.sourcePath = '/workspace/graphics_demo.f';
    updateStats();
    await runProgram();
  });
  document.getElementById('btn-run').addEventListener('click', async () => {
    await runProgram();
  });
  document.getElementById('btn-stop-loop').addEventListener('click', () => {
    stopS2DLoop();
    setStatus('Graphics loop stopped.');
  });

  populateLibraryTrees();
  installBrowserHostBridge();
  setupResizers();
}

function isLocalHost() {
  const host = window.location.hostname;
  return host === 'localhost' || host === '127.0.0.1' || host === '0.0.0.0' || host === '::1';
}

function setupResizers() {
  const layout = document.querySelector('.layout');
  const workspace = document.querySelector('.workspace');
  const sidebarSplitter = document.getElementById('sidebar-splitter');
  const outputSplitter = document.getElementById('output-splitter');
  if (!layout || !workspace || !sidebarSplitter || !outputSplitter) {
    return;
  }

  sidebarSplitter.addEventListener('pointerdown', (event) => {
    if (window.matchMedia('(max-width: 960px)').matches) {
      return;
    }
    event.preventDefault();
    document.body.classList.add('dragging');
    const startX = event.clientX;
    const startWidth = parseFloat(getComputedStyle(layout).getPropertyValue('--sidebar-width')) || 320;
    const onMove = (moveEvent) => {
      const next = startWidth + (moveEvent.clientX - startX);
      const min = 220;
      const max = Math.max(min, Math.floor(window.innerWidth * 0.7));
      layout.style.setProperty('--sidebar-width', `${Math.min(max, Math.max(min, next))}px`);
    };
    const onUp = () => {
      window.removeEventListener('pointermove', onMove);
      window.removeEventListener('pointerup', onUp);
      document.body.classList.remove('dragging');
    };
    window.addEventListener('pointermove', onMove);
    window.addEventListener('pointerup', onUp);
  });

  outputSplitter.addEventListener('pointerdown', (event) => {
    event.preventDefault();
    document.body.classList.add('dragging');
    const startY = event.clientY;
    const startHeight = parseFloat(getComputedStyle(workspace).getPropertyValue('--output-height')) || 160;
    const onMove = (moveEvent) => {
      const next = startHeight - (moveEvent.clientY - startY);
      const min = 100;
      const max = Math.max(min, Math.floor(window.innerHeight * 0.6));
      workspace.style.setProperty('--output-height', `${Math.min(max, Math.max(min, next))}px`);
    };
    const onUp = () => {
      window.removeEventListener('pointermove', onMove);
      window.removeEventListener('pointerup', onUp);
      document.body.classList.remove('dragging');
    };
    window.addEventListener('pointermove', onMove);
    window.addEventListener('pointerup', onUp);
  });
}

async function loadBuildInfo() {
  if (!state.buildInfoEl) return;
  try {
    const response = await fetch('./runtime/build-info.json');
    if (!response.ok) {
      state.buildInfoEl.textContent = `build: unavailable (${response.status})`;
      return;
    }
    const info = await response.json();
    const main = info?.git?.superproject?.short ?? 'unknown';
    const funk = info?.git?.submodules?.funk?.short ?? 'missing';
    const stdlib = info?.git?.submodules?.stdlib?.short ?? 'missing';
    const when = info?.builtAtUtc ?? 'unknown-time';
    state.buildInfoEl.textContent = `build: main ${main} | funk ${funk} | stdlib ${stdlib} | ${when}`;
  } catch (_) {
    state.buildInfoEl.textContent = 'build: unavailable';
  }
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

  const fetchTextOrThrow = async (url) => {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Failed to fetch ${url} (${response.status} ${response.statusText})`);
    }
    return response.text();
  };

  const fetchJsonOrThrow = async (url) => {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Failed to fetch ${url} (${response.status} ${response.statusText})`);
    }
    return response.json();
  };

  const manifest = await fetchJsonOrThrow('./runtime/manifest.json');

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
  ensureDir('/runtime/examples');
  ensureDir('/runtime/include');

  for (const rel of manifest.pythonFiles) {
    const target = `/runtime/funk/${rel}`;
    ensureDir(target.split('/').slice(0, -1).join('/'));
    const content = await fetchTextOrThrow(`./runtime/funk/${rel}`);
    pyodide.FS.writeFile(target, content, { encoding: 'utf8' });
  }

  for (const rel of manifest.stdlibFiles) {
    const target = `/runtime/stdlib/${rel}`;
    ensureDir(target.split('/').slice(0, -1).join('/'));
    const content = await fetchTextOrThrow(`./runtime/stdlib/${rel}`);
    pyodide.FS.writeFile(target, content, { encoding: 'utf8' });
  }

  for (const rel of (manifest.exampleFiles || [])) {
    const target = `/runtime/examples/${rel}`;
    ensureDir(target.split('/').slice(0, -1).join('/'));
    const content = await fetchTextOrThrow(`./runtime/examples/${rel}`);
    pyodide.FS.writeFile(target, content, { encoding: 'utf8' });
  }

  for (const rel of (manifest.includeFiles || [])) {
    const target = `/runtime/include/${rel}`;
    ensureDir(target.split('/').slice(0, -1).join('/'));
    const content = await fetchTextOrThrow(`./runtime/include/${rel}`);
    pyodide.FS.writeFile(target, content, { encoding: 'utf8' });
  }

  const top = await fetchTextOrThrow('./runtime/funky.py');
  pyodide.FS.writeFile('/runtime/funky.py', top, { encoding: 'utf8' });

  pyodide.runPython(`
import base64
import os
import sys

sys.path.insert(0, '/runtime')

from funk.backends.bytecode import BytecodeBackend


def __compile_funk_to_fkb(source, src_path='/workspace/main.f'):
    os.makedirs('/workspace', exist_ok=True)
    os.makedirs('/workspace/build', exist_ok=True)
    src_dir = os.path.dirname(src_path) or '/workspace'
    os.makedirs(src_dir, exist_ok=True)
    with open(src_path, 'w') as f:
        f.write(source)
    include_paths = ['/runtime/stdlib', '/workspace']
    if os.path.isdir('/runtime/examples'):
        include_paths.append('/runtime/examples')
    if os.path.isdir('/runtime/include'):
        include_paths.append('/runtime/include')
    if src_dir not in include_paths:
        include_paths.insert(0, src_dir)
    backend = BytecodeBackend()
    artifact = backend.compile_source(
        src_path=src_path,
        src_text=source,
        build_path='/workspace/build',
        debug=False,
        exe_command=lambda cmd: None,
        include_paths=include_paths,
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
    const encoded = pyFn(source, state.sourcePath);
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
    const result = check_bytecode(bytecode, ENABLE_HOST_EFFECTS);
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
    stopS2DLoop();
    const source = state.editor.getValue();
    const bytecode = await compileToBytecode(source);
    state.lastBytecode = bytecode;
    const fuel = state.fuelUnlimitedEl?.checked ? UNLIMITED_FUEL : Number(state.fuelEl.value);
    const result = run_bytecode(bytecode, fuel, OUTPUT_LIMIT_BYTES, ENABLE_HOST_EFFECTS);
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

function installBrowserHostBridge() {
  globalThis.__funk_host_call = (name, args) => {
    if (name === 's2d.sdl_simple') return handleS2DSimple(args);
    if (name === 's2d.sdl_set_color') return handleS2DSetColor(args);
    if (name === 's2d.sdl_point') return handleS2DPoint(args);
    if (name === 's2d.sdl_line') return handleS2DLine(args);
    if (name === 's2d.sdl_rect') return handleS2DRect(args);
    if (name === 's2d.sdl_set_user_ctx') return handleS2DSetUserCtx(args);
    throw new Error(`unsupported browser host call: ${name}`);
  };
}

function ensureGfxReady(width = 640, height = 480) {
  if (!state.gfxWrapEl || !state.gfxCanvasEl) {
    throw new Error('graphics canvas is not initialized');
  }
  state.gfxWrapEl.classList.remove('hidden');
  if (!state.gfxCtx || state.gfxCanvasEl.width !== width || state.gfxCanvasEl.height !== height) {
    state.gfxCanvasEl.width = Math.max(1, width);
    state.gfxCanvasEl.height = Math.max(1, height);
    state.gfxCtx = state.gfxCanvasEl.getContext('2d');
    if (!state.gfxCtx) {
      throw new Error('2d canvas context unavailable');
    }
  }
  return state.gfxCtx;
}

function handleS2DSimple(args) {
  const width = toInt(args?.[0], 640);
  const height = toInt(args?.[1], 480);
  ensureGfxReady(width, height);
  state.gfxUserCtx = args?.[2] ?? null;
  startS2DLoop();
  setStatus(`Graphics loop started: ${width}x${height}`);
  return 1;
}

function handleS2DSetColor(args) {
  const r = clampByte(toInt(args?.[0], 0));
  const g = clampByte(toInt(args?.[1], 255));
  const b = clampByte(toInt(args?.[2], 0));
  state.gfxColor = `rgb(${r},${g},${b})`;
  return 1;
}

function handleS2DPoint(args) {
  const ctx = ensureGfxReady();
  const x = toInt(args?.[0], 0);
  const y = toInt(args?.[1], 0);
  ctx.fillStyle = state.gfxColor;
  ctx.fillRect(x, y, 1, 1);
  return 1;
}

function handleS2DLine(args) {
  const ctx = ensureGfxReady();
  const x1 = toInt(args?.[0], 0);
  const y1 = toInt(args?.[1], 0);
  const x2 = toInt(args?.[2], 0);
  const y2 = toInt(args?.[3], 0);
  ctx.strokeStyle = state.gfxColor;
  ctx.lineWidth = 1;
  ctx.beginPath();
  ctx.moveTo(x1 + 0.5, y1 + 0.5);
  ctx.lineTo(x2 + 0.5, y2 + 0.5);
  ctx.stroke();
  return 1;
}

function handleS2DRect(args) {
  const ctx = ensureGfxReady();
  const x = toInt(args?.[0], 0);
  const y = toInt(args?.[1], 0);
  const w = Math.max(0, toInt(args?.[2], 0));
  const h = Math.max(0, toInt(args?.[3], 0));
  ctx.fillStyle = state.gfxColor;
  ctx.fillRect(x, y, w, h);
  return 1;
}

function handleS2DSetUserCtx(args) {
  state.gfxUserCtx = args?.[0] ?? null;
  return 1;
}

function startS2DLoop() {
  if (state.s2dLoopActive) {
    return;
  }
  if (!state.lastBytecode) {
    throw new Error('no compiled bytecode available for s2d render loop');
  }
  state.s2dLoopActive = true;
  state.lastFrameAtMs = 0;
  state.fpsLastMarkMs = 0;
  state.fpsFrames = 0;
  state.frameOkCount = 0;
  state.frameErrCount = 0;
  state.frameMsAvg = 0;
  if (state.fpsEl) {
    state.fpsEl.textContent = 'fps: ...';
  }
  if (state.framePerfEl) {
    state.framePerfEl.textContent = 'frame: ...';
  }
  const step = (tsMs) => {
    if (!state.s2dLoopActive) {
      return;
    }
    const fps = clampInt(toInt(state.frameFpsEl?.value, 30), 1, 120);
    const intervalMs = Math.floor(1000 / fps);
    if (state.lastFrameAtMs !== 0 && tsMs - state.lastFrameAtMs < intervalMs) {
      state.s2dRafId = requestAnimationFrame(step);
      return;
    }
    state.lastFrameAtMs = tsMs;
    if (state.fpsLastMarkMs === 0) {
      state.fpsLastMarkMs = tsMs;
      state.fpsFrames = 0;
    }
    const ctx = ensureGfxReady();
    ctx.fillStyle = '#10182c';
    ctx.fillRect(0, 0, state.gfxCanvasEl.width, state.gfxCanvasEl.height);
    ctx.strokeStyle = '#2f4778';
    ctx.lineWidth = 1;
    ctx.strokeRect(0.5, 0.5, state.gfxCanvasEl.width - 1, state.gfxCanvasEl.height - 1);

    const frameStart = performance.now();
    const renderResult = call_function(
      state.lastBytecode,
      's2d_render',
      [state.gfxUserCtx],
      clampInt(toInt(state.frameFuelEl?.value, 1_000_000), 1000, 50_000_000),
      OUTPUT_LIMIT_BYTES,
      ENABLE_HOST_EFFECTS,
    );
    const frameMs = performance.now() - frameStart;
    if (state.frameMsAvg === 0) {
      state.frameMsAvg = frameMs;
    } else {
      state.frameMsAvg = state.frameMsAvg * 0.9 + frameMs * 0.1;
    }
    if (!renderResult.ok) {
      state.frameErrCount += 1;
      if (state.framePerfEl) {
        state.framePerfEl.textContent = `frame: ${frameMs.toFixed(2)}ms (avg ${state.frameMsAvg.toFixed(2)}ms) ok ${state.frameOkCount} err ${state.frameErrCount}`;
      }
      setOutput(formatError(renderResult.error));
      setStatus('Run failed.');
      stopS2DLoop();
      return;
    }
    state.frameOkCount += 1;
    if (state.frameLogEl?.checked && renderResult.output) {
      const prev = state.outputEl.textContent || '';
      state.outputEl.textContent = `${prev}${renderResult.output}`.slice(-OUTPUT_LIMIT_BYTES);
    }
    state.fpsFrames += 1;
    const elapsed = tsMs - state.fpsLastMarkMs;
    if (elapsed >= 1000) {
      const fps = (state.fpsFrames * 1000) / elapsed;
      if (state.fpsEl) {
        state.fpsEl.textContent = `fps: ${fps.toFixed(1)}`;
      }
      if (state.framePerfEl) {
        state.framePerfEl.textContent = `frame: ${frameMs.toFixed(2)}ms (avg ${state.frameMsAvg.toFixed(2)}ms) ok ${state.frameOkCount} err ${state.frameErrCount}`;
      }
      state.fpsLastMarkMs = tsMs;
      state.fpsFrames = 0;
    }
    state.s2dRafId = requestAnimationFrame(step);
  };
  state.s2dRafId = requestAnimationFrame(step);
}

function stopS2DLoop() {
  state.s2dLoopActive = false;
  if (state.s2dRafId !== null) {
    cancelAnimationFrame(state.s2dRafId);
    state.s2dRafId = null;
  }
  if (state.fpsEl) {
    state.fpsEl.textContent = 'fps: -';
  }
  if (state.framePerfEl) {
    state.framePerfEl.textContent = 'frame: -';
  }
}

function toInt(value, fallback) {
  const n = Number(value);
  if (!Number.isFinite(n)) {
    return fallback;
  }
  return Math.floor(n);
}

function clampByte(n) {
  return Math.max(0, Math.min(255, n));
}

function clampInt(v, min, max) {
  return Math.max(min, Math.min(max, Math.floor(v)));
}

function formatError(error) {
  if (!error) {
    return 'unknown error';
  }
  return `${error.code}: ${error.message}`;
}

async function populateLibraryTrees() {
  const tree = document.getElementById('stdlib-tree');
  const examplesTree = document.getElementById('examples-tree');
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

  const examples = manifest.exampleFiles || [];
  if (examples.length === 0) {
    const li = document.createElement('li');
    li.textContent = 'No examples bundled';
    examplesTree.appendChild(li);
    return;
  }

  for (const rel of examples) {
    if (!rel.endsWith('.f')) {
      continue;
    }
    const li = document.createElement('li');
    const btn = document.createElement('button');
    btn.type = 'button';
    btn.textContent = rel;
    btn.title = 'Load into editor';
    btn.addEventListener('click', async () => {
      const text = await fetch(`./runtime/examples/${rel}`).then((r) => r.text());
      preview.textContent = text;
      state.editor.setValue(text);
      state.sourcePath = `/runtime/examples/${rel}`;
      setStatus(`Loaded example: ${rel}`);
      updateStats();
    });
    li.appendChild(btn);
    examplesTree.appendChild(li);
  }
}

function updateStats() {
  if (!state.wasmReady) {
    return;
  }
  const stats = source_stats(state.editor.getValue());
  state.statsEl.textContent = `comments: ${stats.comments} | numbers: ${stats.numbers} | strings: ${stats.strings} | identifiers: ${stats.identifiers}`;
}
