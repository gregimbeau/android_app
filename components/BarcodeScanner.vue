<template>
  <div class="fixed inset-0 bg-gray-800 bg-opacity-75 flex items-center justify-center z-50">
    <div class="bg-white dark:bg-gray-900 rounded-lg shadow-lg overflow-hidden relative w-4/5 h-3/4">
      <button @click="closeModal" class="absolute top-4 right-4 text-red-500 dark:text-red-300">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
        </svg>
      </button>
      <div class="flex flex-col items-center justify-center h-full text-gray-900 dark:text-gray-100">
        <video ref="video" class="video-feed mb-4"></video>
        <div v-if="scanning" class="flex flex-col items-center justify-center">
          <p class="text-center mb-4">Positionnez le code-barres devant la camera</p>
          <div class="loader mb-4"></div>
        </div>
        <div v-if="detectedBarcode" class="flex flex-col items-center justify-center">
          <p class="text-center mb-4">Code-barres détecté : {{ detectedBarcode }}</p>
          <button class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600" @click="confirmScan">Confirmer</button>
        </div>
        <button class="bg-red-500 text-white px-4 py-2 rounded absolute bottom-4 hover:bg-red-600" @click="stopScan">Arrêter le scan</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { BrowserMultiFormatReader } from '@zxing/library';

const emit = defineEmits(['close']);
const video = ref<HTMLVideoElement | null>(null);
const scanning = ref(true);
const detectedBarcode = ref('');
let codeReader: BrowserMultiFormatReader | null = null;

const startScan = async () => {
  if (!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia) {
    alert('Votre appareil ne supporte pas l\'accès à la caméra.');
    return;
  }

  codeReader = new BrowserMultiFormatReader();
  codeReader
    .decodeFromVideoDevice(undefined, video.value!, (result, err) => {
      if (result) {
        detectedBarcode.value = result.getText();
        scanning.value = false;
        stopScan();
        alert(`Code-barres détecté : ${detectedBarcode.value}`);
        closeModal();
      }
    })
    .catch(err => {
      console.error(err);
      alert('Erreur d\'accès à la caméra.');
    });
};

const stopScan = () => {
  if (codeReader) {
    codeReader.reset();
  }
  if (video.value && video.value.srcObject) {
    const stream = video.value.srcObject as MediaStream;
    const tracks = stream.getTracks();
    tracks.forEach(track => track.stop());
  }
};

const confirmScan = () => {
  alert(`Code-barres confirmé : ${detectedBarcode.value}`);
  closeModal();
};

const closeModal = () => {
  stopScan();
  emit('close');
};

onMounted(startScan);
onUnmounted(stopScan);
</script>

<style scoped>
.video-feed {
  width: 100%;
  height: auto;
}

.loader {
  border: 8px solid #f3f3f3; /* Light grey */
  border-top: 8px solid #3498db; /* Blue */
  border-radius: 50%;
  width: 60px;
  height: 60px;
  animation: spin 2s linear infinite;
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
