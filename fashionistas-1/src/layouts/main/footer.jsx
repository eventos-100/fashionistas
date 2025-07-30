import { varAlpha, isEqualPath } from 'minimal-shared/utils';

import Box from '@mui/material/Box';
import Link from '@mui/material/Link';
import Grid from '@mui/material/Grid';
import Divider from '@mui/material/Divider';
import { styled } from '@mui/material/styles';
import TextField from '@mui/material/TextField';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';
import IconButton from '@mui/material/IconButton';
import InputAdornment from '@mui/material/InputAdornment';
import Button, { buttonClasses } from '@mui/material/Button';

import { usePathname } from 'src/routes/hooks';
import { RouterLink } from 'src/routes/components';

import { Logo } from 'src/components/logo';
import { Iconify } from 'src/components/iconify';

import { pageLinks as listItems } from '../nav-config-main';

// ----------------------------------------------------------------------

// Fashion-specific social media links
const fashionSocials = [
  { 
    label: 'Instagram', 
    value: 'instagram',
    link: 'https://www.instagram.com/fashionistasme/'
  },
  { 
    label: 'Facebook', 
    value: 'facebook',
    link: 'https://www.facebook.com/fashionweeks'
  },
  { 
    label: 'YouTube', 
    value: 'youtube',
    link: 'https://www.youtube.com/@fashionistasca'
  },
  { 
    label: 'Twitter', 
    value: 'twitter',
    link: '#'
  }
];

// ----------------------------------------------------------------------

