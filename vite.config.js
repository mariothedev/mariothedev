import { defineConfig } from 'vite'

export default defineConfig({
  // Vite uses index.html as the entry point automatically.
  // base: './',                 // uncomment if you serve from a sub-path (e.g. user.github.io/folio/)
  build: { outDir: 'dist' },
  preview: {
    host: true,                  // bind 0.0.0.0 so the container is reachable from outside
    port: 4173,
    allowedHosts: ['mariothedev.com', 'www.mariothedev.com'],
    // simpler option — allow any host (fine for a static personal site):
    // allowedHosts: true,
  },
})
