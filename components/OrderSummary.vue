<template>
  <div class="bg-white shadow rounded-lg p-4">
    <h2 class="text-2xl font-bold mb-4">Current Order</h2>
    <ul>
      <li v-for="orderItem in orderItems" :key="orderItem.id" class="border-b last:border-none py-2 flex justify-between">
        <span>{{ orderItem.name }} x{{ orderItem.quantity }}</span>
        <div>
          <span class="mr-4">${{ orderItem.price * orderItem.quantity }}</span>
          <button class="bg-red-500 text-white px-2 py-1 rounded" @click="removeItem(orderItem)">Remove</button>
        </div>
      </li>
    </ul>
    <div class="mt-4 text-right text-xl font-bold">
      Total: ${{ totalAmount }}
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';
import { defineProps, defineEmits } from 'vue';

const props = defineProps({
  orderItems: {
    type: Array,
    required: true
  }
});

const emit = defineEmits(['removeItem']);

const removeItem = (item) => {
  emit('removeItem', item);
};

const totalAmount = computed(() => {
  return props.orderItems.reduce((total, item) => total + item.price * item.quantity, 0);
});
</script>
