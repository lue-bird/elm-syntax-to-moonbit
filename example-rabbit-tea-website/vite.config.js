import { defineConfig } from 'vite'
import rabbitTEA from 'rabbit-tea-vite'

export default defineConfig({
    plugins: [
        rabbitTEA()
    ]
})