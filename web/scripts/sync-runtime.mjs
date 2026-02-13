import { cp, mkdir, readdir, rm, writeFile } from 'node:fs/promises';
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

await rm(runtimeRoot, { recursive: true, force: true });
await mkdir(runtimeRoot, { recursive: true });

await cp(path.join(repoRoot, 'funk'), path.join(runtimeRoot, 'funk'), { recursive: true });
await cp(path.join(repoRoot, 'stdlib'), path.join(runtimeRoot, 'stdlib'), { recursive: true });
await cp(path.join(repoRoot, 'funky.py'), path.join(runtimeRoot, 'funky.py'));

const manifest = {
  pythonFiles: await listFiles(path.join(runtimeRoot, 'funk')),
  stdlibFiles: await listFiles(path.join(runtimeRoot, 'stdlib')),
  topLevelFiles: ['funky.py'],
};

await writeFile(path.join(runtimeRoot, 'manifest.json'), JSON.stringify(manifest, null, 2) + '\n', 'utf8');
await writeFile(path.join(runtimeRoot, '.gitkeep'), '', 'utf8');
console.log('runtime synced:', runtimeRoot);
