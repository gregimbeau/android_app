#!/bin/bash

# 1. Installer les dépendances
yarn install

# 2. Construire l'application Nuxt3
yarn build

# 3. Générer les fichiers statiques de l'application Nuxt3
npx nuxi generate

# Vérifier la présence du fichier index.html dans le répertoire correct
if [ ! -f dist/index.html ]; then
  echo "Error: index.html not found in the dist directory. Generate may have failed."
  exit 1
fi

# 4. Copier les fichiers générés dans le projet Capacitor
mkdir -p ./android/app/src/main/assets/public
cp -R dist/* ./android/app/src/main/assets/public/

# 5. Synchroniser Capacitor
npx cap sync

# 6. Naviguer vers le répertoire Android et construire l'APK
cd android
adb uninstall com.abrege.caisse
./gradlew clean
./gradlew assembleDebug

# 7. Installer l'APK sur l'appareil
adb install -r app/build/outputs/apk/debug/app-debug.apk

echo "APK successfully built and installed!"
