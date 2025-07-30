'use client';

import { mergeClasses } from 'minimal-shared/utils';

import Link from '@mui/material/Link';
import { styled, useTheme } from '@mui/material/styles';

import { RouterLink } from 'src/routes/components';

import { logoClasses } from './classes';

// ----------------------------------------------------------------------

export function Logo({ sx, disabled, className, href = '/', isSingle = false, ...other }) {
  const theme = useTheme();

  const singleLogo = (
    <img
      src="https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_64,h_64,c_fit/v1753882356/branding/fashionistas-logo.png"
      alt="FashionOS"
      style={{ width: '100%', height: '100%', objectFit: 'contain' }}
    />
  );

  const fullLogo = (
    <img
      src="https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_200,h_56,c_fit/v1753882356/branding/fashionistas-logo.png"
      alt="FashionOS"
      style={{ width: '100%', height: '100%', objectFit: 'contain' }}
    />
  );

  return (
    <LogoRoot
      component={RouterLink}
      href={href}
      aria-label="Logo"
      underline="none"
      className={mergeClasses([logoClasses.root, className])}
      sx={[
        {
          width: 64,
          height: 64,
          ...(!isSingle && { width: 200, height: 56 }),
          ...(disabled && { pointerEvents: 'none' }),
        },
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      {isSingle ? singleLogo : fullLogo}
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
