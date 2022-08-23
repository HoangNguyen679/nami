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
      colors: {
        main: {
          default: "#60b0e2",
          200: "#6cc1ff",
          500: "#41a1dd",
          800: "#04609a",
        },
        dark: {
          400: "#8a8a8a",
          600: "#343538",
          700: "#2a2b2d",
          800: "#18191a",
        },
      },
    },
  },
  plugins: [formsPlugin],
})
