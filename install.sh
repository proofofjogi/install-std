#!/bin/sh

# INSTALL SVELTE
pnpm create svelte@latest frontend
cd frontend
pnpm install

# dependencies

# install tailwindCSS
pnpm install -D tailwindcss postcss autoprefixer
pnpx tailwindcss init -p

# install daisyUI
pnpm i -D daisyui@latest

# isntall pocketbase sdk
pnpm install pocketbase --save

# make tailwind files
rm svelte.config.js

# prepare svelte config file
cat <<EOL > svelte.config.js
import adapter from '@sveltejs/adapter-auto';
import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';
/** @type {import('@sveltejs/kit').Config} */
const config = {
  kit: {
    adapter: adapter()
  },
  preprocess: vitePreprocess()
};
export default config;
EOL

# prepare tailwind config file
cat <<EOL > tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{html,js,svelte,ts}'],
  theme: {
    extend: {}
  },
  plugins: [
    require('daisyui'),
  ],
  daisyui: {
    themes: ["light", "dark"],
  },
};
EOL

# create CSS file
cat <<EOL > ./src/app.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

# create layout file
cat <<EOL > ./src/routes/+layout.svelte
<script>
  import "../app.css";
</script>

<slot />
EOL




# fire VSCode
code .
