<template>
  <div class="flex flex-col w-full h-screen items-center justify-center p-4 bg-gray-100 dark:bg-gray-900 text-gray-800 dark:text-gray-100 transition-colors duration-300">
    <h1 class="text-3xl font-medium mb-6">{{ $t('register.title') }}</h1>
    <form @submit.prevent="register" class="space-y-4 w-full max-w-md">
      <input
        type="text"
        v-model="username"
        :placeholder="$t('register.usernamePlaceholder')"
        class="block w-full p-4 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100"
        required />
      <input
        type="password"
        v-model="password"
        :placeholder="$t('register.passwordPlaceholder')"
        class="block w-full p-4 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100"
        required />
      <button
        type="submit"
        class="block w-full p-4 bg-green-500 dark:bg-green-700 text-white rounded-lg hover:bg-green-600 dark:hover:bg-green-800 transition">
        {{ $t('register.registerButton') }}
      </button>
    </form>
    <nuxt-link to="/login" class="mt-4 text-blue-500 dark:text-blue-300 hover:underline">
      {{ $t('register.loginLink') }}
    </nuxt-link>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { setToken } from '@/utils/storage';
import { Toast } from '@capacitor/toast';

const username = ref('');
const password = ref('');
const router = useRouter();

const register = async () => {
  if (username.value && password.value) {
    const userCredentials = JSON.stringify({ username: username.value, password: password.value });
    await setToken('userCredentials', userCredentials);
    await setToken('authToken', 'fake-jwt-token'); // Set an auth token to simulate login
    await Toast.show({ text: 'Registration and login successful' });
    router.push('/'); // Redirect to the home page
    window.dispatchEvent(new Event('auth-update'));
  } else {
    await Toast.show({ text: 'Please fill in all fields' });
  }
};
</script>

<style scoped>
input {
  outline: none;
  transition: border-color 0.3s;
}
input:focus {
  border-color: #3b82f6;
}
</style>
