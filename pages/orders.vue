<template>
  <div class="container mx-auto p-4 max-w-lg">
    <h1 class="text-2xl font-bold mb-4 text-gray-900 dark:text-white">
      {{ $t("orderHistory.title") }}
    </h1>
    <div v-if="orders.length" class="space-y-4">
      <div
        v-for="order in orders"
        :key="order.id"
        class="bg-white dark:bg-gray-800 rounded-lg shadow-md p-4">
        <div class="flex justify-between items-center">
          <div>
            <h2 class="text-lg font-semibold text-gray-900 dark:text-white">
              {{ $t("orderHistory.order") }} #{{ order.id }}
            </h2>
            <p class="text-sm text-gray-500 dark:text-gray-400">
              {{ order.date }}
            </p>
          </div>
        </div>
        <button
          @click="toggleDetails(order.id)"
          class="mt-2 text-blue-500 dark:text-blue-300 hover:underline">
          {{
            order.showDetails
              ? $t("orderHistory.closeDetails")
              : $t("orderHistory.viewDetails")
          }}
        </button>
        <transition name="fade">
          <div v-if="order.showDetails" class="mt-2">
            <p
              class="text-l font-semibold text-gray-900 dark:text-white underline mb-2">
              {{ $t("orderHistory.paymentDetails") }}
            </p>
            <div
              class="border p-4 rounded-lg bg-gray-100 dark:bg-gray-700 mb-2">
              <p class="text-gray-900 dark:text-white">
                <strong>{{ $t("orderHistory.fullName") }}:</strong>
                {{ order.billingDetails.fullName }}
              </p>
              <p class="text-gray-900 dark:text-white">
                <strong>{{ $t("orderHistory.address") }}:</strong>
                {{ order.billingDetails.address }}
              </p>
              <p class="text-gray-900 dark:text-white">
                <strong>{{ $t("orderHistory.city") }}:</strong>
                {{ order.billingDetails.city }}
              </p>
              <p class="text-gray-900 dark:text-white">
                <strong>{{ $t("orderHistory.zip") }}:</strong>
                {{ order.billingDetails.zip }}
              </p>
              <p class="text-gray-900 dark:text-white">
                <strong>{{ $t("orderHistory.country") }}:</strong>
                {{ order.billingDetails.country }}
              </p>
              <p class="text-gray-900 dark:text-white">
                <strong>{{ $t("orderHistory.paymentOption") }}:</strong>
                {{ order.paymentOption }}
              </p>
              <p class="text-gray-900 dark:text-white">
                <strong>{{ $t("orderHistory.amount") }}:</strong>
                {{ order.amount }}€
              </p>
            </div>
            <p
              class="text-l font-semibold text-gray-900 dark:text-white underline mb-2">
              {{ $t("orderHistory.orderDetails") }}
            </p>
            <div class="border p-4 rounded-lg bg-gray-100 dark:bg-gray-700">
              <ul class="mt-0 ml-2 mr-2">
                <li
                  v-for="item in order.items"
                  :key="item.id"
                  class="border-b py-0 flex justify-between dark:border-gray-700">
                  <span class="text-gray-900 dark:text-gray-100"
                    >{{ item.name }} x{{ item.quantity }}</span
                  >
                  <span class="text-gray-900 dark:text-gray-100"
                    >{{ item.price * item.quantity }}€</span
                  >
                </li>
              </ul>
            </div>
          </div>
        </transition>
      </div>
    </div>
    <div v-else class="text-gray-500 dark:text-gray-400">
      {{ $t("orderHistory.noOrders") }}
    </div>
  </div>
  <RoundButton />
</template>

<script setup>
import { ref, onMounted } from "vue";

const orders = ref([]);

const loadOrders = () => {
  const storedOrders = JSON.parse(localStorage.getItem("orders") || "[]");
  console.log("Loaded orders:", storedOrders); // Debug: Check the loaded orders
  orders.value = storedOrders.map((order) => ({
    ...order,
    showDetails: false, // Initialize showDetails to false
  }));
  console.log("Initialized orders:", orders.value); // Debug: Check initialized orders
};

const toggleDetails = (id) => {
  const order = orders.value.find((order) => order.id === id);
  if (order) {
    order.showDetails = !order.showDetails;
    console.log(`Toggled details for order ${id}:`, order.showDetails); // Debug: Check toggled state
  }
};

onMounted(loadOrders);
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.5s ease, max-height 0.5s ease;
}
.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  max-height: 0;
}
</style>
