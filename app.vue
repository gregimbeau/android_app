<template>
  <div>
    <LoadingScreen v-if="showLoadingScreen" />
    <NuxtPage v-else />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import LoadingScreen from '@/components/LoadingScreen.vue';
import { SplashScreen } from '@capacitor/splash-screen';

onMounted(async () => {
  // Masquer le splash screen après que l'application est prête
  await SplashScreen.hide();
});

const showLoadingScreen = ref(true);

onMounted(() => {
  setTimeout(() => {
    showLoadingScreen.value = false;
  }, 3000); // Affiche l'image pendant 3 secondes
});
</script>
