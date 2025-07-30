import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';
import Stack from '@mui/material/Stack';

import { bgGradient } from 'src/theme/styles';

import { Image } from 'src/components/image';

// ----------------------------------------------------------------------

export function FashionDesignerSpotlight({ designer, sx, ...other }) {
  return (
    <Box
      component="section"
      sx={[
        {
          position: 'relative',
          overflow: 'hidden',
          borderRadius: 2,
          mb: 5,
        },
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      <Box
        sx={{
          ...bgGradient({
            color: (theme) =>
              `to right, ${theme.vars.palette.grey[900]} 25%, ${theme.vars.palette.common.black}`,
          }),
          height: { xs: 400, md: 500 },
          position: 'relative',
        }}
      >
        <Image
          alt="Designer spotlight"
          src="https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_1920,h_600,c_fill/v1753881164/fu_044_jekphp.jpg"
          sx={{
            position: 'absolute',
            width: 1,
            height: 1,
            objectFit: 'cover',
            opacity: 0.48,
          }}
        />

        <Container
          sx={{
            height: 1,
            display: 'flex',
            alignItems: 'center',
            position: 'relative',
            zIndex: 9,
          }}
        >
          <Stack spacing={3} sx={{ maxWidth: 600 }}>
            <Typography variant="overline" sx={{ color: 'primary.main' }}>
              Designer Spotlight • This Week
            </Typography>

            <Typography variant="h2" sx={{ color: 'common.white' }}>
              Silvia Tcherassi
            </Typography>

            <Typography variant="h5" sx={{ color: 'grey.300', fontWeight: 400 }}>
              "Fashion is about dreaming and making other people dream"
            </Typography>

            <Typography sx={{ color: 'grey.400' }}>
              Celebrating 30 years of tropical glamour. Discover the new Resort 2025 collection 
              featuring sustainable fabrics and artisanal Colombian craftsmanship.
            </Typography>

            <Stack direction="row" spacing={2}>
              <Button
                size="large"
                variant="contained"
                sx={{
                  bgcolor: 'common.white',
                  color: 'grey.900',
                  '&:hover': {
                    bgcolor: 'grey.100',
                  },
                }}
              >
                Explore Collection
              </Button>
              <Button
                size="large"
                variant="outlined"
                sx={{
                  color: 'common.white',
                  borderColor: 'common.white',
                  '&:hover': {
                    borderColor: 'common.white',
                    bgcolor: 'rgba(255,255,255,0.08)',
                  },
                }}
              >
                Book Consultation
              </Button>
            </Stack>
          </Stack>
        </Container>
      </Box>
    </Box>
  );
}
