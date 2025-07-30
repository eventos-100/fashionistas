import { useState, useCallback } from 'react';

import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Divider from '@mui/material/Divider';
import TextField from '@mui/material/TextField';
import Autocomplete from '@mui/material/Autocomplete';
import InputAdornment from '@mui/material/InputAdornment';

import { Iconify } from 'src/components/iconify';

// ----------------------------------------------------------------------

const DESIGNER_CATEGORIES = [
  'All Designers',
  'Haute Couture',
  'Prêt-à-Porter',
  'Sustainable Luxury',
  'Avant-Garde',
  'Artisanal',
  'Bridal Couture',
];

const LOCATIONS = [
  'All Ateliers',
  'Bogotá Fashion District',
  'Medellín Creative Quarter',
  'Cali Design Hub',
  'Cartagena Heritage Studios',
  'International',
];

const EXPERIENCE_LEVELS = [
  'All Experience',
  'Maisons Établies (20+ Years)',
  'Master Craftsmen (10-20 Years)',
  'Rising Ateliers (5-10 Years)',
  'New Vanguard (<5 Years)',
];

export function FashionDesignerFilters({ sx, ...other }) {
  const [category, setCategory] = useState('All Categories');
  const [location, setLocation] = useState('All Locations');
  const [experience, setExperience] = useState('All Experience');

  const renderDivider = () => (
    <Divider flexItem orientation="vertical" sx={{ display: { xs: 'none', md: 'block' } }} />
  );

  return (
    <Box
      display="flex"
      alignItems="center"
      sx={[
        (theme) => ({
          p: 3,
          gap: 1,
          borderRadius: 2,
          position: 'relative',
          flexDirection: { xs: 'column', md: 'row' },
          border: `solid 1px ${theme.vars.palette.divider}`,
        }),
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      <Autocomplete
        sx={{ minWidth: { md: 240 } }}
        options={DESIGNER_CATEGORIES}
        value={category}
        onChange={(event, newValue) => setCategory(newValue)}
        renderInput={(params) => (
          <TextField
            {...params}
            placeholder="Category"
            InputProps={{
              ...params.InputProps,
              startAdornment: (
                <InputAdornment position="start">
                  <Iconify width={24} icon="carbon:tag" sx={{ mr: 1, color: 'text.disabled' }} />
                </InputAdornment>
              ),
            }}
          />
        )}
      />

      {renderDivider()}

      <Autocomplete
        sx={{ minWidth: { md: 240 } }}
        options={LOCATIONS}
        value={location}
        onChange={(event, newValue) => setLocation(newValue)}
        renderInput={(params) => (
          <TextField
            {...params}
            placeholder="Location"
            InputProps={{
              ...params.InputProps,
              startAdornment: (
                <InputAdornment position="start">
                  <Iconify width={24} icon="carbon:location" sx={{ mr: 1, color: 'text.disabled' }} />
                </InputAdornment>
              ),
            }}
          />
        )}
      />

      {renderDivider()}

      <Autocomplete
        sx={{ minWidth: { md: 240 } }}
        options={EXPERIENCE_LEVELS}
        value={experience}
        onChange={(event, newValue) => setExperience(newValue)}
        renderInput={(params) => (
          <TextField
            {...params}
            placeholder="Experience"
            InputProps={{
              ...params.InputProps,
              startAdornment: (
                <InputAdornment position="start">
                  <Iconify width={24} icon="carbon:certificate" sx={{ mr: 1, color: 'text.disabled' }} />
                </InputAdornment>
              ),
            }}
          />
        )}
      />

      <Button
        size="large"
        color="secondary"
        variant="contained"
        sx={{
          px: 0,
          minWidth: 64,
          flexShrink: 0,
          ml: { xs: 0, md: 'auto' },
        }}
      >
        <Iconify icon="carbon:search" />
      </Button>
    </Box>
  );
}
