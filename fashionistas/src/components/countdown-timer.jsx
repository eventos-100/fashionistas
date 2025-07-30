'use client';

import { useState, useEffect } from 'react';

import Box from '@mui/material/Box';
import Typography from '@mui/material/Typography';

// ----------------------------------------------------------------------

export function CountdownTimer({ targetDate }) {
  const [timeLeft, setTimeLeft] = useState({
    days: 0,
    hours: 0,
    minutes: 0,
    seconds: 0
  });

  useEffect(() => {
    const timer = setInterval(() => {
      const now = new Date().getTime();
      const target = new Date(targetDate).getTime();
      const difference = target - now;

      if (difference > 0) {
        setTimeLeft({
          days: Math.floor(difference / (1000 * 60 * 60 * 24)),
          hours: Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60)),
          minutes: Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60)),
          seconds: Math.floor((difference % (1000 * 60)) / 1000)
        });
      }
    }, 1000);

    return () => clearInterval(timer);
  }, [targetDate]);

  return (
    <Box sx={{ display: 'flex', gap: 4, justifyContent: 'center', my: 4 }}>
      {Object.entries(timeLeft).map(([unit, value]) => (
        <Box key={unit} sx={{ textAlign: 'center' }}>
          <Typography 
            variant="h2" 
            sx={{ 
              fontWeight: 'bold', 
              color: 'text.primary',
              fontSize: { xs: '2rem', md: '3rem' }
            }}
          >
            {String(value).padStart(2, '0')}
          </Typography>
          <Typography 
            variant="caption" 
            sx={{ 
              textTransform: 'uppercase',
              color: 'text.secondary',
              fontSize: '0.75rem',
              fontWeight: 'medium'
            }}
          >
            {unit}
          </Typography>
        </Box>
      ))}
    </Box>
  );
}
