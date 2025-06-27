interface ArmourIconProps {
  percentage: number
}

const ArmourIcon = ({ percentage }: ArmourIconProps) => {
  const gradientId = `armour-gradient-${Math.random().toString(36).substr(2, 9)}`
  const color = "#fff"

  return (
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
      <defs>
        <linearGradient id={gradientId} x1="0%" y1="100%" x2="0%" y2="0%">
          <stop offset="0%" stopColor={color} stopOpacity="1" />
          <stop offset={`${percentage}%`} stopColor={color} stopOpacity="1" />
          <stop offset={`${percentage}%`} stopColor={color} stopOpacity="0.3" />
          <stop offset="100%" stopColor={color} stopOpacity="0.3" />
        </linearGradient>
      </defs>
      <path fill={`url(#${gradientId})`} d="M12 1L3 5v6c0 5.55 3.84 10.74 9 12c5.16-1.26 9-6.45 9-12V5z" />
    </svg>
  )
}

export default ArmourIcon
