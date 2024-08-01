<template>
  <div class="container mx-auto p-4 max-w-lg">
    <h1 class="text-2xl font-bold mb-4">Page de Paiement</h1>
    <h2 class="text-xl font-semibold mb-4">Montant à payer : {{ totalAmount }}€</h2>

    <!-- Formulaire de paiement -->
    <form @submit.prevent="processPayment" class="space-y-4">
      <!-- Informations de facturation -->
      <div>
        <h2 class="text-lg font-semibold mb-2">Informations de facturation</h2>
        <div class="grid grid-cols-1 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Nom complet</label>
            <input
              type="text"
              v-model="billingDetails.fullName"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-indigo-200 dark:focus:ring-indigo-500 focus:border-indigo-300 dark:bg-gray-800 dark:text-gray-300"
              required />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Adresse</label>
            <input
              type="text"
              v-model="billingDetails.address"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-indigo-200 dark:focus:ring-indigo-500 focus:border-indigo-300 dark:bg-gray-800 dark:text-gray-300"
              required />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Ville</label>
            <input
              type="text"
              v-model="billingDetails.city"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-indigo-200 dark:focus:ring-indigo-500 focus:border-indigo-300 dark:bg-gray-800 dark:text-gray-300"
              required />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Code postal</label>
            <input
              type="text"
              v-model="billingDetails.zip"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-indigo-200 dark:focus:ring-indigo-500 focus:border-indigo-300 dark:bg-gray-800 dark:text-gray-300"
              required />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Pays</label>
            <input
              type="text"
              v-model="billingDetails.country"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-indigo-200 dark:focus:ring-indigo-500 focus:border-indigo-300 dark:bg-gray-800 dark:text-gray-300"
              required />
          </div>
        </div>
      </div>

      <!-- Informations de la carte de crédit -->
      <div>
        <h2 class="text-lg font-semibold mb-2">Informations de la carte de crédit</h2>
        <div class="grid grid-cols-1 gap-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Numéro de carte</label>
            <input
              type="text"
              v-model="paymentDetails.cardNumber"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-indigo-200 dark:focus:ring-indigo-500 focus:border-indigo-300 dark:bg-gray-800 dark:text-gray-300"
              required />
          </div>
          <div class="flex space-x-4">
            <div class="flex-1">
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">Date d'expiration</label>
              <input
                type="text"
                v-model="paymentDetails.expiryDate"
                placeholder="MM/YY"
                class="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-indigo-200 dark:focus:ring-indigo-500 focus:border-indigo-300 dark:bg-gray-800 dark:text-gray-300"
                required />
            </div>
            <div class="flex-1">
              <label class="block text-sm font-medium text-gray-700 dark:text-gray-300">CVV</label>
              <input
                type="text"
                v-model="paymentDetails.cvv"
                class="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-indigo-200 dark:focus:ring-indigo-500 focus:border-indigo-300 dark:bg-gray-800 dark:text-gray-300"
                required />
            </div>
          </div>
        </div>
      </div>

      <!-- Options de paiement -->
      <div>
        <h2 class="text-lg font-semibold mb-2">Options de paiement</h2>
        <div class="grid grid-cols-1 gap-4">
          <div class="flex items-center">
            <input
              id="paymentOptionCard"
              type="radio"
              v-model="paymentOption"
              value="card"
              class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 dark:text-indigo-400 border-gray-300 dark:border-gray-600" />
            <label for="paymentOptionCard" class="ml-3 block text-sm font-medium text-gray-700 dark:text-gray-300">Carte de crédit</label>
          </div>
          <div class="flex items-center">
            <input
              id="paymentOptionPaypal"
              type="radio"
              v-model="paymentOption"
              value="paypal"
              class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 dark:text-indigo-400 border-gray-300 dark:border-gray-600" />
            <label for="paymentOptionPaypal" class="ml-3 block text-sm font-medium text-gray-700 dark:text-gray-300">PayPal</label>
          </div>
          <div class="flex items-center">
            <input
              id="paymentOptionBank"
              type="radio"
              v-model="paymentOption"
              value="bank"
              class="focus:ring-indigo-500 h-4 w-4 text-indigo-600 dark:text-indigo-400 border-gray-300 dark:border-gray-600" />
            <label for="paymentOptionBank" class="ml-3 block text-sm font-medium text-gray-700 dark:text-gray-300">Transfert bancaire</label>
          </div>
        </div>
      </div>

      <!-- Boutons de soumission et annulation -->
      <div class="flex space-x-4">
        <button
          type="submit"
          class="w-full bg-indigo-600 text-white px-4 py-2 rounded-md shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
          Payer
        </button>
        <button
          type="button"
          class="w-full bg-gray-600 text-white px-4 py-2 rounded-md shadow-sm hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-500"
          @click="cancelPayment">
          Annuler
        </button>
      </div>
    </form>

    <!-- Modale de confirmation de paiement -->
    <div
      v-if="showModal"
      class="fixed inset-0 bg-gray-800 bg-opacity-75 flex items-center justify-center z-50">
      <div
        class="bg-white dark:bg-gray-900 rounded-lg shadow-lg overflow-hidden relative w-4/5 max-w-md">
        <div class="p-6">
          <h2 class="text-2xl font-semibold mb-4">Paiement réussi</h2>
          <p class="mb-4">
            Voulez-vous que le ticket vous soit envoyé par email ?
          </p>
          <div v-if="emailPrompt">
            <input
              type="email"
              v-model="email"
              placeholder="Votre adresse email"
              class="mt-1 block w-full px-3 py-2 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring focus:ring-indigo-200 dark:focus:ring-indigo-500 focus:border-indigo-300 dark:bg-gray-800 dark:text-gray-300 mb-4"
              required />
            <button
              class="bg-green-500 text-white px-4 py-2 rounded mr-2"
              @click="sendReceipt">
              Envoyer
            </button>
            <button
              class="bg-red-500 text-white px-4 py-2 rounded"
              @click="cancelEmail">
              Annuler
            </button>
          </div>
          <div v-else>
            <button
              class="bg-green-500 text-white px-4 py-2 rounded mr-2"
              @click="promptEmail">
              Oui
            </button>
            <button
              class="bg-red-500 text-white px-4 py-2 rounded"
              @click="skipEmail">
              Non
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modale de message -->
    <div
      v-if="showMessage"
      class="fixed inset-0 bg-gray-800 bg-opacity-75 flex items-center justify-center z-50">
      <div
        class="bg-white dark:bg-gray-900 rounded-lg shadow-lg overflow-hidden relative w-4/5 max-w-md">
        <div class="p-6 text-center">
          <p class="mb-4">{{ message }}</p>
          <button
            class="bg-blue-500 text-white px-4 py-2 rounded"
            @click="returnToPOS">
            Retour à la caisse
          </button>
        </div>
      </div>
    </div>
  </div>
  <div class="fixed bottom-4 right-4">
    <button
      class="bg-blue-500 text-white p-4 rounded-full shadow-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500"
      @click="redirectToIndex">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        class="h-6 w-6"
        fill="none"
        viewBox="0 0 24 24"
        stroke="currentColor"
        stroke-width="2">
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          d="M10 19l-7-7m0 0l7-7m-7 7h18" />
      </svg>
    </button>
  </div>
