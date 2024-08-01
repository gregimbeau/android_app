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
        <button @click="toggleDarkMode" class="text-black dark:text-white">
          {{ isDarkMode ? 'Light Mode' : 'Dark Mode' }}
        </button>
      </header>
      <LoadingScreen v-if="loading" />
      <NuxtPage v-else />
    </div>
  </div>
</template>

<script setup>
import { ref, watchEffect } from 'vue';
import LoadingScreen from '@/components/LoadingScreen.vue';
import { SplashScreen } from '@capacitor/splash-screen';
import { getToken, removeToken } from '@/utils/storage';
import { useRouter } from 'vue-router';

const isDarkMode = ref(localStorage.getItem('darkMode') === 'true');
const loading = ref(true);
const isAuthenticated = ref(false);
const router = useRouter();

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

const checkAuthentication = async () => {
  const token = await getToken('authToken');
  console.log("Token:", token);
  isAuthenticated.value = !!token;
  loading.value = false;
  if (!token) {
    console.log("No token found, redirecting to login");
    await router.push('/login');
  }
};

const login = async () => {
  await router.push('/login');
};

const logout = async () => {
  await removeToken('authToken');
  isAuthenticated.value = false;
  await router.push('/login');
};

watchEffect(async () => {
  await checkAuthentication();
});

onMounted(async () => {
  console.log("App mounted");
  await SplashScreen.hide();

  if (isDarkMode.value) {
    document.documentElement.classList.add('dark');
  }

  await checkAuthentication();

  // Listen for authentication updates
  window.addEventListener('auth-update', checkAuthentication);
});

onBeforeUnmount(() => {
  // Clean up the event listener
  window.removeEventListener('auth-update', checkAuthentication);
});

</script>

<style scoped>
/* Add any custom styles here */
</style>
