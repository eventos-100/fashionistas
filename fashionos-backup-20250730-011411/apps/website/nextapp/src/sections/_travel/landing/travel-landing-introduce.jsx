import Box from '@mui/material/Box';
import Container from '@mui/material/Container';
import Typography from '@mui/material/Typography';

// ----------------------------------------------------------------------

export function TravelLandingIntroduce({ sx, ...other }) {
  const containerOffset = 'calc((100vw - 1200px) / 2)';

  const renderTexts = () => (
    <Container>
      <Box
        sx={{
          maxWidth: 480,
          mx: { xs: 'auto', md: 'unset' },
          textAlign: { xs: 'center', md: 'unset' },
        }}
      >
        <Typography variant="h2" sx={{ mb: 3 }}>
          Experience fashion like never before
        </Typography>
        <Typography sx={{ color: 'text.secondary' }}>
          Step into the world of haute couture with exclusive access to runway shows and designer events.
        </Typography>
      </Box>
    </Container>
  );

  const renderImage = () => (
    <Container
      sx={(theme) => ({
        px: 0,
        my: { xs: 5, md: 10 },
        position: 'relative',
        [theme.breakpoints.up('sm')]: { px: 0 },
        [theme.breakpoints.up('md')]: { my: 10 },
        [theme.breakpoints.up('lg')]: { px: 3 },
      })}
    >
      <Box
        component="img"
        loading="lazy"
        alt="Fashion runway"
        src="https://res.cloudinary.com/dzqy2ixl0/image/upload/v1753554437/runway-1_fczauy.jpg"
        sx={(theme) => ({
          minHeight: 320,
          width: '100%',
          objectFit: 'cover',
          borderRadius: 2,
          [theme.breakpoints.up('lg')]: {
            maxWidth: 'unset',
            width: `calc(100vw - ${containerOffset})`,
          },
        })}
      />
    </Container>
  );

  return (
    <Box
      component="section"
      sx={[
        {
          overflow: 'hidden',
          pt: { xs: 10, md: 15 },
          pb: { xs: 5, md: 10 },
        },
        ...(Array.isArray(sx) ? sx : [sx]),
      ]}
      {...other}
    >
      {renderTexts()}
      {renderImage()}
    </Box>
  );
}
