import React from 'react';
import {
  Box,
  Container,
  Typography,
  Button,
  Stack,
  Grid,
  Card,
  CardContent,
  CardActions,
  List,
  ListItem,
  ListItemIcon,
  ListItemText,
  Divider,
  AppBar,
  Toolbar,
  Link,
  IconButton,
  useTheme,
  useMediaQuery,
  alpha
} from '@mui/material';
import {
  ArrowForward,
  CheckCircle,
  EventNote,
  People,
  Analytics,
  AutoAwesome,
  Speed,
  Security,
  CloudSync,
  Menu as MenuIcon
} from '@mui/icons-material';

// Hero Section Component
const Hero = () => {
  const theme = useTheme();
  
  return (
    <Box
      sx={{
        background: `linear-gradient(45deg, ${theme.palette.primary.main} 30%, ${theme.palette.secondary.main} 90%)`,
        color: 'white',
        pt: 12,
        pb: 8,
        position: 'relative',
        overflow: 'hidden',
        '&::before': {
          content: '""',
          position: 'absolute',
          top: 0,
          left: 0,
          right: 0,
          bottom: 0,
          background: 'url("/images/pattern.svg") repeat',
          opacity: 0.1,
        }
      }}
    >
      <Container maxWidth="lg">
        <Grid container spacing={4} alignItems="center">
          <Grid item xs={12} md={6}>
            <Typography
              component="h1"
              variant="h2"
              fontWeight="bold"
              gutterBottom
              sx={{
                fontSize: { xs: '2.5rem', md: '3.5rem' }
              }}
            >
              Transform Your Events with AI
            </Typography>
            <Typography variant="h5" paragraph sx={{ mb: 4, opacity: 0.9 }}>
              EventsOS brings intelligent automation to fashion shows, galas, and corporate events. 
              Manage everything from planning to post-event analytics in one platform.
            </Typography>
            <Stack direction={{ xs: 'column', sm: 'row' }} spacing={2}>
              <Button
                variant="contained"
                size="large"
                endIcon={<ArrowForward />}
                sx={{
                  bgcolor: 'white',
                  color: theme.palette.primary.main,
                  '&:hover': {
                    bgcolor: alpha('#ffffff', 0.9),
                  }
                }}
              >
                Start Free Trial
              </Button>
              <Button
                variant="outlined"
                size="large"
                sx={{
                  borderColor: 'white',
                  color: 'white',
                  '&:hover': {
                    borderColor: 'white',
                    bgcolor: alpha('#ffffff', 0.1),
                  }
                }}
              >
                Watch Demo
              </Button>
            </Stack>
          </Grid>
          <Grid item xs={12} md={6}>
            <Box
              component="img"
              src="/images/dashboard-preview.png"
              alt="EventsOS Dashboard"
              sx={{
                width: '100%',
                height: 'auto',
                borderRadius: 2,
                boxShadow: theme.shadows[20],
              }}
            />
          </Grid>
        </Grid>
      </Container>
    </Box>
  );
};

