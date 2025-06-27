import { useState, useEffect } from 'react'
import HealthIcon from '../icons/status/HealthIcon'
import ArmourIcon from '../icons/status/ArmourIcon'
import HungerIcon from '../icons/status/HungerIcon'
import StaminaIcon from '../icons/status/StaminaIcon'
import ThirstIcon from '../icons/status/ThirstIcon'
import { usePlayerStore } from '../../state/Player'
import { useVehicleStore } from '../../state/Vehicle'
import { useConfigStore } from '../../stores/Config'

const StatusHud = () => {
  const { health, armour, hunger, thirst, stamina } = usePlayerStore()
  const { inVehicle } = useVehicleStore()
  const { framework } = useConfigStore()
  const [showArmour, setShowArmour] = useState(armour > 0)
  const [isAnimating, setIsAnimating] = useState(false)
  const [isEntering, setIsEntering] = useState(false)
  const [isLoaded, setIsLoaded] = useState(false)

  // Check if hunger and thirst should be shown based on framework
  const showHungerThirst = framework !== 'standalone'

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsLoaded(true)
    }, 500)

    return () => clearTimeout(timer)
  }, [])

  useEffect(() => {
    if (armour > 0 && !showArmour) {
      setShowArmour(true)
      setIsEntering(true)
      setIsAnimating(true)
      setTimeout(() => {
        setIsEntering(false)
        setIsAnimating(false)
      }, 300)
    } else if (armour === 0 && showArmour) {
      setIsAnimating(true)
      setTimeout(() => {
        setShowArmour(false)
        setIsAnimating(false)
      }, 300)
    }
  }, [armour, showArmour])

  const renderStatusItem = (Icon: any, value: number, isVehicle: boolean) => (
    <div className="flex flex-col items-center gap-1">
      <div className={`flex items-center justify-center transition-all duration-300 ease-out ${
        isVehicle ? 'w-4 h-4' : 'w-5 h-5'
      }`}>
        <Icon percentage={value} />
      </div>
      <span className={`text-white transition-all duration-300 ease-out ${
        isVehicle ? 'text-[10px]' : 'text-[11px]'
      }`}>{value}%</span>
    </div>
  )

  const renderArmourItem = (isVehicle: boolean) => {
    if (!showArmour) return null
    
    return (
      <div 
        className={`flex flex-col items-center gap-1 transition-all duration-300 ease-in-out ${
          isEntering 
            ? 'opacity-0 transform translate-x-2 scale-95' 
            : isAnimating && armour === 0 
              ? 'opacity-0 transform -translate-x-2 scale-95' 
              : 'opacity-100 transform translate-x-0 scale-100'
        }`}
      >
        <div className={`flex items-center justify-center transition-all duration-300 ease-out ${
          isVehicle ? 'w-4 h-4' : 'w-5 h-5'
        }`}>
          <ArmourIcon percentage={armour} />
        </div>
        <span className={`text-white transition-all duration-300 ease-out ${
          isVehicle ? 'text-[10px]' : 'text-[11px]'
        }`}>{armour}%</span>
      </div>
    )
  }

  if (inVehicle) {
    // HUD POSITONING FOR IN VEH
    return (
      <div className={`fixed left-[calc(17.6%+1rem)] flex flex-col items-start gap-2 transition-all duration-500 ease-out ${
        showArmour ? 'bottom-6' : 'bottom-10'
      } ${isLoaded ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'}`}>
        {renderStatusItem(HealthIcon, health, true)}
        {renderArmourItem(true)}
        {showHungerThirst && renderStatusItem(HungerIcon, hunger, true)}
        {showHungerThirst && renderStatusItem(ThirstIcon, thirst, true)}
        {renderStatusItem(StaminaIcon, stamina, true)}
      </div>
    )
  }

  return (
    <div className={`fixed bottom-2 left-4 flex items-center gap-6 transition-all duration-500 ease-out ${
      isLoaded ? 'opacity-100 translate-y-0' : 'opacity-0 translate-y-4'
    }`}>
      {renderStatusItem(HealthIcon, health, false)}
      {renderArmourItem(false)}
      {showHungerThirst && renderStatusItem(HungerIcon, hunger, false)}
      {showHungerThirst && renderStatusItem(ThirstIcon, thirst, false)}
      {renderStatusItem(StaminaIcon, stamina, false)}
    </div>
  )
}

export default StatusHud
