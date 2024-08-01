<template>
  <div class="container mx-auto p-4 max-w-lg bg-white dark:bg-gray-900 text-black dark:text-white transition-colors duration-300">
    <h1 class="text-2xl font-bold mb-4">Geolocation Page</h1>
    <div class="mb-4 flex justify-between">
      <button @click="getCurrentLocation" class="bg-blue-500 text-white px-4 py-2 rounded shadow-lg hover:bg-blue-600 transition">
        Get Current Location
      </button>
      <button @click="startTracking" class="bg-green-500 text-white px-4 py-2 rounded shadow-lg hover:bg-green-600 transition">
        Start Tracking
      </button>
      <button @click="stopTracking" class="bg-red-500 text-white px-4 py-2 rounded shadow-lg hover:bg-red-600 transition">
        Stop Tracking
      </button>
    </div>
    <div v-if="currentPosition" class="bg-gray-100 dark:bg-gray-800 p-4 rounded-lg shadow-md mb-4">
      <h2 class="text-xl font-semibold mb-2">Current Position:</h2>
      <p>Latitude: {{ currentPosition.coords.latitude }}</p>
      <p>Longitude: {{ currentPosition.coords.longitude }}</p>
      <p>Accuracy: {{ currentPosition.coords.accuracy }} meters</p>
      <p v-if="currentPosition.coords.altitude !== null">Altitude: {{ currentPosition.coords.altitude }} meters</p>
      <p v-if="currentPosition.coords.heading !== null">Heading: {{ currentPosition.coords.heading }} degrees</p>
      <p v-if="currentPosition.coords.speed !== null">Speed: {{ currentPosition.coords.speed }} m/s</p>
    </div>
    <div v-if="trackingPosition" class="bg-gray-100 dark:bg-gray-800 p-4 rounded-lg shadow-md mb-4">
      <h2 class="text-xl font-semibold mb-2">Tracking Position:</h2>
      <p>Latitude: {{ trackingPosition.coords.latitude }}</p>
      <p>Longitude: {{ trackingPosition.coords.longitude }}</p>
      <p>Accuracy: {{ trackingPosition.coords.accuracy }} meters</p>
      <p v-if="trackingPosition.coords.altitude !== null">Altitude: {{ trackingPosition.coords.altitude }} meters</p>
      <p v-if="trackingPosition.coords.heading !== null">Heading: {{ trackingPosition.coords.heading }} degrees</p>
      <p v-if="trackingPosition.coords.speed !== null">Speed: {{ trackingPosition.coords.speed }} m/s</p>
    </div>
    <div id="map" class="h-96 mt-4 rounded-lg shadow-lg"></div>
    <div class="fixed bottom-4 right-4">
      <button class="bg-blue-500 text-white p-4 rounded-full shadow-lg hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500" @click="redirectToIndex">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
        </svg>
      </button>
    </div>
  </div>
</template>


<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { Geolocation } from '@capacitor/geolocation';
import 'ol/ol.css';
import Map from 'ol/Map';
import View from 'ol/View';
import TileLayer from 'ol/layer/Tile';
import OSM from 'ol/source/OSM';
import { fromLonLat } from 'ol/proj';
import { toStringXY } from 'ol/coordinate';
import { Feature } from 'ol';
import { Point } from 'ol/geom';
import { Vector as VectorLayer } from 'ol/layer';
import { Vector as VectorSource } from 'ol/source';
import { Style, Icon } from 'ol/style';
import { useRouter } from "vue-router";

const router = useRouter();

type Position = {
  coords: {
    latitude: number;
    longitude: number;
    accuracy: number;
    altitude: number | null;
    altitudeAccuracy: number | null;
    heading: number | null;
    speed: number | null;
  };
  timestamp: number;
};

const currentPosition = ref<Position | null>(null);
const trackingPosition = ref<Position | null>(null);
let watchId: string | null = null;
let map: Map | null = null;
let vectorLayer: VectorLayer<VectorSource> | null = null;


const checkPermissions = async () => {
  let permission = await Geolocation.checkPermissions();
  
  if (permission.location !== 'granted' || permission.coarseLocation !== 'granted') {
    permission = await Geolocation.requestPermissions();
  }

  if (permission.location !== 'granted' && permission.coarseLocation !== 'granted') {
    console.error('Location permission not granted');
    return false;
  }

  return true;
};

const checkLocationServicesEnabled = async () => {
  try {
    const locationEnabled = await Geolocation.checkPermissions();
    if (!locationEnabled) {
      alert('Veuillez activer les services de localisation');
      return false;
    }
    return true;
  } catch (error) {
    console.error('Error checking location services:', error);
    return false;
  }
};

const initializeMap = () => {
  if (!map) {
    map = new Map({
      target: 'map',
      layers: [
        new TileLayer({
          source: new OSM(),
        }),
      ],
      view: new View({
        center: fromLonLat([0, 0]),
        zoom: 2,
      }),
    });

    vectorLayer = new VectorLayer({
      source: new VectorSource(),
      style: new Style({
        image: new Icon({
          anchor: [0.5, 1],
          src: 'https://openlayers.org/en/latest/examples/data/icon.png',
        }),
      }),
    });

    map.addLayer(vectorLayer);
  }
};

const updateMap = (latitude: number, longitude: number) => {
  if (map && vectorLayer) {
    const coordinates = fromLonLat([longitude, latitude]);
    map.getView().setCenter(coordinates);
    map.getView().setZoom(13);

    const feature = new Feature({
      geometry: new Point(coordinates),
    });

    vectorLayer.getSource().clear();
    vectorLayer.getSource().addFeature(feature);
  }
};

const getCurrentLocation = async () => {
  try {
    const position = await Geolocation.getCurrentPosition();
    currentPosition.value = position;
    console.log('Current position:', position);
    updateMap(position.coords.latitude, position.coords.longitude);
  } catch (error) {
    console.error('Error getting current position:', error);
  }
};

const startTracking = async () => {
  try {
    watchId = await Geolocation.watchPosition({}, (position, err) => {
      if (err) {
        console.error('Error watching position:', err);
        return;
      }
      trackingPosition.value = position;
      console.log('Tracking position:', position);
      updateMap(position.coords.latitude, position.coords.longitude);
    });
  } catch (error) {
    console.error('Error starting tracking:', error);
  }
};

const stopTracking = async () => {
  if (watchId) {
    await Geolocation.clearWatch({ id: watchId });
    watchId = null;
    trackingPosition.value = null;
    console.log('Stopped tracking');
  }
};

onMounted(async () => {
  const hasPermission = await checkPermissions();
  const locationEnabled = await checkLocationServicesEnabled();
  if (hasPermission && locationEnabled) {
    initializeMap();
  }
});

const redirectToIndex = () => {
  router.push({ name: "index" });
};

</script>

<style scoped>
#map {
  height: 24rem; /* h-96 */
  width: 100%;
  border-radius: 0.5rem; /* rounded-lg */
  box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.1); /* shadow-lg */
  margin-top: 1rem; /* mt-4 */
}
.container {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
}
</style>
