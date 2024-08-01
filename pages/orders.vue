<template>
  <div class="container mx-auto p-4 max-w-lg">
    <h1 class="text-2xl font-bold mb-4 text-gray-900 dark:text-white">Historique des commandes</h1>
    <div v-if="orders.length" class="space-y-4">
      <div v-for="order in orders" :key="order.id" class="bg-white dark:bg-gray-800 rounded-lg shadow-md p-4">
        <div class="flex justify-between items-center">
          <div>
            <h2 class="text-lg font-semibold text-gray-900 dark:text-white">Commande #{{ order.id }}</h2>
            <p class="text-sm text-gray-500 dark:text-gray-400">{{ order.date }}</p>
          </div>
          <p class="text-lg font-bold text-gray-900 dark:text-white">{{ order.amount }}€</p>
        </div>
        <button @click="toggleDetails(order.id)" class="mt-2 text-blue-500 dark:text-blue-300 hover:underline">Voir les détails</button>
        <div v-if="order.showDetails" class="mt-2">
          <p class="text-gray-900 dark:text-white"><strong>Nom complet:</strong> {{ order.billingDetails.fullName }}</p>
          <p class="text-gray-900 dark:text-white"><strong>Adresse:</strong> {{ order.billingDetails.address }}</p>
          <p class="text-gray-900 dark:text-white"><strong>Ville:</strong> {{ order.billingDetails.city }}</p>
          <p class="text-gray-900 dark:text-white"><strong>Code postal:</strong> {{ order.billingDetails.zip }}</p>
          <p class="text-gray-900 dark:text-white"><strong>Pays:</strong> {{ order.billingDetails.country }}</p>
          <p class="text-gray-900 dark:text-white"><strong>Option de paiement:</strong> {{ order.paymentOption }}</p>
        </div>
      </div>
    </div>
    <div v-else class="text-gray-500 dark:text-gray-400">Aucune commande passée.</div>
  </div>
  <div class="fixed bottom-4 right-4">
    <button
      class="bg-blue-500 text-white p-4 rounded-full shadow-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
      @click="redirectToIndex">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        class="h-6 w-6"
        fill="none"
        viewBox="0 0 24 24"
        stroke="currentColor"
        stroke-width="2">
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          d="M10 19l-7-7m0 0l7-7m-7 7h18" />
      </svg>
    </button>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import { useRouter } from "vue-router";

const router = useRouter();

const orders = ref([]);

const loadOrders = () => {
  orders.value = JSON.parse(localStorage.getItem('orders') || '[]');
};

const toggleDetails = (id) => {
  const order = orders.value.find(order => order.id === id);
  if (order) {
    order.showDetails = !order.showDetails;
  }
};

onMounted(loadOrders);

const redirectToIndex = () => {
  router.push({ name: "index" });
};
</script>
