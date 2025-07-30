import Box from '@mui/material/Box';
import Card from '@mui/material/Card';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';

import { paths } from 'src/routes/paths';
import { RouterLink } from 'src/routes/components';

import { Image } from 'src/components/image';

// ----------------------------------------------------------------------

export function FashionPartnerItem({ partner, sx, ...other }) {
  return (
    <Card sx={sx} {...other}>
      <Box sx={{ position: 'relative', overflow: 'hidden' }}>
        <Image
          src={partner.coverUrl}
          alt={partner.location}
          ratio="4/3"
          sx={{
            transition: 'transform 0.3s',
            '&:hover': {
              transform: 'scale(1.05)',
            },
          }}
        />
      </Box>

      <Box sx={{ p: 3, textAlign: 'center' }}>
        <Typography variant="h5" sx={{ mb: 2 }}>
          {partner.location}
        </Typography>
        
        <Typography variant="body2" sx={{ color: 'text.secondary', mb: 3, minHeight: 60 }}>
          {partner.description}
        </Typography>

        <Button
          component={RouterLink}
          href={paths.travel.tours}
          variant="contained"
          color="primary"
          fullWidth
        >
          Get Started
        </Button>
      </Box>
    </Card>
  );
}
