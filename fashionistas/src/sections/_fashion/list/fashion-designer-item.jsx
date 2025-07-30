import { useState, useCallback } from 'react';

import Box from '@mui/material/Box';
import Link from '@mui/material/Link';
import Card from '@mui/material/Card';
import Stack from '@mui/material/Stack';
import Divider from '@mui/material/Divider';
import Checkbox from '@mui/material/Checkbox';
import Typography from '@mui/material/Typography';

import { paths } from 'src/routes/paths';
import { RouterLink } from 'src/routes/components';

import { fCurrency } from 'src/utils/format-number';

import { Image } from 'src/components/image';
import { Iconify } from 'src/components/iconify';

// ----------------------------------------------------------------------

export function FashionDesignerItem({ designer, sx, ...other }) {
  const [favorite, setFavorite] = useState(designer.favorited);

  const handleChangeFavorite = useCallback((event) => {
    setFavorite(event.target.checked);
  }, []);

  return (
    <Card sx={sx} {...other}>
      <Box
        sx={{
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'space-between',
          pl: 2,
          top: 0,
          pt: 1.5,
          pr: 1.5,
          width: 1,
          zIndex: 9,
          position: 'absolute',
        }}
      >
        {designer.featured && (
          <Box
            sx={{
              gap: 0.5,
              display: 'flex',
              px: 1,
              borderRadius: 0.75,
              typography: 'subtitle2',
              bgcolor: 'text.primary',
              color: 'background.paper',
            }}
          >
            Editor's Choice
          </Box>
        )}

        <Checkbox
          color="error"
          checked={favorite}
          onChange={handleChangeFavorite}
          icon={<Iconify icon="solar:heart-outline" />}
          checkedIcon={<Iconify icon="solar:heart-bold" />}
          slotProps={{
            input: {
              id: `favorite-checkbox-${designer.id}`,
              'aria-label': 'Favorite checkbox',
            },
          }}
          sx={{ color: 'common.white' }}
        />
      </Box>

      <Image alt={designer.name} src={designer.photo} ratio="1/1" />

      <Box sx={{ p: 2.5 }}>
        <Box sx={{ mb: 1.5 }}>
          <Stack direction="row" alignItems="center" spacing={1}>
            <Typography variant="h6" sx={{ mb: 0 }}>
              {designer.name}
            </Typography>
            {designer.verified && (
              <Iconify icon="material-symbols:verified" sx={{ color: 'primary.main' }} />
            )}
          </Stack>
          
          <Typography variant="body2" sx={{ color: 'text.secondary' }}>
            {designer.category}
          </Typography>
        </Box>

        <Divider sx={{ borderStyle: 'dashed', mb: 1.5 }} />

        <Stack spacing={0.5}>
          <Stack direction="row" alignItems="center" spacing={1}>
            <Iconify icon="carbon:location" width={16} sx={{ color: 'text.secondary' }} />
            <Typography variant="caption" sx={{ color: 'text.secondary' }}>
              {designer.location} Atelier
            </Typography>
          </Stack>

          <Stack direction="row" alignItems="center" spacing={1}>
            <Iconify icon="mdi:briefcase-outline" width={16} sx={{ color: 'text.secondary' }} />
            <Typography variant="caption" sx={{ color: 'text.secondary' }}>
              Est. {new Date().getFullYear() - designer.experience}
            </Typography>
          </Stack>

          {designer.rating && (
            <Stack direction="row" alignItems="center" spacing={1}>
              <Iconify icon="solar:star-bold" width={16} sx={{ color: 'warning.main' }} />
              <Typography variant="caption">
                {designer.rating} ★ Verified Reviews
              </Typography>
            </Stack>
          )}
        </Stack>

        <Stack direction="row" spacing={1} sx={{ mt: 2 }}>
          <Link
            component={RouterLink}
            href={`/designers/${designer.slug}`}
            underline="none"
            sx={{
              flex: 1,
              bgcolor: 'text.primary',
              color: 'background.paper',
              py: 1,
              borderRadius: 0.75,
              textAlign: 'center',
              typography: 'button',
              '&:hover': {
                bgcolor: 'text.secondary',
              },
            }}
          >
            Explore Atelier
          </Link>
        </Stack>
      </Box>
    </Card>
  );
}
