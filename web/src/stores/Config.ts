import { create } from 'zustand'

interface ConfigState {
  speedUnit: string
  framework: string
  setSpeedUnit: (unit: string) => void
  setFramework: (framework: string) => void
}

export const useConfigStore = create<ConfigState>((set) => ({
  speedUnit: 'mph',
  framework: 'esx',
  setSpeedUnit: (unit) => set({ speedUnit: unit }),
  setFramework: (framework) => set({ framework }),
}))
