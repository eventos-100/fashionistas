import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';
import Stack from '@mui/material/Stack';

import { Iconify } from 'src/components/iconify';

// ----------------------------------------------------------------------

const DESIGNER_SERVICES = [
  {
    title: 'Custom Couture',
    description: 'Commission bespoke pieces tailored to your exact measurements and vision',
    icon: 'mdi:needle-thread',
  },
  {
    title: 'Private Consultations',
    description: 'Book one-on-one sessions with designers for styling and wardrobe curation',
    icon: 'mdi:calendar-check',
  },
  {
    title: 'Runway Access',
    description: 'Secure front-row seats and backstage passes to exclusive fashion shows',
    icon: 'mdi:walk',
  },
  {
    title: 'B2B Wholesale',
    description: 'Connect with designers for bulk orders and retail partnerships',
    icon: 'mdi:handshake',
  },
  {
    title: 'Virtual Fittings',
    description: 'Experience AI-powered fitting sessions from anywhere in the world',
    icon: 'mdi:camera-iris',
  },
  {
    title: 'International Shipping',
    description: 'Worldwide delivery with customs handling and luxury packaging',
    icon: 'mdi:airplane',
  },
];

export function FashionDesignerServices({ sx, ...other }) {
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
        <Stack spacing={3} sx={{ mb: 5, textAlign: 'center' }}>
          <Typography variant="h2">Designer Services</Typography>
          <Typography sx={{ color: 'text.secondary', maxWidth: 600, mx: 'auto' }}>
            Connect with Colombian designers through our comprehensive platform. 
            From custom pieces to virtual consultations, we facilitate every interaction.
          </Typography>
        </Stack>

        <Box
          sx={{
            gap: 3,
            display: 'grid',
            gridTemplateColumns: {
              xs: 'repeat(1, 1fr)',
              sm: 'repeat(2, 1fr)',
              md: 'repeat(3, 1fr)',
            },
          }}
        >
          {DESIGNER_SERVICES.map((service) => (
            <Card key={service.title} sx={{ p: 3, textAlign: 'center' }}>
              <Iconify
                icon={service.icon}
                width={48}
                sx={{ color: 'primary.main', mb: 2 }}
              />
              <Typography variant="h6" sx={{ mb: 1 }}>
                {service.title}
              </Typography>
              <Typography variant="body2" sx={{ color: 'text.secondary' }}>
                {service.description}
              </Typography>
            </Card>
          ))}
        </Box>
      </Container>
    </Box>
  );
}
