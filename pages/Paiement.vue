<template>
  <div class="flex flex-col w-full h-screen items-center justify-center">
    <h1 class="text-4xl font-bold">Page de Paiement</h1>
    <p class="text-xl mt-4">Veuillez entrer vos informations de paiement ci-dessous :</p>
    <form class="mt-6 space-y-4 w-1/2">
      <div>
        <label for="card-number" class="block text-lg">Numéro de carte</label>
        <input type="text" id="card-number" class="w-full px-4 py-2 border rounded" placeholder="1234 5678 9123 4567"/>
      </div>
      <div>
        <label for="expiry-date" class="block text-lg">Date d'expiration</label>
        <input type="text" id="expiry-date" class="w-full px-4 py-2 border rounded" placeholder="MM/AA"/>
      </div>
      <div>
        <label for="cvv" class="block text-lg">CVV</label>
        <input type="text" id="cvv" class="w-full px-4 py-2 border rounded" placeholder="123"/>
      </div>
      <button type="submit" class="w-full px-4 py-2 bg-green-500 text-white rounded">Payer</button>
    </form>
    <nuxt-link to="/menu" class="mt-6 px-4 py-2 bg-blue-500 text-white rounded">Retour au Menu</nuxt-link>
  </div>
</template>

<script setup>
</script>

<style scoped>
</style>
