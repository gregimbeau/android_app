<template>
  <div class="flex justify-between p-2 bg-white dark:bg-gray-800 rounded-lg shadow-md transition-colors duration-300">
    <span class="text-gray-900 dark:text-gray-100">{{ order.item }} x{{ order.quantity }}</span>
    <span class="text-gray-900 dark:text-gray-100">${{ order.price }}</span>
  </div>
</template>

<script setup>
const props = defineProps({
  order: {
    type: Object,
    required: true
  }
});
</script>
