<template>
  <div
    class="container mx-auto p-4 bg-white dark:bg-gray-900 text-gray-800 dark:text-gray-100 transition-colors duration-300">
    <h1 class="text-4xl font-bold mb-6">{{ $t("caisse.title") }}</h1>
    <div class="grid grid-cols-4 gap-4">
      <ItemButton
        v-for="item in menuItems"
        :key="item.id"
        :item="item"
        @addItem="addItemToOrder" />
      <!-- Bouton pour ouvrir la modale de scan -->
      <div class="col-span-2">
        <div
          class="barcode-scanner bg-yellow-500 dark:bg-yellow-600 text-white flex items-center justify-center cursor-pointer rounded-2xl h-24"
          @click="openScannerModal">
          <span>{{ $t("caisse.scanBarcode") }}</span>
        </div>
      </div>
    </div>
    <div class="mt-8">
      <OrderSummary
        :orderItems="orderItems"
        @removeItem="removeItemFromOrder"
        class="text-gray-800 dark:text-gray-100" />
    </div>
    <div class="mt-8 flex space-x-4">
      <button
        class="bg-green-500 dark:bg-green-600 text-white px-4 py-2 rounded"
        @click="redirectToPayment">
        {{ $t("caisse.processPayment") }}
      </button>
      <button
        class="bg-red-500 dark:bg-red-600 text-white px-4 py-2 rounded"
        @click="clearOrder">
        {{ $t("caisse.clearOrder") }}
      </button>
    </div>
    <!-- Affiche la modale de scan si showScannerModal est true -->
    <BarcodeScannerModal
      v-if="showScannerModal"
      @close="showScannerModal = false" />
  </div>
  <RoundButton />
</template>

<script setup>
import { ref, onMounted } from "vue";
import ItemButton from "~/components/ItemButton.vue";
import OrderSummary from "~/components/OrderSummary.vue";
import BarcodeScannerModal from "~/components/BarcodeScanner.vue";
import RoundButton from "@/components/RoundButton.vue"; // Import the RoundButton component
import { navigateTo } from 'nuxt/app';

const menuItems = ref([
  { id: 1, name: "Pizza", price: 12 },
  { id: 2, name: "Burger", price: 8 },
  { id: 3, name: "Salad", price: 7 },
  { id: 4, name: "Pasta", price: 10 },
  { id: 5, name: "Soda", price: 3 },
  { id: 6, name: "Coffee", price: 4 },
  // Add more items as needed
]);

const orderItems = ref([]);
const showScannerModal = ref(false);

const saveOrderItemsToLocalStorage = () => {
  localStorage.setItem("orderItems", JSON.stringify(orderItems.value));
};

const addItemToOrder = (item) => {
  const existingItem = orderItems.value.find(
    (orderItem) => orderItem.id === item.id
  );
  if (existingItem) {
    existingItem.quantity++;
  } else {
    orderItems.value.push({ ...item, quantity: 1 });
  }
  updateTotalAmount();
  saveOrderItemsToLocalStorage(); // Sauvegarder dans le local storage après l'ajout
};

const removeItemFromOrder = (item) => {
  const index = orderItems.value.findIndex(
    (orderItem) => orderItem.id === item.id
  );
  if (index !== -1) {
    if (orderItems.value[index].quantity > 1) {
      orderItems.value[index].quantity--;
    } else {
      orderItems.value.splice(index, 1);
    }
  }
  updateTotalAmount();
  saveOrderItemsToLocalStorage(); // Sauvegarder dans le local storage après la suppression
};

const updateTotalAmount = () => {
  const total = orderItems.value.reduce(
    (total, item) => total + item.price * item.quantity,
    0
  );
  localStorage.setItem("totalAmount", total.toFixed(2)); // Sauvegarde du montant total dans le stockage local
};

const redirectToPayment = () => {
  updateTotalAmount(); // Mettre à jour le montant total avant de rediriger
  navigateTo('/paiement');
};

const clearOrder = () => {
  orderItems.value = [];
  updateTotalAmount();
  saveOrderItemsToLocalStorage(); // Sauvegarder dans le local storage après la suppression
};

const loadOrderItemsFromLocalStorage = () => {
  const storedItems = localStorage.getItem("orderItems");
  if (storedItems) {
    orderItems.value = JSON.parse(storedItems);
  }
};

const openScannerModal = () => {
  showScannerModal.value = true;
};

onMounted(() => {
  loadOrderItemsFromLocalStorage(); // Charger les éléments de la commande depuis le local storage lors du montage
  updateTotalAmount();
});

updateTotalAmount(); // Initialiser le montant total
</script>