// Features Section Component
const Features = () => {
  const features = [
    {
      icon: <EventNote fontSize="large" />,
      title: 'Smart Planning',
      description: 'AI-powered timeline generation and task automation for flawless event execution.'
    },
    {
      icon: <People fontSize="large" />,
      title: 'Attendee Management',
      description: 'Seamless registration, check-in, and personalized experiences for every guest.'
    },
    {
      icon: <Analytics fontSize="large" />,
      title: 'Real-time Analytics',
      description: 'Track engagement, measure ROI, and generate comprehensive post-event reports.'
    },
    {
      icon: <AutoAwesome fontSize="large" />,
      title: 'AI Agents',
      description: 'Intelligent assistants handle routine tasks while you focus on strategy.'
    },
    {
      icon: <CloudSync fontSize="large" />,
      title: 'Seamless Integrations',
      description: 'Connect with Twenty CRM, SendGrid, WhatsApp, and your favorite tools.'
    },
    {
      icon: <Security fontSize="large" />,
      title: 'Enterprise Security',
      description: 'Bank-level encryption and compliance with industry standards.'
    }
  ];

  return (
    <Box sx={{ py: 8, bgcolor: 'background.default' }}>
      <Container maxWidth="lg">
        <Typography variant="h3" align="center" gutterBottom fontWeight="bold">
          Everything You Need to Run Exceptional Events
        </Typography>
        <Typography variant="h6" align="center" color="text.secondary" paragraph sx={{ mb: 6 }}>
          From intimate fashion shows to large-scale corporate galas
        </Typography>
        
        <Grid container spacing={4}>
          {features.map((feature, index) => (
            <Grid item xs={12} sm={6} md={4} key={index}>
              <Card
                sx={{
                  height: '100%',
                  display: 'flex',
                  flexDirection: 'column',
                  transition: 'transform 0.2s',
                  '&:hover': {
                    transform: 'translateY(-4px)',
                    boxShadow: 4,
                  }
                }}
              >
                <CardContent sx={{ flexGrow: 1 }}>
                  <Box sx={{ color: 'primary.main', mb: 2 }}>
                    {feature.icon}
                  </Box>
                  <Typography gutterBottom variant="h5" component="h3">
                    {feature.title}
                  </Typography>
                  <Typography color="text.secondary">
                    {feature.description}
                  </Typography>
                </CardContent>
              </Card>
            </Grid>
          ))}
        </Grid>
      </Container>
    </Box>
  );
};

// Pricing Section Component
const Pricing = () => {
  const tiers = [
    {
      title: 'Starter',
      price: '99',
      description: 'Perfect for small events and testing the platform',
      features: [
        'Up to 500 attendees',
        'Basic AI automation',
        'Email support',
        'Standard integrations',
        'Event analytics'
      ],
      buttonText: 'Start Free Trial',
      buttonVariant: 'outlined' as const,
    },
    {
      title: 'Professional',
      price: '299',
      description: 'For growing event agencies and corporate teams',
      features: [
        'Up to 5,000 attendees',
        'Advanced AI agents',
        'Priority support',
        'All integrations',
        'Custom branding',
        'API access'
      ],
      buttonText: 'Get Started',
      buttonVariant: 'contained' as const,
      highlighted: true,
    },
    {
      title: 'Enterprise',
      price: 'Custom',
      description: 'Tailored solutions for large-scale events',
      features: [
        'Unlimited attendees',
        'Custom AI workflows',
        'Dedicated support',
        'White-label options',
        'On-premise deployment',
        'SLA guarantee'
      ],
      buttonText: 'Contact Sales',
      buttonVariant: 'outlined' as const,
    },
  ];

  return (
    <Box sx={{ py: 8, bgcolor: 'background.paper' }}>
      <Container maxWidth="lg">
        <Typography variant="h3" align="center" gutterBottom fontWeight="bold">
          Simple, Transparent Pricing
        </Typography>
        <Typography variant="h6" align="center" color="text.secondary" paragraph sx={{ mb: 6 }}>
          Choose the plan that fits your event needs
        </Typography>
        
        <Grid container spacing={3} alignItems="flex-start">
          {tiers.map((tier) => (
            <Grid item xs={12} sm={6} md={4} key={tier.title}>
              <Card
                sx={{
                  height: '100%',
                  display: 'flex',
                  flexDirection: 'column',
                  position: 'relative',
                  ...(tier.highlighted && {
                    borderColor: 'primary.main',
                    borderWidth: 2,
                    borderStyle: 'solid',
                  })
                }}
              >
                {tier.highlighted && (
                  <Box
                    sx={{
                      position: 'absolute',
                      top: -12,
                      left: '50%',
                      transform: 'translateX(-50%)',
                      bgcolor: 'primary.main',
                      color: 'white',
                      px: 2,
                      py: 0.5,
                      borderRadius: 1,
                      fontSize: '0.875rem',
                      fontWeight: 'bold',
                    }}
                  >
                    MOST POPULAR
                  </Box>
                )}
                <CardContent sx={{ flexGrow: 1, pt: tier.highlighted ? 4 : 3 }}>
                  <Typography variant="h4" component="h3" gutterBottom>
                    {tier.title}
                  </Typography>
                  <Box sx={{ mb: 2 }}>
                    <Typography variant="h3" component="span" fontWeight="bold">
                      ${tier.price}
                    </Typography>
                    {tier.price !== 'Custom' && (
                      <Typography variant="h6" component="span" color="text.secondary">
                        /month
                      </Typography>
                    )}
                  </Box>
                  <Typography variant="body2" color="text.secondary" paragraph>
                    {tier.description}
                  </Typography>
                  <List dense>
                    {tier.features.map((feature) => (
                      <ListItem key={feature} sx={{ px: 0 }}>
                        <ListItemIcon sx={{ minWidth: 32 }}>
                          <CheckCircle color="primary" fontSize="small" />
                        </ListItemIcon>
                        <ListItemText primary={feature} />
                      </ListItem>
                    ))}
                  </List>
                </CardContent>
                <CardActions sx={{ p: 3, pt: 0 }}>
                  <Button
                    fullWidth
                    variant={tier.buttonVariant}
                    size="large"
                  >
                    {tier.buttonText}
                  </Button>
                </CardActions>
              </Card>
            </Grid>
          ))}
        </Grid>
      </Container>
    </Box>
  );
};

