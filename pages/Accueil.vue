<template>
  <div
    class="flex flex-col w-full h-screen items-center justify-center p-4 bg-gray-100">
    <h1 class="text-3xl font-medium mb-6">Projet Test de la caisse</h1>
    <div class="grid grid-cols-1 gap-4 w-full max-w-md">
      <nuxt-link
        to="/"
        class="block p-4 text-center bg-blue-500 text-white rounded-lg hover:bg-blue-600">
        Index
      </nuxt-link>
      <nuxt-link
        to="/paiement"
        class="block p-4 text-center bg-blue-500 text-white rounded-lg hover:bg-blue-600">
        Faire la page de paiement
      </nuxt-link>
      <div class="block p-4 text-center bg-gray-200 text-gray-700 rounded-lg">
        Puis essayer des fonctionnalités de capacitor
      </div>
    </div>
  </div>

  <div class="flex flex-col w-full h-screen items-center justify-center">
    <h1 class="text-4xl font-bold">Menu</h1>
    <p class="text-xl mt-4">Sélectionnez une option du menu ci-dessous :</p>
    <ul class="mt-6 space-y-4">
      <li>
        <nuxt-link
          to="/accueil"
          class="block px-4 py-2 bg-blue-500 text-white rounded"
          >Accueil</nuxt-link
        >
      </li>
      <li>
        <nuxt-link
          to="/paiement"
          class="block px-4 py-2 bg-green-500 text-white rounded"
          >Page de Paiement</nuxt-link
        >
      </li>
    </ul>
  </div>
</template>

<script setup></script>