</template>


<script setup>
import { ref, onMounted } from "vue";
import { useRouter } from "vue-router";

const totalAmount = ref(0);
const router = useRouter();

const showModal = ref(false);
const showMessage = ref(false);
const emailPrompt = ref(false);
const email = ref("");
const message = ref("");

onMounted(() => {
  const storedAmount = localStorage.getItem("totalAmount");
  if (storedAmount) {
    totalAmount.value = parseFloat(storedAmount);
  }
});

const billingDetails = ref({
  fullName: "",
  address: "",
  city: "",
  zip: "",
  country: "",
});

const paymentDetails = ref({
  cardNumber: "",
  expiryDate: "",
  cvv: "",
});

const paymentOption = ref("card");

const processPayment = () => {
  const order = {
    id: Date.now(),
    billingDetails: billingDetails.value,
    paymentDetails: paymentDetails.value,
    paymentOption: paymentOption.value,
    amount: totalAmount.value,
    date: new Date().toLocaleString(),
  };

  // Store order in localStorage
  let orders = JSON.parse(localStorage.getItem("orders") || "[]");
  orders.push(order);
  localStorage.setItem("orders", JSON.stringify(orders));

  showModal.value = true;
};

const promptEmail = () => {
  emailPrompt.value = true;
};

const sendReceipt = () => {
  message.value = `Ticket de caisse bien envoyé à l'adresse email ${email.value}`;
  emailPrompt.value = false;
  showModal.value = false;
  showMessage.value = true;
};

const cancelEmail = () => {
  message.value = "Vous avez annulé l'envoi du ticket de caisse par email";
  emailPrompt.value = false;
  showModal.value = false;
  showMessage.value = true;
};

const skipEmail = () => {
  message.value = "Vous avez annulé l'envoi du ticket de caisse par email";
  showModal.value = false;
  showMessage.value = true;
};

const returnToPOS = () => {
  localStorage.removeItem("orderItems");
  localStorage.removeItem("totalAmount");
  showMessage.value = false;
  router.push({ name: "caisse" });
};

const cancelPayment = () => {
  router.back();
};

const redirectToIndex = () => {
  router.push({ name: "index" });
};
</script>
