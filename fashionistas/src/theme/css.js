// ----------------------------------------------------------------------

export function bgBlur(props) {
  const color = props?.color || '#000000';
  const blur = props?.blur || 6;
  const opacity = props?.opacity || 0.8;

  return {
    backdropFilter: `blur(${blur}px)`,
    WebkitBackdropFilter: `blur(${blur}px)`,
    backgroundColor: `${color}${Math.round(opacity * 255)
      .toString(16)
      .padStart(2, '0')}`,
  };
}

// ----------------------------------------------------------------------

export function bgGradient(props) {
  const direction = props?.direction || 'to bottom';
  const startColor = props?.startColor;
  const endColor = props?.endColor;
  const color = props?.color;

  if (color) {
    return {
      backgroundImage: typeof color === 'function' 
        ? (theme) => `linear-gradient(${direction}, ${color(theme)})`
        : `linear-gradient(${direction}, ${color})`,
    };
  }

  return {
    backgroundImage: `linear-gradient(${direction}, ${startColor}, ${endColor})`,
  };
}

// ----------------------------------------------------------------------

export function textGradient(value) {
  return {
    background: `-webkit-linear-gradient(${value})`,
    WebkitBackgroundClip: 'text',
    WebkitTextFillColor: 'transparent',
  };
}

// ----------------------------------------------------------------------

export function hideScrollX() {
  return {
    msOverflowStyle: 'none',
    scrollbarWidth: 'none',
    overflowX: 'auto',
    '&::-webkit-scrollbar': {
      display: 'none',
    },
  };
}

// ----------------------------------------------------------------------

export function hideScrollY() {
  return {
    msOverflowStyle: 'none',
    scrollbarWidth: 'none',
    overflowY: 'auto',
    '&::-webkit-scrollbar': {
      display: 'none',
    },
  };
}