export function Footer({ layoutQuery = 'md', sx, ...other }) {
  const pathname = usePathname();

  const renderInfo = () => (
    <>
      <Box sx={{ mb: 2 }}>
        <img 
          src="https://res.cloudinary.com/dzqy2ixl0/image/upload/v1753830311/fashionistasB_tyuxuw.png" 
          alt="Fashionistas"
          style={{ height: 40, width: 'auto' }}
        />
      </Box>
      <Typography variant="body2" sx={{ maxWidth: 360, color: 'text.secondary' }}>
        Experience elegance and glamour in Medellín's ultimate Valentine's event.
      </Typography>
    </>
  );

  const renderContact = () => (
    <>
      <Typography variant="h6">Contact Us</Typography>
      <Box sx={{ gap: 1, display: 'flex', flexDirection: 'column', color: 'text.secondary' }}>
        <Typography variant="body2">📍 Skybox Medellín, Colombia</Typography>
        <Typography variant="body2">📱 (+57) 123-456-7890</Typography>
        <Typography variant="body2">✉️ contact@fashionistas.com</Typography>
      </Box>
    </>
  );

  const renderSubscribe = () => (
    <>
      <div>
        <Typography variant="h6" sx={{ mb: 1 }}>
          Stay Updated
        </Typography>
        <Typography
          variant="caption"
          sx={{ maxWidth: 360, display: 'block', color: 'text.secondary' }}
        >
          Subscribe to receive exclusive fashion event updates and VIP ticket offers.
        </Typography>
      </div>

      <TextField
        fullWidth
        hiddenLabel
        placeholder="Enter your email"
        sx={{ maxWidth: 420 }}
        slotProps={{
          input: {
            endAdornment: (
              <InputAdornment position="end">
                <Button variant="contained" color="inherit" size="large" sx={{ mr: -1.25 }}>
                  Subscribe Now
                </Button>
              </InputAdornment>
            ),
          },
        }}
      />
    </>
  );

  const renderSocials = () => (
    <>
      <Typography variant="h6">Follow Us</Typography>

      <Box sx={{ display: 'flex' }}>
        {fashionSocials.map((social) => (
          <IconButton 
            key={social.label}
            component="a"
            href={social.link}
            target="_blank"
            rel="noopener noreferrer"
          >
            {social.value === 'instagram' && <Iconify icon="socials:instagram" />}
            {social.value === 'facebook' && <Iconify icon="socials:facebook" />}
            {social.value === 'youtube' && <Iconify icon="socials:youtube" />}
            {social.value === 'twitter' && <Iconify icon="socials:twitter" />}
          </IconButton>
        ))}
      </Box>
    </>
  );

  const renderList = () => {
    // Filter to show only Fashion section
    const fashionSection = listItems.find(item => item.subheader === 'Fashion');
    
    if (!fashionSection) return null;
    
    return (
      <Box
        component="ul"
        sx={(theme) => ({
          columnGap: 2,
          display: 'none',
          [theme.breakpoints.up(layoutQuery)]: {
            display: 'block',
          },
        })}
      >
        <Box
          component="li"
          sx={{
            mb: 2,
            gap: 0.75,
            display: 'flex',
            breakInside: 'avoid',
            flexDirection: 'column',
            alignItems: 'flex-start',
          }}
        >
          <Typography variant="subtitle2">Quick Links</Typography>

          <Box component="ul" sx={{ gap: 'inherit', display: 'flex', flexDirection: 'column' }}>
            {fashionSection.items.slice(0, 6).map((item) => {
              const isActive = isEqualPath(item.path, pathname);

              return (
                <Box component="li" key={item.title} sx={{ display: 'inline-flex' }}>
                  <Link
                    component={RouterLink}
                    href={item.path}
                    variant="caption"
                    sx={{
                      color: 'text.secondary',
                      '&:hover': { color: 'text.primary' },
                      ...(isActive && { color: 'text.primary', fontWeight: 'fontWeightSemiBold' }),
                    }}
                  >
                    {item.title}
                  </Link>
                </Box>
              );
            })}
          </Box>
        </Box>
      </Box>
    );
  };

  const renderTop = () => (
    <Container
      sx={{
        pt: 10,
        pb: { xs: 5, md: 10 },
      }}
    >
      <Grid container spacing={3}>
        {/* LEFT COLUMN - Brand & Newsletter */}
        <Grid
          size={{ xs: 12, md: 4, lg: 4 }}
          sx={{
            display: 'flex',
            flexDirection: 'column',
            gap: { xs: 3, md: 5 },
          }}
        >
          <Box sx={[(theme) => ({ ...blockStyles(theme, layoutQuery) }), { gap: 3 }]}>
            {renderInfo()}
          </Box>

          <Box sx={[(theme) => ({ ...blockStyles(theme, layoutQuery) })]}>{renderSubscribe()}</Box>
        </Grid>

        {/* CENTER COLUMN - Quick Links */}
        <Grid component="nav" size={{ xs: 12, md: 4, lg: 4 }}>
          {renderList()}
        </Grid>

        {/* RIGHT COLUMN - Contact & Social */}
        <Grid
          size={{ xs: 12, md: 4, lg: 4 }}
          sx={{
            display: 'flex',
            flexDirection: 'column',
            gap: { xs: 3, md: 5 },
          }}
        >
          <Box sx={[(theme) => ({ ...blockStyles(theme, layoutQuery) }), { gap: 1 }]}>
            {renderContact()}
          </Box>

          <Box sx={[(theme) => ({ ...blockStyles(theme, layoutQuery) })]}>{renderSocials()}</Box>
        </Grid>
      </Grid>
    </Container>
  );

  const renderBottom = () => (
    <Container
      sx={{
        py: 3,
        gap: 2.5,
        display: 'flex',
        textAlign: 'center',
        color: 'text.secondary',
        justifyContent: 'space-between',
        flexDirection: { xs: 'column', md: 'row' },
      }}
    >
      <Typography variant="caption">© 2024 Fashionistas. All Rights Reserved.</Typography>

      <Box
        component="span"
        sx={{
          gap: 1.5,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
        }}
      >
        <Link variant="caption" color="inherit">
          Privacy Policy
        </Link>
        <Box
          sx={{
            width: 3,
            height: 3,
            opacity: 0.4,
            borderRadius: '50%',
            bgcolor: 'currentColor',
          }}
        />
        <Link variant="caption" color="inherit">
          Terms of Service
        </Link>
      </Box>
    </Container>
  );

  return (
    <Box
      component="footer"
      sx={[
        (theme) => ({
          borderTop: `solid 1px ${theme.vars.palette.divider}`,
        }),
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      {renderTop()}
      <Divider />
      {renderBottom()}
    </Box>
  );
}

// ----------------------------------------------------------------------

const blockStyles = (theme, layoutQuery) => ({
  gap: 2,
  display: 'flex',
  textAlign: 'center',
  alignItems: 'center',
  flexDirection: 'column',
  [theme.breakpoints.up(layoutQuery)]: {
    textAlign: 'left',
    alignItems: 'flex-start',
  },
});

// ----------------------------------------------------------------------

const AppStoreButton = styled(({ title, caption, ...other }) => (
  <Button {...other}>
    <div>
      <Box
        component="span"
        sx={{
          opacity: 0.72,
          display: 'block',
          textAlign: 'left',
          typography: 'caption',
        }}
      >
        {caption}
      </Box>

      <Box component="span" sx={{ mt: -0.5, typography: 'h6' }}>
        {title}
      </Box>
    </div>
  </Button>
))(({ theme }) => ({
  flexShrink: 0,
  padding: '5px 12px',
  color: theme.vars.palette.common.white,
  border: `solid 1px ${varAlpha(theme.vars.palette.common.blackChannel, 0.24)}`,
  background: `linear-gradient(180deg, ${theme.vars.palette.grey[900]}, ${theme.vars.palette.common.black})`,
  [`& .${buttonClasses.startIcon}`]: {
    marginLeft: 0,
  },
}));