// Footer Component
const Footer = () => {
  return (
    <Box sx={{ bgcolor: 'background.paper', py: 6 }}>
      <Container maxWidth="lg">
        <Grid container spacing={4}>
          <Grid item xs={12} sm={6} md={3}>
            <Typography variant="h6" color="text.primary" gutterBottom>
              Product
            </Typography>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Features
            </Link>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Pricing
            </Link>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Integrations
            </Link>
            <Link href="#" color="text.secondary" display="block">
              API Docs
            </Link>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Typography variant="h6" color="text.primary" gutterBottom>
              Company
            </Typography>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              About Us
            </Link>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Blog
            </Link>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Careers
            </Link>
            <Link href="#" color="text.secondary" display="block">
              Contact
            </Link>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Typography variant="h6" color="text.primary" gutterBottom>
              Resources
            </Typography>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Documentation
            </Link>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Help Center
            </Link>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Community
            </Link>
            <Link href="#" color="text.secondary" display="block">
              Status
            </Link>
          </Grid>
          <Grid item xs={12} sm={6} md={3}>
            <Typography variant="h6" color="text.primary" gutterBottom>
              Legal
            </Typography>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Privacy Policy
            </Link>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Terms of Service
            </Link>
            <Link href="#" color="text.secondary" display="block" sx={{ mb: 1 }}>
              Security
            </Link>
            <Link href="#" color="text.secondary" display="block">
              GDPR
            </Link>
          </Grid>
        </Grid>
        <Divider sx={{ my: 4 }} />
        <Typography variant="body2" color="text.secondary" align="center">
          © 2025 EventsOS. All rights reserved.
        </Typography>
      </Container>
    </Box>
  );
};

// Main Marketing Page Component
export default function MarketingPage() {
  return (
    <>
      <AppBar position="fixed" color="default" elevation={1}>
        <Toolbar>
          <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
            EventsOS
          </Typography>
          <Box sx={{ display: { xs: 'none', md: 'flex' }, gap: 3 }}>
            <Link href="#features" color="inherit" underline="none">
              Features
            </Link>
            <Link href="#pricing" color="inherit" underline="none">
              Pricing
            </Link>
            <Link href="#" color="inherit" underline="none">
              Docs
            </Link>
            <Link href="#" color="inherit" underline="none">
              Blog
            </Link>
          </Box>
          <IconButton
            sx={{ display: { xs: 'flex', md: 'none' } }}
            color="inherit"
            aria-label="menu"
          >
            <MenuIcon />
          </IconButton>
          <Button
            variant="contained"
            sx={{ ml: 2, display: { xs: 'none', sm: 'inline-flex' } }}
          >
            Sign In
          </Button>
        </Toolbar>
      </AppBar>
      <Box sx={{ pt: 8 }}>
        <Hero />
        <Features />
        <Pricing />
        <Footer />
      </Box>
    </>
  );
}