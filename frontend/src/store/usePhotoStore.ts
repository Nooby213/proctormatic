// src/store/usePhotoStore.ts
import { create } from "zustand";

interface PhotoState {
  photoStep8: string | null;
  photoStep9: string | null;
  maskedIDPhoto: string | null;
  setPhotoStep8: (photo: string | null) => void;
  setPhotoStep9: (photo: string | null) => void;
  setMaskedIDPhoto: (photo: string | null) => void;
}

export const usePhotoStore = create<PhotoState>((set) => ({
  photoStep8: null,
  photoStep9: null,
  maskedIDPhoto: null,
  setPhotoStep8: (photo) => set({ photoStep8: photo }),
  setPhotoStep9: (photo) => set({ photoStep9: photo }),
  setMaskedIDPhoto: (photo) => set({ maskedIDPhoto: photo }),
}));
