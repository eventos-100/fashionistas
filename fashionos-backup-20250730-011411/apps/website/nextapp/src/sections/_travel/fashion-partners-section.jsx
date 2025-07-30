import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';

import { paths } from 'src/routes/paths';
import { RouterLink } from 'src/routes/components';

import { Iconify } from 'src/components/iconify';

import { FashionPartnerItem } from './list/fashion-partner-item';

// ----------------------------------------------------------------------

export function FashionPartnersSection({ partners, sx, ...other }) {
  const renderTexts = () => (
    <Box sx={{ textAlign: 'center' }}>
      <Typography variant="h2">Join the Fashion Revolution</Typography>
      <Typography sx={{ mt: 3, color: 'text.secondary' }}>
        {`Be part of Medellín's most exclusive fashion event. Choose how you want to participate!`}
      </Typography>
    </Box>
  );

  const renderList = () => (
    <Box
      sx={{
        display: 'grid',
        gap: { xs: 4, md: 3 },
        my: { xs: 5, md: 10 },
        gridTemplateColumns: {
          xs: 'repeat(1, 1fr)',
          sm: 'repeat(2, 1fr)',
          md: 'repeat(3, 1fr)',
        },
      }}
    >
      {partners.map((partner) => (
        <FashionPartnerItem key={partner.id} partner={partner} />
      ))}
    </Box>
  );

  return (
    <Box
      component="section"
      sx={[
        {
          py: { xs: 5, md: 10 },
        },
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      <Container>
        {renderTexts()}
        {renderList()}

        <Box sx={{ textAlign: 'center' }}>
          <Button
            component={RouterLink}
            href={paths.travel.tours}
            size="large"
            variant="outlined"
            color="inherit"
            endIcon={<Iconify icon="carbon:chevron-right" />}
          >
            Learn More
          </Button>
        </Box>
      </Container>
    </Box>
  );
}