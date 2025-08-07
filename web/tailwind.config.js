/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      screens: {
        '2k': '2560px',
        '4k': '3840px',
      },
      spacing: {
        'minimap-border-w': '328px',
        'minimap-border-h': '200px',
        'minimap-border-w-2k': '437px',
        'minimap-border-h-2k': '267px',
        'minimap-border-w-4k': '656px',
        'minimap-border-h-4k': '400px',
      },
      fontFamily: {
        sans: ['Poppins', 'sans-serif'],
      },
    },
  },
  plugins: [],
}

