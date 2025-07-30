'use client';

import { mergeClasses } from 'minimal-shared/utils';
import Link from '@mui/material/Link';
import { styled } from '@mui/material/styles';
import { RouterLink } from 'src/routes/components';
import { logoClasses } from './classes';

// ----------------------------------------------------------------------

export function Logo({ sx, disabled, className, href = '/', isSingle = false, ...other }) {
  return (
    <LogoRoot
      component={RouterLink}
      href={href}
      aria-label="Fashionistas Logo"
      underline="none"
      className={mergeClasses([logoClasses.root, className])}
      sx={[
        {
          width: isSingle ? 64 : 180,
          height: isSingle ? 64 : 60,
          ...(disabled && { pointerEvents: 'none' }),
        },
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      <img 
        src={isSingle ? "/fashionistas_icon.jpg" : "/fashionistaslogo.png"}
        alt="Fashionistas"
        style={{ 
          width: '100%', 
          height: '100%', 
          objectFit: 'contain' 
        }}
      />
    </LogoRoot>
  );
}

// ----------------------------------------------------------------------

const LogoRoot = styled(Link)(() => ({
  flexShrink: 0,
  color: 'inherit',
  display: 'inline-flex',
  verticalAlign: 'middle',
}));
