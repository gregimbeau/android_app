<template>
  <div class="flex justify-between">
    <span>{{ order.item }} x{{ order.quantity }}</span>
    <span>${{ order.price }}</span>
  </div>
</template>

<script setup>
defineProps({
  order: {
    type: Object,
    required: true
  }
});
</script>
