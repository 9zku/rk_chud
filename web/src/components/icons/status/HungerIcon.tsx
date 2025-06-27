interface HungerIconProps {
  percentage: number
}

const HungerIcon = ({ percentage }: HungerIconProps) => {
  const gradientId = `hunger-gradient-${Math.random().toString(36).substr(2, 9)}`
  const color = "#fff"

  return (
    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 512 512">
      <defs>
        <linearGradient id={gradientId} x1="0%" y1="100%" x2="0%" y2="0%">
          <stop offset="0%" stopColor={color} stopOpacity="1" />
          <stop offset={`${percentage}%`} stopColor={color} stopOpacity="1" />
          <stop offset={`${percentage}%`} stopColor={color} stopOpacity="0.3" />
          <stop offset="100%" stopColor={color} stopOpacity="0.3" />
        </linearGradient>
      </defs>
      <path fill={`url(#${gradientId})`} d="M61.1 224C45 224 32 211 32 194.9c0-1.9.2-3.7.6-5.6C37.9 168.3 78.8 32 256 32s218.1 136.3 223.4 157.3c.5 1.9.6 3.7.6 5.6c0 16.1-13 29.1-29.1 29.1zm82.9-96a16 16 0 1 0-32 0a16 16 0 1 0 32 0m240 16a16 16 0 1 0 0-32a16 16 0 1 0 0 32M272 96a16 16 0 1 0-32 0a16 16 0 1 0 32 0M16 304c0-26.5 21.5-48 48-48h384c26.5 0 48 21.5 48 48s-21.5 48-48 48H64c-26.5 0-48-21.5-48-48m16 96c0-8.8 7.2-16 16-16h416c8.8 0 16 7.2 16 16v16c0 35.3-28.7 64-64 64H96c-35.3 0-64-28.7-64-64z" />
    </svg>
  )
}

export default HungerIcon
