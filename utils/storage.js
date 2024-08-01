// src/utils/storage.js
import { Preferences } from "@capacitor/preferences";

export const setToken = async (key, token) => {
  await Preferences.set({
    key: key,
    value: token,
  });
};

export const getToken = async (key) => {
  const { value } = await Preferences.get({ key: key });
  return value;
};

export const removeToken = async (key) => {
  await Preferences.remove({ key: key });
};

export const clearStorage = async () => {
  await Preferences.clear();
};
