import { create } from 'zustand'

interface VehicleState {
  health: number
  fuel: number
  rpm: number
  speed: number
  seatbeltOn: boolean
  inVehicle: boolean
  streetName: string
  location: string
  direction: string
  setHealth: (health: number) => void
  setFuel: (fuel: number) => void
  setRpm: (rpm: number) => void
  setSpeed: (speed: number) => void
  setSeatbeltOn: (on: boolean) => void
  setInVehicle: (inVehicle: boolean) => void
  setStreetName: (name: string) => void
  setLocation: (location: string) => void
  setDirection: (direction: string) => void
}

export const useVehicleStore = create<VehicleState>((set) => ({
  health: 100,
  fuel: 75,
  rpm: 70,
  speed: 100,
  seatbeltOn: true,
  inVehicle: false,
  streetName: '',
  location: '',
  direction: '',
  setHealth: (health) => set({ health }),
  setFuel: (fuel) => set({ fuel }),
  setRpm: (rpm) => set({ rpm }),
  setSpeed: (speed) => set({ speed }),
  setSeatbeltOn: (on) => set({ seatbeltOn: on }),
  setInVehicle: (inVehicle) => set({ inVehicle }),
  setStreetName: (name) => set({ streetName: name }),
  setLocation: (location) => set({ location }),
  setDirection: (direction) => set({ direction }),
}))
