<template>
  <button class="bg-blue-500 text-white p-4 rounded-lg w-full hover:bg-blue-600" @click="addItem">
    {{ item.name }} - ${{ item.price }}
  </button>
</template>

<script setup>
import { defineProps, defineEmits } from 'vue';

const props = defineProps({
  item: {
    type: Object,
    required: true
  }
});

const emit = defineEmits(['addItem']);

const addItem = () => {
  emit('addItem', props.item);
};
</script>
