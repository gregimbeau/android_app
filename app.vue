<template>
  <div :class="{ dark: isDarkMode }">
    <div class="min-h-screen bg-white dark:bg-gray-900 text-black dark:text-white transition-colors duration-300">
      <header class="bg-gray-200 dark:bg-gray-800 p-4 flex justify-between items-center">
        <div>
          <button v-if="isAuthenticated" @click="logout" class="text-black dark:text-white">
            Logout
          </button>
          <button v-else @click="login" class="text-black dark:text-white">
            Login
          </button>
        </div>
        <div class="flex items-center space-x-4">
          <button @click="toggleDarkMode" class="text-black dark:text-white">
            {{ isDarkMode ? 'Light Mode' : 'Dark Mode' }}
          </button>
          <button @click="toggleLanguage" class="text-black dark:text-white">
            {{ currentLanguage }}
          </button>
        </div>
      </header>
      <LoadingScreen v-if="loading" />
      <NuxtPage v-else />
    </div>
  </div>
</template>

<script setup>
import { ref, onBeforeUnmount, onMounted, computed,watch } from 'vue';
import { useI18n } from 'vue-i18n';
import LoadingScreen from '@/components/LoadingScreen.vue';
import { SplashScreen } from '@capacitor/splash-screen';
import { Toast } from '@capacitor/toast';
import { getToken, removeToken } from '@/utils/storage';
import { defineCustomElements } from '@ionic/pwa-elements/loader';
import { useRouter } from 'vue-router';

defineCustomElements(window);

const { locale } = useI18n();
const isDarkMode = ref(localStorage.getItem('darkMode') === 'true');
const loading = ref(true);
const isAuthenticated = ref(false);
const $router = useRouter();

const toggleDarkMode = () => {
  isDarkMode.value = !isDarkMode.value;
  if (isDarkMode.value) {
    document.documentElement.classList.add('dark');
    localStorage.setItem('darkMode', 'true');
  } else {
    document.documentElement.classList.remove('dark');
    localStorage.setItem('darkMode', 'false');
  }
};

const toggleLanguage = () => {
  if (locale.value === 'fr') {
    locale.value = 'en';
  } else {
    locale.value = 'fr';
  }
  localStorage.setItem('language', locale.value);
};

const currentLanguage = computed(() => (locale.value === 'en' ? 'FR' : 'EN'));

const checkAuthentication = async () => {
  const token = await getToken('authToken');
  console.log("Token:", token);
  isAuthenticated.value = !!token;
  if (!token) {
    console.log("No token found, redirecting to login");
    await $router.push('/login'); // Utiliser $router
  }
};

const login = async () => {
  await $router.push('/login'); // Utiliser $router
};

const logout = async () => {
  await removeToken('authToken');
  isAuthenticated.value = false;
  await Toast.show({ text: 'Logout successful' });
  await $router.push('/login'); // Utiliser $router
};

const initializeApp = async () => {
  const hasShownLoadingScreen = localStorage.getItem('hasShownLoadingScreen') === 'true';

  if (!hasShownLoadingScreen) {
    localStorage.setItem('hasShownLoadingScreen', 'true'); // Set the flag to true
  }

  if (isDarkMode.value) {
    document.documentElement.classList.add('dark');
  }

  // Add a delay to simulate loading screen duration
  await new Promise(resolve => setTimeout(resolve, 3000));

  await SplashScreen.hide(); // Hide the splash screen after the delay

  await checkAuthentication();

  loading.value = false;

  // Listen for authentication updates
  window.addEventListener('auth-update', checkAuthentication);
};

onMounted(() => {
  const savedLocale = localStorage.getItem('language');
  if (savedLocale) {
    locale.value = savedLocale;
  }
});

onMounted(async () => {
  console.log("App mounted");
  await initializeApp();
});

watch(() => locale.value, (newLocale) => {
  localStorage.setItem('language', newLocale);
});

onBeforeUnmount(() => {
  // Clean up the event listener
  window.removeEventListener('auth-update', checkAuthentication);
});
</script>
