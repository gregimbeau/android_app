<template>
  <div class="loading-screen">
    <img src="@/assets/splash.png" alt="Loading" />
  </div>
</template>

<script setup>
</script>

<style scoped>
.loading-screen {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #92d090; /* Ou toute autre couleur de fond */
  z-index: 9999; /* Assurez-vous que c'est au-dessus de tout le reste */
}
</style>
