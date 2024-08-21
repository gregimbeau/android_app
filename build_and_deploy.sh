#!/bin/bash

# 1. Nettoyer le cache de Yarn
yarn cache clean

# 2. Installer les dépendances
yarn install

# 3. Construire l'application Nuxt3
yarn build

# 4. Nettoyer le dossier output/public avant la génération
rm -rf .output/public/

# 5. Générer les fichiers statiques de l'application Nuxt3
npx nuxi generate

# 6. Vérifier la présence du fichier index.html dans le répertoire correct
if [ ! -f .output/public/index.html ]; then
  echo "Error: index.html not found in the .output/public directory. Generate may have failed."
  exit 1
fi

# 7. Nettoyer le dossier public de Capacitor
rm -rf ./android/app/src/main/assets/public/*

# 8. Copier les fichiers générés dans le projet Capacitor
mkdir -p ./android/app/src/main/assets/public
cp -R .output/public/* ./android/app/src/main/assets/public/

# 9. Synchroniser Capacitor
npx cap sync

# 10. Naviguer vers le répertoire Android et construire l'APK
cd android
adb uninstall com.android.caisse
./gradlew clean
./gradlew assembleDebug

# 11. Installer l'APK sur l'appareil
adb install -r app/build/outputs/apk/debug/app-debug.apk

echo "APK successfully built and installed!"
