<template>
  <div class="bg-white dark:bg-gray-800 shadow rounded-lg p-4 transition-colors duration-300">
    <h2 class="text-2xl font-bold mb-4 text-gray-900 dark:text-gray-100">{{ $t('orderSummary.currentOrder') }}</h2>
    <ul>
      <li
        v-for="orderItem in orderItems"
        :key="orderItem.id"
        class="border-b last:border-none py-2 flex justify-between dark:border-gray-700">
        <span class="text-gray-900 dark:text-gray-100">{{ orderItem.name }} x{{ orderItem.quantity }}</span>
        <div>
          <span class="mr-4 text-gray-900 dark:text-gray-100">${{ orderItem.price * orderItem.quantity }}</span>
          <button
            class="bg-red-500 dark:bg-red-600 text-white px-2 py-1 rounded"
            @click="removeItem(orderItem)">
            {{ $t('orderSummary.remove') }}
          </button>
        </div>
      </li>
    </ul>
    <div class="mt-4 text-right text-xl font-bold text-gray-900 dark:text-gray-100">
      {{ $t('orderSummary.total') }}: ${{ totalAmount }}
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';
import { defineProps, defineEmits } from 'vue';
import { useI18n } from 'vue-i18n';

const { t } = useI18n();

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
