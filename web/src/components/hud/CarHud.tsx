import VehHealthIcon from '../icons/veh/HealthIcon'
import VehFuelIcon from '../icons/veh/FuelIcon'
import VehBeltIcon from '../icons/veh/BeltIcon'
import VehEngineIcon from '../icons/veh/EngineIcon'
import CompassIcon from '../icons/veh/CompassIcon'
import { useVehicleStore } from '../../state/Vehicle'
import { useConfigStore } from '../../stores/Config'

const NUM_BARS = 27;

const CarHud = () => {
  const { health, fuel, rpm, speed, seatbeltOn, streetName, location, direction } = useVehicleStore()
  const { speedUnit } = useConfigStore()
  
  const filledBars = Math.round((rpm / 100) * NUM_BARS);
  const engineColor = health < 20 ? '#ff3333' : 'rgba(200,200,200,0.3)';
  const engineClass = health < 20 ? 'animate-pulse' : '';
  const beltColor = seatbeltOn ? 'rgba(200,200,200,0.3)' : '#ff3333';
  const beltClass = seatbeltOn ? '' : 'animate-pulse';

  return (
    <>
      {/* MAP BORDER */}
      <div className="fixed bottom-8 left-4 2k:left-6 2k:bottom-10 4k:left-8 4k:bottom-12 w-minimap-border-w h-minimap-border-h 2k:w-minimap-border-w-2k 2k:h-minimap-border-h-2k 4k:w-minimap-border-w-4k 4k:h-minimap-border-h-4k border border-white rounded-lg">
        {/* COMPASS */}
        <div className="absolute -top-10 left-0 flex items-center gap-1">
          <div className="w-7 h-7">
            <CompassIcon />
          </div>
          <div className="flex flex-col text-white">
            <span className="text-xs font-semibold">{streetName}</span>
            <span className="text-xs text-gray-300">{location}</span>
          </div>
        </div>
        
        {/* DIRECTION TEXT */}
        <div className="absolute -top-8 right-1">
          <div className="text-white text-sm font-semibold">{direction}</div>
        </div>
      </div>
      
      {/* CAR HUD */}
      <div className="fixed bottom-4 right-4 flex items-end gap-1">
        <div className="flex flex-col items-start justify-end">
          <div className="flex flex-row justify-between items-center w-full mb-0.5">
            <div className="px-1.5 py-0.5 bg-gray-200/20 border border-gray-300/30 rounded flex items-center gap-0.5 select-none">
              <span className={`w-4 h-4 flex items-center justify-center ${beltClass}`}>
                <VehBeltIcon color={beltColor} />
              </span>
              <span className={`w-4 h-4 flex items-center justify-center ${engineClass}`}>
                <VehEngineIcon color={engineColor} />
              </span>
            </div>
            <div className="flex items-center gap-1">
              <span className="text-white text-md font-semibold">{speed}</span>
              <span className="text-cyan-300 text-[12px] font-semibold ml-0.3">{speedUnit.toUpperCase()}</span>
            </div>
          </div>
          {/* RPM BARS  */}
          <div className="flex flex-row gap-[2px] mb-1">
            {Array.from({ length: NUM_BARS }).map((_, i) => (
              <div
                key={i}
                className={`w-[4px] h-[45px] rounded-sm ${i < filledBars ? 'bg-gradient-to-r from-cyan-400 to-cyan-300' : 'bg-cyan-300/30'}`}
              />
            ))}
          </div>
          {/* HEALTH BAR */}
          <div className="w-40 h-1 bg-cyan-400/30 relative overflow-hidden mb-1">
            <div
              className="h-full bg-gradient-to-r from-cyan-400 to-cyan-300 transition-all duration-300 ease-in-out"
              style={{ width: `${health}%` }}
            ></div>
          </div>
        </div>
        
        {/* FUEL AND HEALTH ICONS */}
        <div className="flex flex-col items-center gap-1">
          {/* FUEL ICON */}
          <div className="w-[12px] h-[12px] flex items-center justify-center">
            <VehFuelIcon />
          </div>
          
          {/* FUEL BAR */}
          <div className="w-1.5 h-12 bg-red-900/30 overflow-hidden border border-red-700/20 relative">
            <div
              className="w-full bg-gradient-to-b from-red-700 to-red-600 transition-all duration-300 ease-in-out absolute bottom-0"
              style={{ height: `${fuel}%` }}
            ></div>
          </div>
          
          {/* HEALTH ICON */}
          <div className="w-[14px] h-[14px] flex items-center justify-center">
            <VehHealthIcon />
          </div>
        </div>
      </div>
    </>
  )
}

export default CarHud
