import { varAlpha } from 'minimal-shared/utils';

import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Container from '@mui/material/Container';
import TextField from '@mui/material/TextField';
import Typography from '@mui/material/Typography';
import InputAdornment from '@mui/material/InputAdornment';

import { Iconify } from 'src/components/iconify';

// ----------------------------------------------------------------------

export function FashionNewsletter({ sx, ...other }) {
  return (
    <Box
      component="section"
      sx={[
        (theme) => ({
          py: 10,
          position: 'relative',
          bgcolor: 'grey.900',
        }),
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      <Container>
        <Box sx={{ textAlign: 'center', maxWidth: 600, mx: 'auto' }}>
          <Typography variant="h3" sx={{ mb: 2, color: 'common.white' }}>
            Join the Fashion Elite
          </Typography>
          
          <Typography sx={{ mb: 4, color: 'grey.400' }}>
            Receive exclusive invitations to runway shows, private sales, and designer 
            collaborations. Be the first to discover new collections and emerging talent.
          </Typography>

          <Box sx={{ display: 'flex', gap: 1, flexDirection: { xs: 'column', sm: 'row' } }}>
            <TextField
              fullWidth
              hiddenLabel
              placeholder="Enter your email"
              slotProps={{
                input: {
                  startAdornment: (
                    <InputAdornment position="start">
                      <Iconify width={24} icon="carbon:email" sx={{ color: 'text.disabled' }} />
                    </InputAdornment>
                  ),
                  sx: {
                    color: 'common.white',
                    '&::placeholder': {
                      color: 'grey.500',
                    },
                  },
                },
              }}
              sx={{
                '& fieldset': {
                  borderColor: 'grey.700',
                },
              }}
            />
            <Button
              size="large"
              variant="contained"
              sx={{
                minWidth: 160,
                bgcolor: 'common.white',
                color: 'grey.900',
                '&:hover': {
                  bgcolor: 'grey.100',
                },
              }}
            >
              Subscribe
            </Button>
          </Box>

          <Typography variant="caption" sx={{ mt: 2, display: 'block', color: 'grey.500' }}>
            Join 10,000+ fashion insiders. Unsubscribe anytime.
          </Typography>
        </Box>
      </Container>
    </Box>
  );
}
