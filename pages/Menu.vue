<template>
  <div class="flex flex-col w-full h-screen items-center justify-center">
    <h1 class="text-4xl font-bold">Menu</h1>
    <p class="text-xl mt-4">Sélectionnez une option du menu ci-dessous :</p>
    <ul class="mt-6 space-y-4">
      <li>
        <nuxt-link to="/accueil" class="block px-4 py-2 bg-green-500 text-white rounded">Accueil</nuxt-link>
      </li>
      <li>
        <nuxt-link to="/paiement" class="block px-4 py-2 bg-green-500 text-white rounded">Page de Paiement</nuxt-link>
      </li>
    </ul>
  </div>
</template>

<script setup>
</script>

<style scoped>
</style>
