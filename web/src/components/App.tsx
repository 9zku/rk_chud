import StatusHud from './hud/StatusHud'
import CarHud from './hud/CarHud'
import { usePlayerStore } from '../state/Player'
import { useVehicleStore } from '../state/Vehicle'
import { useConfigStore } from '../stores/Config'
import { useNuiEvent } from '../hooks/useNuiEvent'
import { useState } from 'react'

function App() {
  const { updateAll, playerLoaded, setPlayerLoaded } = usePlayerStore()
  const { setSpeed, setFuel, setRpm, setHealth, setInVehicle, inVehicle, setSeatbeltOn, setStreetName, setLocation, setDirection } = useVehicleStore()
  const { setSpeedUnit, setFramework } = useConfigStore()
  const [showHud, setShowHud] = useState(false)
  const [showCarHud, setShowCarHud] = useState(false)

  useNuiEvent<{
    health: number
    armour: number
    hunger: number
    thirst: number
    stamina: number
  }>('updateStatus', (data) => {
    updateAll(data)
    if (!playerLoaded) {
      setPlayerLoaded(true)
      setShowHud(true)
    }
  })

  useNuiEvent<{ inVehicle: boolean; speed: number; fuel: number; rpm: number; health: number; seatbeltOn: boolean; streetName: string; location: string; direction: string }>('setVehicleState', (data) => {
    setInVehicle(data.inVehicle)
    setSpeed(data.speed)
    setFuel(data.fuel)
    setRpm(data.rpm)
    setHealth(data.health)
    setSeatbeltOn(data.seatbeltOn)
    setStreetName(data.streetName || '')
    setLocation(data.location || '')
    setDirection(data.direction || '')
    
    if (data.inVehicle && playerLoaded) {
      setShowCarHud((prev) => prev)
    } else if (!data.inVehicle) {
      setShowCarHud(false)
    }
  })

  useNuiEvent<{ speedUnit: string; framework: string }>('setConfig', (data) => {
    setSpeedUnit(data.speedUnit)
    setFramework(data.framework)
  })

  useNuiEvent('showHud', () => {
    setShowHud(true)
  })

  useNuiEvent('hideHud', () => {
    setShowHud(false)
  })

  useNuiEvent('showCarHud', () => {
    setShowCarHud(true)
  })

  useNuiEvent('hideCarHud', () => {
    setShowCarHud(false)
  })

  return (
    <div className="min-h-screen">
      {showHud && playerLoaded && <StatusHud />}
      {inVehicle && showCarHud && playerLoaded && <CarHud />}
    </div>
  )
}

export default App
