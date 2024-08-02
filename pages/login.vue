<template>
  <div class="flex flex-col w-full h-screen items-center justify-center p-4 bg-gray-100 dark:bg-gray-900 text-gray-800 dark:text-gray-100 transition-colors duration-300">
    <h1 class="text-3xl font-medium mb-6">{{ $t('login') }}</h1>
    <form @submit.prevent="login" class="space-y-4 w-full max-w-md">
      <input
        type="text"
        v-model="username"
        :placeholder="$t('username')"
        class="block w-full p-4 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100"
        required />
      <input
        type="password"
        v-model="password"
        :placeholder="$t('password')"
        class="block w-full p-4 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100"
        required />
      <button
        type="submit"
        class="block w-full p-4 bg-blue-500 dark:bg-blue-700 text-white rounded-lg hover:bg-blue-600 dark:hover:bg-blue-800 transition">
        {{ $t('loginButton') }}
      </button>
    </form>
    <nuxt-link to="/register" class="mt-4 text-blue-500 dark:text-blue-300 hover:underline">
      {{ $t('registerLink') }}
    </nuxt-link>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { setToken, getToken } from '@/utils/storage';
import { Toast } from '@capacitor/toast';

const username = ref('');
const password = ref('');
const router = useRouter();

const login = async () => {
  const userCredentials = await getToken('userCredentials');
  if (userCredentials) {
    const { username: storedUsername, password: storedPassword } = JSON.parse(userCredentials);
    if (username.value === storedUsername && password.value === storedPassword) {
      const token = 'fake-jwt-token';
      await setToken('authToken', token);
      await Toast.show({ text: 'Login successful' });
      router.push('/'); // Navigate to the home page
      window.dispatchEvent(new Event('auth-update'));
    } else {
      await Toast.show({ text: 'Invalid credentials' });
    }
  } else {
    await Toast.show({ text: 'No user registered. Please register first.' });
    router.push('/register');
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
