import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';

// ----------------------------------------------------------------------

export function FashionDesignerHero({ sx, ...other }) {
  return (
    <Box
      component="section"
      sx={[
        {
          pt: { xs: 3, md: 5 },
          pb: { xs: 3, md: 5 },
          bgcolor: 'background.neutral',
        },
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      <Container>
        <Box sx={{ textAlign: 'center', maxWidth: 800, mx: 'auto' }}>
          <Typography variant="h1" sx={{ mb: 2 }}>
            Curated Colombian Couture
          </Typography>
          
          <Typography variant="h5" sx={{ mb: 3, color: 'text.secondary', fontWeight: 400 }}>
            Where Heritage Meets Haute Couture in Latin America
          </Typography>
          
          <Typography sx={{ color: 'text.secondary' }}>
            Access Colombia's most exclusive fashion houses and visionary designers. Book custom pieces, 
            runway shows, and private consultations through our AI-powered platform. Trusted by 500+ 
            international clients and featured in Vogue, Elle, and Harper's Bazaar.
          </Typography>
        </Box>
      </Container>
    </Box>
  );
}
