<template>
  <nav class="bg-gray-800 p-4 text-white">
    <div class="container mx-auto flex justify-between items-center">
      <nuxt-link to="/" class="text-xl font-bold">Restaurant POS</nuxt-link>
      <div class="flex space-x-4">
        <nuxt-link to="/" class="hover:underline">Home</nuxt-link>
        <nuxt-link to="/orders" class="hover:underline">Orders</nuxt-link>
        <nuxt-link to="/menu" class="hover:underline">Menu</nuxt-link>
        <nuxt-link to="/settings" class="hover:underline">Settings</nuxt-link>
      </div>
    </div>
  </nav>
</template>
