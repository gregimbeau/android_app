<template>
  <div class="flex flex-col w-full h-screen items-center justify-center p-4 bg-gray-100 dark:bg-gray-900 text-gray-800 dark:text-gray-100 transition-colors duration-300">
    <h1 class="text-3xl font-medium mb-6">Register</h1>
    <form @submit.prevent="register" class="space-y-4 w-full max-w-md">
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
        class="block w-full p-4 bg-green-500 dark:bg-green-700 text-white rounded-lg hover:bg-green-600 dark:hover:bg-green-800 transition">
        Register
      </button>
    </form>
    <nuxt-link to="/login" class="mt-4 text-blue-500 dark:text-blue-300 hover:underline">
      Already have an account? Login here
    </nuxt-link>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { setToken } from '@/utils/storage'; // Ensure storage.js is in the utils folder

const username = ref('');
const password = ref('');
const router = useRouter();

const register = async () => {
  if (username.value && password.value) {
    const userCredentials = JSON.stringify({ username: username.value, password: password.value });
    await setToken('userCredentials', userCredentials);
    alert('Registration successful');
    // Simulate login
    await setToken('authToken', 'dummy-auth-token'); // Set an auth token to simulate login
    router.push('/'); // Redirect to the /index page
  } else {
    alert('Please fill in all fields');
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
