import { create } from 'zustand'

interface PlayerState {
  health: number
  armour: number
  hunger: number
  thirst: number
  stamina: number
  playerLoaded: boolean
  setHealth: (health: number) => void
  setArmour: (armour: number) => void
  setHunger: (hunger: number) => void
  setThirst: (thirst: number) => void
  setStamina: (stamina: number) => void
  setPlayerLoaded: (loaded: boolean) => void
  updateAll: (stats: Partial<Omit<PlayerState, 'setHealth' | 'setArmour' | 'setHunger' | 'setThirst' | 'setStamina' | 'setPlayerLoaded'>>) => void
}

export const usePlayerStore = create<PlayerState>((set) => ({
  health: 100,
  armour: 5,
  hunger: 100,
  thirst: 100,
  stamina: 100,
  playerLoaded: false,
  setHealth: (health) => set({ health }),
  setArmour: (armour) => set({ armour }),
  setHunger: (hunger) => set({ hunger }),
  setThirst: (thirst) => set({ thirst }),
  setStamina: (stamina) => set({ stamina }),
  setPlayerLoaded: (playerLoaded) => set({ playerLoaded }),
  updateAll: (stats) => set((state) => ({ ...state, ...stats })),
}))
