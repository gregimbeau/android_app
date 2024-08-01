<template>
  <div class="flex flex-col w-full h-screen items-center justify-center p-4 bg-gray-100 dark:bg-gray-900 text-gray-800 dark:text-gray-100 transition-colors duration-300">
    <h1 class="text-3xl font-medium mb-6">Login</h1>
    <form @submit.prevent="login" class="space-y-4 w-full max-w-md">
      <input
        type="text"
        v-model="username"
        placeholder="Username"
        class="block w-full p-4 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100"
        required />
      <input
        type="password"
        v-model="password"
        placeholder="Password"
        class="block w-full p-4 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100"
        required />
      <button
        type="submit"
        class="block w-full p-4 bg-blue-500 dark:bg-blue-700 text-white rounded-lg hover:bg-blue-600 dark:hover:bg-blue-800 transition">
        Login
      </button>
    </form>
    <nuxt-link to="/register" class="mt-4 text-blue-500 dark:text-blue-300 hover:underline">
      Don't have an account? Register here
    </nuxt-link>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { setToken, getToken } from '@/utils/storage';

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
      router.push('/');
    } else {
      alert('Invalid credentials');
    }
  } else {
    alert('No user registered. Please register first.');
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
