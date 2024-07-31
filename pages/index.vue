<template>
  <div class="container mx-auto p-4">
    <h1 class="text-4xl font-bold mb-6">Restaurant POS System</h1>
    <div class="grid grid-cols-4 gap-4">
      <ItemButton v-for="item in menuItems" :key="item.id" :item="item" @addItem="addItemToOrder" />
    </div>
    <div class="mt-8">
      <OrderSummary :orderItems="orderItems" @removeItem="removeItemFromOrder" />
    </div>
    <div class="mt-8 flex space-x-4">
      <button class="bg-green-500 text-white px-4 py-2 rounded" @click="processPayment">Process Payment</button>
      <button class="bg-red-500 text-white px-4 py-2 rounded" @click="clearOrder">Clear Order</button>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import ItemButton from '~/components/ItemButton.vue';
import OrderSummary from '~/components/OrderSummary.vue';

const menuItems = ref([
  { id: 1, name: 'Pizza', price: 12 },
  { id: 2, name: 'Burger', price: 8 },
  { id: 3, name: 'Salad', price: 7 },
  { id: 4, name: 'Pasta', price: 10 },
  { id: 5, name: 'Soda', price: 3 },
  { id: 6, name: 'Coffee', price: 4 },
  // Add more items as needed
]);

const orderItems = ref([]);

const addItemToOrder = (item) => {
  const existingItem = orderItems.value.find(orderItem => orderItem.id === item.id);
  if (existingItem) {
    existingItem.quantity++;
  } else {
    orderItems.value.push({ ...item, quantity: 1 });
  }
};

const removeItemFromOrder = (item) => {
  const index = orderItems.value.findIndex(orderItem => orderItem.id === item.id);
  if (index !== -1) {
    if (orderItems.value[index].quantity > 1) {
      orderItems.value[index].quantity--;
    } else {
      orderItems.value.splice(index, 1);
    }
  }
};

const processPayment = () => {
  alert('Processing Payment');
};

const clearOrder = () => {
  orderItems.value = [];
};
</script>
