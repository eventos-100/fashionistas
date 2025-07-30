import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';

import { paths } from 'src/routes/paths';
import { RouterLink } from 'src/routes/components';

import { Iconify } from 'src/components/iconify';

import { TravelTourItem } from './list/travel-tour-item';

// ----------------------------------------------------------------------

export function FashionDesignerShowcase({ designers, sx, ...other }) {
  const renderTexts = () => (
    <Box sx={{ textAlign: 'center' }}>
      <Typography variant="h2">Featured Designers</Typography>
      <Typography sx={{ mt: 3, color: 'grey.300' }}>
        {`Meet the talented professionals shaping Medellín's fashion scene!`}
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
      {designers.map((designer) => (
        <TravelTourItem key={designer.id} tour={designer} />
      ))}
    </Box>
  );

  return (
    <Box
      component="section"
      sx={[
        {
          py: { xs: 5, md: 10 },
          bgcolor: 'common.black',
          color: 'white',
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
            Join Our Community
          </Button>
        </Box>
      </Container>
    </Box>
  );
}