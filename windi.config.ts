import { defineConfig } from "windicss/helpers"
import formsPlugin from "windicss/plugin/forms"

export default defineConfig({
  darkMode: "class",
  safelist: "p-3 p-4 p-5",
  theme: {
    extend: {
      spacing: {
        14: "3.5rem",
        72: "18rem",
        84: "21rem",
        96: "24rem",
        168: "42rem",
        192: "48rem",
      },
      colors: {},
    },
  },
  plugins: [formsPlugin],
})
