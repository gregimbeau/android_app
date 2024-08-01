// plugins/pwa-elements.client.ts
import { defineNuxtPlugin } from "#app";
import { defineCustomElements } from "@ionic/pwa-elements/loader";

export default defineNuxtPlugin(() => {
  defineCustomElements(window);
});
