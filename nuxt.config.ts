// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: "2024-04-03",
  ssr: false,
  devtools: { enabled: true },
  modules: ["@nuxtjs/tailwindcss", "shadcn-nuxt", "@nuxtjs/i18n"],
  css: ["@/assets/css/global.css"],
  plugins: [{ src: "~/plugins/pwa-elements.client.ts", mode: "client" }],

  shadcn: {
    /**
     * Prefix for all the imported component
     */
    prefix: "",
    /**
     * Directory that the component lives in.
     * @default "./components/ui"
     */
    componentDir: "./components/ui",
  },
  i18n: {
    locales: [
      { code: "en", file: "en.json" },
      { code: "fr", file: "fr.json" },
    ],
    defaultLocale: "fr",
    langDir: "lang/",
  },
});