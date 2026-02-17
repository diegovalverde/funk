import { cp, mkdir, readdir, rm, stat, writeFile } from 'node:fs/promises';
import { execFileSync } from 'node:child_process';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const webRoot = path.resolve(__dirname, '..');
const repoRoot = path.resolve(webRoot, '..');
const runtimeRoot = path.join(webRoot, 'public', 'runtime');

async function listFiles(root) {
  const out = [];
  async function walk(current, relBase = '') {
    const entries = await readdir(current, { withFileTypes: true });
    for (const entry of entries) {
      if (entry.name.startsWith('.')) {
        continue;
      }
      const abs = path.join(current, entry.name);
      const rel = path.join(relBase, entry.name);
      if (entry.isDirectory()) {
        await walk(abs, rel);
      } else {
        out.push(rel.replaceAll('\\\\', '/'));
      }
    }
  }
  await walk(root);
  out.sort();
  return out;
}

async function isDirectory(pathLike) {
  try {
    const s = await stat(pathLike);
    return s.isDirectory();
  } catch (_) {
    return false;
  }
}

function gitValue(args, cwd) {
  try {
    return execFileSync('git', args, {
      cwd,
      encoding: 'utf8',
      stdio: ['ignore', 'pipe', 'ignore'],
    }).trim();
  } catch (_) {
    return null;
  }
}

function commitInfo(repoPath) {
  const full = gitValue(['rev-parse', 'HEAD'], repoPath);
  const short = gitValue(['rev-parse', '--short=12', 'HEAD'], repoPath);
  const dirty = !!gitValue(['status', '--porcelain'], repoPath);
  return {
    full,
    short,
    dirty,
    present: !!full,
  };
}

await rm(runtimeRoot, { recursive: true, force: true });
await mkdir(runtimeRoot, { recursive: true });

await cp(path.join(repoRoot, 'funk'), path.join(runtimeRoot, 'funk'), { recursive: true });
await cp(path.join(repoRoot, 'stdlib'), path.join(runtimeRoot, 'stdlib'), { recursive: true });
await cp(path.join(repoRoot, 'funky.py'), path.join(runtimeRoot, 'funky.py'));

const examplesRootCandidates = [
  path.join(repoRoot, 'funky_example_files', 'root'),
  path.resolve(repoRoot, '..', 'funky_example_files', 'root'),
];

let externalExamplesRoot = null;
for (const candidate of examplesRootCandidates) {
  if (await isDirectory(candidate)) {
    externalExamplesRoot = candidate;
    break;
  }
}

const externalExamplesDir = externalExamplesRoot ? path.join(externalExamplesRoot, 'examples') : null;
const externalIncludeDir = externalExamplesRoot ? path.join(externalExamplesRoot, 'include') : null;
const runtimeExamplesDir = path.join(runtimeRoot, 'examples');
const runtimeIncludeDir = path.join(runtimeRoot, 'include');

let exampleFiles = [];
let includeFiles = [];

if (externalExamplesDir && await isDirectory(externalExamplesDir)) {
  await cp(externalExamplesDir, runtimeExamplesDir, { recursive: true });
  exampleFiles = await listFiles(runtimeExamplesDir);
}

if (externalIncludeDir && await isDirectory(externalIncludeDir)) {
  await cp(externalIncludeDir, runtimeIncludeDir, { recursive: true });
  includeFiles = await listFiles(runtimeIncludeDir);
}

const manifest = {
  pythonFiles: await listFiles(path.join(runtimeRoot, 'funk')),
  stdlibFiles: await listFiles(path.join(runtimeRoot, 'stdlib')),
  exampleFiles,
  includeFiles,
  topLevelFiles: ['funky.py'],
};

await writeFile(path.join(runtimeRoot, 'manifest.json'), JSON.stringify(manifest, null, 2) + '\n', 'utf8');

const buildInfo = {
  builtAtUtc: new Date().toISOString(),
  git: {
    superproject: commitInfo(repoRoot),
    submodules: {
      funk: commitInfo(path.join(repoRoot, 'funk')),
      stdlib: commitInfo(path.join(repoRoot, 'stdlib')),
    },
  },
};

await writeFile(path.join(runtimeRoot, 'build-info.json'), JSON.stringify(buildInfo, null, 2) + '\n', 'utf8');
await writeFile(path.join(runtimeRoot, '.gitkeep'), '', 'utf8');
console.log('runtime synced:', runtimeRoot);
