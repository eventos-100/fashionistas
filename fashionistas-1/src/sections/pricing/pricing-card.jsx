import { varAlpha } from 'minimal-shared/utils';

import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';

import { CONFIG } from 'src/global-config';

import { Label } from 'src/components/label';

// ----------------------------------------------------------------------

const iconPath = (name) => `${CONFIG.assetsDir}/assets/icons/plans/${name}`;

export function PricingCard({ plan, sx, ...other }) {
  const isGeneralLicense = plan.license === 'General Admission';
  const isVIPLicense = plan.license === 'VIP Experience';
  const isSponsorLicense = plan.license === 'Sponsor Package';

  // Icons removed as per design requirement
  // const renderIcons = () => (
  //   <Box
  //     component="img"
  //     alt={plan.license}
  //     src={
  //       (isGeneralLicense && iconPath('ic-plan-points-basic.svg')) ||
  //       (isVIPLicense && iconPath('ic-plan-points-starter.svg')) ||
  //       iconPath('ic-plan-points-premium.svg')
  //     }
  //     sx={{ width: 80, height: 80 }}
  //   />
  // );

  const renderPrices = () => (
    <Box sx={{ gap: 0.5, display: 'flex', alignItems: 'center' }}>
      <Typography component="span" variant="h5">
        $
      </Typography>

      <Typography component="span" variant="h3">
        {plan.price}
      </Typography>

      <Typography component="span" variant="body2" sx={{ color: 'text.secondary' }}>
        /person
      </Typography>
    </Box>
  );

  const renderList = () => (
    <Box
      sx={{
        gap: 1,
        display: 'flex',
        textAlign: 'center',
        flexDirection: 'column',
      }}
    >
      {plan.options.map((option) => (
        <Typography
          key={option.title}
          variant="body2"
          sx={{
            fontWeight: 'fontWeightMedium',
            ...(option.disabled && { color: 'text.disabled', textDecoration: 'line-through' }),
          }}
        >
          {option.title}
        </Typography>
      ))}
    </Box>
  );

  return (
    <Paper
      variant="outlined"
      sx={[
        (theme) => ({
          p: 5,
          gap: 5,
          display: 'flex',
          borderRadius: 2,
          position: 'relative',
          alignItems: 'center',
          bgcolor: 'transparent',
          flexDirection: 'column',
          boxShadow: theme.vars.customShadows.card,
          [theme.breakpoints.up('md')]: { boxShadow: 'none' },
        }),
        (theme) =>
          (isVIPLicense || isSponsorLicense) && {
            py: 8,
            border: '2px solid',
            borderColor: 'primary.main',
            [theme.breakpoints.up('md')]: {
              boxShadow: `-24px 24px 72px -8px ${varAlpha(theme.vars.palette.primary.mainChannel, 0.24)}`,
            },
          },
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      {plan.badge && (
        <Label 
          color="primary" 
          sx={{ 
            position: 'absolute', 
            top: 16, 
            right: 16,
            bgcolor: 'primary.main',
            color: 'white'
          }}
        >
          {plan.badge}
        </Label>
      )}

      <Box component="span" sx={{ color: 'text.secondary', typography: 'overline' }}>
        {plan.license}
      </Box>

      {renderPrices()}
      {renderList()}

      <Button
        fullWidth
        size="large"
        variant="contained"
        color="primary"
        sx={{
          bgcolor: 'primary.main',
          color: 'white',
          py: 1.5,
          '&:hover': {
            bgcolor: 'primary.dark'
          }
        }}
      >
        Select Ticket
      </Button>

      {plan.urgency && (
        <Typography 
          variant="caption" 
          sx={{ 
            mt: 1, 
            color: 'warning.main',
            fontWeight: 'medium',
            textAlign: 'center'
          }}
        >
          {plan.urgency}
        </Typography>
      )}
    </Paper>
  );
}
