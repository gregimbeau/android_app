<template>
  <div class="flex flex-col w-full h-screen items-center justify-center p-4 bg-gray-100 dark:bg-gray-900 text-gray-800 dark:text-gray-100 transition-colors duration-300">
    <h1 class="text-3xl font-medium mb-6">Projet Test Abrege Caisse</h1>
    <div class="grid grid-cols-1 gap-4 w-full max-w-md">
      <nuxt-link
        to="/caisse"
        class="block p-4 text-center bg-blue-500 dark:bg-blue-700 text-white rounded-lg hover:bg-blue-600 dark:hover:bg-blue-800 transition">
        Caisse
      </nuxt-link>
      <nuxt-link
        to="/paiement"
        class="block p-4 text-center bg-purple-500 dark:bg-purple-700 text-white rounded-lg hover:bg-purple-600 dark:purple:bg-blue-800 transition">
        Page de paiement
      </nuxt-link>
      <nuxt-link
        to="/orders"
        class="block p-4 text-center bg-orange-500 dark:bg-orange-700 text-white rounded-lg hover:bg-orange-600 dark:hover:bg-orange-800 transition">
        Page des commandes
      </nuxt-link>
      <nuxt-link
        to="/geolocation"
        class="block p-4 text-center bg-yellow-500 dark:bg-yellow-700 text-white rounded-lg hover:bg-yellow-600 dark:hover:bg-yellow-800 transition">
        Page de Geolocation
      </nuxt-link>
      <nuxt-link
        to="/login"
        class="block p-4 text-center bg-green-500 dark:bg-green-700 text-white rounded-lg hover:bg-green-600 dark:hover:bg-green-800 transition">
        Page de login
      </nuxt-link>
      <div class="block p-4 text-center bg-gray-200 dark:bg-gray-700 text-gray-700 dark:text-gray-200 rounded-lg">
        Ceci est un projet de test des fonctionnalités de capacitor
      </div>

    </div>
    
  </div>

</template>

<script setup></script>
