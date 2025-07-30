import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';
import Stack from '@mui/material/Stack';

import { Image } from 'src/components/image';

// ----------------------------------------------------------------------

const FASHION_CITIES = [
  {
    city: 'Bogotá Fashion District',
    designers: 45,
    style: 'Contemporary & Avant-Garde',
    image: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_600,h_400,c_fill/v1753881241/fu_041_w7ejur.jpg',
  },
  {
    city: 'Medellín Creative Quarter',
    designers: 38,
    style: 'Sustainable & Innovation',
    image: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_600,h_400,c_fill/v1753881240/fu_040_jf3cqa.jpg',
  },
  {
    city: 'Cartagena Heritage Studios',
    designers: 22,
    style: 'Resort & Artisanal',
    image: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_600,h_400,c_fill/v1753881239/fu_034_t4qeyk.jpg',
  },
  {
    city: 'Cali Design Hub',
    designers: 15,
    style: 'Dance & Movement',
    image: 'https://res.cloudinary.com/dzqy2ixl0/image/upload/f_auto,q_auto,w_600,h_400,c_fill/v1753881238/fu_020_qvzsyb.jpg',
  },
];

export function FashionCitiesGrid({ sx, ...other }) {
  return (
    <Box
      component="section"
      sx={[
        {
          py: { xs: 5, md: 10 },
          bgcolor: 'background.neutral',
        },
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      <Container>
        <Stack spacing={3} sx={{ mb: 5, textAlign: 'center' }}>
          <Typography variant="h2">Fashion Capitals of Colombia</Typography>
          <Typography sx={{ color: 'text.secondary', maxWidth: 600, mx: 'auto' }}>
            Each city brings its unique aesthetic and cultural heritage to Colombian fashion. 
            Discover designers by their creative neighborhoods.
          </Typography>
        </Stack>

        <Box
          sx={{
            gap: 3,
            display: 'grid',
            gridTemplateColumns: {
              xs: 'repeat(1, 1fr)',
              sm: 'repeat(2, 1fr)',
              md: 'repeat(4, 1fr)',
            },
          }}
        >
          {FASHION_CITIES.map((city) => (
            <Card key={city.city} sx={{ cursor: 'pointer' }}>
              <Box sx={{ position: 'relative' }}>
                <Image
                  alt={city.city}
                  src={city.image}
                  ratio="3/2"
                  sx={{
                    borderRadius: 0,
                  }}
                />
                <Box
                  sx={{
                    position: 'absolute',
                    bottom: 0,
                    left: 0,
                    right: 0,
                    p: 2,
                    background: 'linear-gradient(to top, rgba(0,0,0,0.8), transparent)',
                  }}
                >
                  <Typography variant="h6" sx={{ color: 'common.white' }}>
                    {city.designers} Designers
                  </Typography>
                </Box>
              </Box>
              <Box sx={{ p: 2.5 }}>
                <Typography variant="subtitle1" sx={{ mb: 0.5 }}>
                  {city.city}
                </Typography>
                <Typography variant="body2" sx={{ color: 'text.secondary' }}>
                  {city.style}
                </Typography>
              </Box>
            </Card>
          ))}
        </Box>
      </Container>
    </Box>
  );
}
