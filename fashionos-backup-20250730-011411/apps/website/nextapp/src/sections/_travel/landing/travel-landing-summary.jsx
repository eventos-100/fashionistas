import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';

import { CONFIG } from 'src/global-config';

import { Image } from 'src/components/image';
import { AnimateCountUp } from 'src/components/animate';

// ----------------------------------------------------------------------

const iconPath = (name) => `${CONFIG.assetsDir}/assets/icons/travel/${name}`;

const SUMMARY = [
  { total: 150, description: 'Fashion shows hosted', icon: iconPath('ic-tickets.svg') },
  { total: 5000, description: 'Tickets sold', icon: iconPath('ic-booking.svg') },
  { total: 25000, description: 'Fashion enthusiasts', icon: iconPath('ic-site-visitors.svg') },
  { total: 200, description: 'Designer partners', icon: iconPath('ic-verified-hotels.svg') },
];

// ----------------------------------------------------------------------

export function TravelLandingSummary({ sx, ...other }) {
  const renderTexts = () => (
    <Box sx={{ mx: 'auto', maxWidth: 480, mb: { xs: 5, md: 10 } }}>
      <Typography variant="h2">Your gateway to exclusive fashion events worldwide</Typography>
      <Typography sx={{ mt: 3, color: 'text.secondary' }}>
        Experience the glamour of high fashion with seamless booking for runway shows, designer showcases, and VIP fashion experiences
      </Typography>
    </Box>
  );

  const renderList = () => (
    <Box
      sx={{
        gap: 3,
        display: 'grid',
        gridTemplateColumns: { xs: 'repeat(2, 1fr)', md: 'repeat(4, 1fr)' },
      }}
    >
      {SUMMARY.map((value) => (
        <Box
          key={value.description}
          sx={{
            display: 'flex',
            alignItems: 'center',
            flexDirection: 'column',
            color: 'text.secondary',
          }}
        >
          <Image
            alt={value.description}
            src={value.icon}
            disablePlaceholder
            ratio="1/1"
            sx={{ mb: 3, width: 80 }}
          />

          <AnimateCountUp
            variant="h3"
            to={value.total}
            toFixed={2}
            sx={{ mb: 1, color: 'text.primary' }}
          />
          {value.description}
        </Box>
      ))}
    </Box>
  );

  return (
    <Box
      component="section"
      sx={[
        {
          textAlign: 'center',
          py: { xs: 5, md: 10 },
        },
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      <Container>
        {renderTexts()}
        {renderList()}
      </Container>
    </Box>
  );
}
