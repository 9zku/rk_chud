interface ThirstIconProps {
  percentage: number
}

const ThirstIcon = ({ percentage }: ThirstIconProps) => {
  const gradientId = `thirst-gradient-${Math.random().toString(36).substr(2, 9)}`
  const color = "#fff"

  return (
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 16 16">
      <defs>
        <linearGradient id={gradientId} x1="0%" y1="100%" x2="0%" y2="0%">
          <stop offset="0%" stopColor={color} stopOpacity="1" />
          <stop offset={`${percentage}%`} stopColor={color} stopOpacity="1" />
          <stop offset={`${percentage}%`} stopColor={color} stopOpacity="0.3" />
          <stop offset="100%" stopColor={color} stopOpacity="0.3" />
        </linearGradient>
      </defs>
      <path fill={`url(#${gradientId})`} d="M8 16a6 6 0 0 0 6-6c0-1.655-1.122-2.904-2.432-4.362C10.254 4.176 8.75 2.503 8 0c0 0-6 5.686-6 10a6 6 0 0 0 6 6M6.646 4.646l.708.708c-.29.29-1.128 1.311-1.907 2.87l-.894-.448c.82-1.641 1.717-2.753 2.093-3.13" />
    </svg>
  )
}

export default ThirstIcon
