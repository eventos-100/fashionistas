EventsOS Complete Production Implementation Plan
📋 Master Table of Contents

Executive Summary & Project Overview
Technology Stack & Dependencies
Progress Tracking Dashboard
Phase 0: Critical Foundation & Environment
Phase 1: Refine + MUI v6 Dashboard Setup
Phase 2: Marketing Website Implementation
Phase 3: Core Event Features Development
Phase 4: Testing & Quality Assurance
Phase 5: Production Deployment & Launch
Component Architecture & Integration
Production Readiness Master Checklist
Risk Assessment & Mitigation


1. Executive Summary & Project Overview
Project Scope
Build a production-ready event management platform with:

Admin Dashboard: Refine + MUI v6 + Supabase
Marketing Website: Next.js 14 + MUI v6
Backend: Supabase (Auth, Database, Storage)
Media: Cloudinary for image optimization
Deployment: Vercel with CI/CD

Current Status
ComponentScoreStatusBlockersEnvironment Setup25/100🟡 In ProgressVersion conflictsRefine Dashboard0/100⏸️ Not StartedWaiting on environmentMarketing Website15/100🔴 BlockedNext.js 15 → 14.2.3Supabase Integration10/100⏸️ PlanningSchema design pendingTesting Infrastructure0/100⏸️ Not StartedFramework selectionCI/CD Pipeline0/100⏸️ Not StartedGitHub Actions setup
Success Metrics

✅ Zero deployment failures
✅ Lighthouse score >95
✅ 100% TypeScript coverage
✅ <2s page load time
✅ WCAG 2.1 AA compliance


2. Technology Stack & Dependencies
Core Dependencies Matrix
PackageVersionPurposeStatusDocumentationFrontend Corenext14.2.3Framework🔴 Downgrade neededNext.jsreact18.3.1UI Library✅ CorrectReactreact-dom18.3.1DOM Renderer✅ CorrectReact DOMtypescript5.3.3Type Safety✅ CorrectTypeScriptRefine Framework@refinedev/core4.57.10Core Framework⏸️ To InstallRefine Core@refinedev/mui6.2.2MUI Integration⏸️ To InstallRefine MUI@refinedev/supabase6.0.0Data Provider⏸️ To InstallRefine Supabase@refinedev/nextjs-router6.0.0Routing⏸️ To InstallRefine Router@refinedev/react-hook-form4.8.0Forms⏸️ To InstallRefine FormsMUI v6 Components@mui/material6.5.0UI Components✅ CorrectMUI v6@mui/material-nextjs6.5.0Next.js SSR⏸️ To InstallMUI Next.js@mui/icons-material6.5.0Icons✅ CorrectMUI Icons@mui/x-data-grid7.0.0Data Tables⏸️ To InstallData Grid@mui/x-date-pickers7.0.0Date/Time⏸️ To InstallDate Pickers@mui/system6.5.0Layout System⏸️ To InstallMUI System@mui/lab6.0.0Experimental🔴 Update from devMUI Lab@mui/toolpad-coreLatestDashboard Tools⏸️ To InstallToolpad CoreEmotion (Required)@emotion/react11.13.0CSS-in-JS✅ CorrectEmotion@emotion/styled11.13.0Styled Components✅ CorrectEmotion Styled@emotion/cache11.13.0SSR Cache⏸️ To InstallEmotion Cache@emotion/server11.13.0SSR Server⏸️ To InstallEmotion ServerBackend & Data@supabase/supabase-js2.52.1Database Client✅ CorrectSupabase JS@supabase/auth-helpers-nextjs0.10.0Auth Helpers⏸️ To InstallAuth Helpers@supabase/ssr0.5.0SSR Support⏸️ To InstallSupabase SSRMedia & Assetsnext-cloudinary6.16.0Image CDN✅ CorrectNext Cloudinarycloudinary2.7.0SDK✅ CorrectCloudinary
Development Dependencies
PackageVersionPurposePriorityTesting@playwright/test1.50.0E2E TestingHIGH@testing-library/react16.0.0Unit TestingHIGH@testing-library/jest-dom6.0.0DOM TestingHIGHjest29.7.0Test RunnerHIGH@axe-core/react4.8.0AccessibilityHIGHmsw2.0.0API MockingMEDIUMQuality Toolseslint8.57.0LintingHIGHprettier3.2.5FormattingHIGHhusky9.0.11Git HooksHIGHlint-staged15.2.0Pre-commitHIGHBuild Tools@types/react18.3.1React TypesHIGH@types/node18.19.1Node TypesHIGHwebpack-bundle-analyzer4.10.0Bundle AnalysisMEDIUM@next/bundle-analyzer14.2.3Next.js BundleMEDIUM

3. Progress Tracking Dashboard
Overall Project Timeline
WeekPhaseStatusProgressKey DeliverablesWeek 0Foundation Setup🟡 Active25%Environment, Dependencies, GitWeek 1Refine Dashboard⏸️ Pending0%Admin UI, Auth, CRUDWeek 2Marketing Website⏸️ Pending0%Landing, Events, SSRWeek 3Core Features⏸️ Pending0%Events, Sponsors, AttendeesWeek 4Testing & QA⏸️ Pending0%Unit, E2E, PerformanceWeek 5Production Launch⏸️ Pending0%Deploy, Monitor, Support
Daily Sprint Tracker
DayTasksOwnerStatusBlockersDay 0Environment setup, version fixesDevOps🟡 ActiveNode/pnpm versionsDay 1Refine installation, MUI setupFrontend⏸️ PendingWaiting Day 0Day 2Supabase schema, RLS policiesBackend⏸️ PendingSchema reviewDay 3Dashboard layout, navigationFrontend⏸️ PendingDesign approvalDay 4Event CRUD operationsFull Stack⏸️ PendingAPI designDay 5Testing setup, CI/CDQA/DevOps⏸️ PendingFramework choice

4. Phase 0: Critical Foundation & Environment
Task 0.1: Environment Configuration
Priority: CRITICAL | Duration: 2 hours | Score: 0/100
Steps:
bash# 1. Create version lock files
echo "18.19.1" > .nvmrc
cat > .npmrc << EOF
engine-strict=true
save-exact=true
packageManager=pnpm@9.7.0
auto-install-peers=true
shamefully-hoist=false
EOF

# 2. Install correct versions
nvm install 18.19.1
nvm use 18.19.1
npm install -g pnpm@9.7.0

# 3. Verify installations
node --version  # Must be 18.19.1
pnpm --version  # Must be 9.7.0
Success Criteria:

✅ Node.js 18.19.1 active
✅ pnpm 9.7.0 installed
✅ Version files committed
✅ Team using same versions
✅ CI/CD configured

Testing:

Fresh clone and install test
Cross-platform verification (Mac/Linux/Windows)
CI environment validation
Build process verification
Team member onboarding test

Production Checklist:

 .nvmrc in repository
 .npmrc configured
 README with setup instructions
 CI/CD version matching
 Rollback procedure documented


Task 0.2: Git Configuration & Hooks
Priority: CRITICAL | Duration: 1 hour | Score: 0/100
Steps:
bash# 1. Install Husky and dependencies
pnpm add -D husky lint-staged @commitlint/cli @commitlint/config-conventional

# 2. Initialize Husky
npx husky init

# 3. Create pre-commit hook
cat > .husky/pre-commit << 'EOF'
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

# Update lockfile if package.json changed
if git diff --cached --name-only | grep -q "package.json"; then
  echo "📦 Updating lockfile..."
  pnpm install --lockfile-only
  git add pnpm-lock.yaml
fi

# Run quality checks
pnpm type-check
pnpm lint-staged
EOF

chmod +x .husky/pre-commit

# 4. Configure lint-staged
cat > .lintstagedrc.json << 'EOF'
{
  "*.{ts,tsx}": ["eslint --fix", "prettier --write"],
  "*.{json,md,yml}": ["prettier --write"]
}
EOF
Success Criteria:

✅ Hooks prevent bad commits
✅ Lockfile auto-updates
✅ Code formatting automated
✅ Type checking passes
✅ Commit messages validated

Testing:

Commit with TypeScript errors (should fail)
Commit with lint errors (should fail)
Commit with package.json changes (should update lockfile)
Valid commit (should pass)
Bypass test with --no-verify

Production Checklist:

 All hooks documented
 Team onboarding guide
 Emergency bypass procedure
 Hook performance optimized
 CI/CD integration verified


Task 0.3: Dependency Installation
Priority: CRITICAL | Duration: 2 hours | Score: 0/100
Steps:
bash# 1. Clean install
cd /home/sk/fx/eventos
rm -rf node_modules pnpm-lock.yaml

# 2. Install core dependencies
pnpm add -E react@18.3.1 react-dom@18.3.1 next@14.2.3 typescript@5.3.3

# 3. Install Refine framework
pnpm add -E @refinedev/core@4.57.10 @refinedev/mui@6.2.2
pnpm add -E @refinedev/supabase@6.0.0 @refinedev/nextjs-router@6.0.0
pnpm add -E @refinedev/react-hook-form@4.8.0

# 4. Install MUI v6 complete suite
pnpm add -E @mui/material@6.5.0 @mui/material-nextjs@6.5.0
pnpm add -E @mui/icons-material@6.5.0 @mui/system@6.5.0
pnpm add -E @mui/x-data-grid@7.0.0 @mui/x-date-pickers@7.0.0
pnpm add -E @mui/lab@6.0.0 @mui/toolpad-core@latest

# 5. Install Emotion
pnpm add -E @emotion/react@11.13.0 @emotion/styled@11.13.0
pnpm add -E @emotion/cache@11.13.0 @emotion/server@11.13.0

# 6. Install Supabase
pnpm add -E @supabase/supabase-js@2.52.1
pnpm add -E @supabase/auth-helpers-nextjs@0.10.0 @supabase/ssr@0.5.0

# 7. Install dev dependencies
pnpm add -DE eslint@8.57.0 prettier@3.2.5
pnpm add -DE @types/react@18.3.1 @types/node@18.19.1
pnpm add -DE @playwright/test@1.50.0 @testing-library/react@16.0.0

# 8. Verify installation
pnpm install --frozen-lockfile
Success Criteria:

✅ All dependencies installed
✅ No version conflicts
✅ Lockfile generated
✅ Peer dependencies satisfied
✅ Clean install works

Testing:

pnpm install --frozen-lockfile passes
pnpm ls shows no errors
TypeScript compilation works
Build process completes
No runtime errors

Production Checklist:

 Dependency audit clean
 License compliance verified
 Security scan passed
 Bundle size acceptable
 Update strategy documented


5. Phase 1: Refine + MUI v6 Dashboard Setup
Task 1.1: Refine Project Initialization
Priority: CRITICAL | Duration: 3 hours | Score: 0/100
References:

Refine MUI Integration
Refine Supabase Guide
Refine Examples

Steps:
bash# 1. Create Refine app structure
mkdir -p apps/admin/src/{components,pages,providers,interfaces,utils}

# 2. Create main App component
cat > apps/admin/src/App.tsx << 'EOF'
import { Refine } from "@refinedev/core";
import { RefineThemes, ThemedLayoutV2 } from "@refinedev/mui";
import { CssBaseline, GlobalStyles, ThemeProvider } from "@mui/material";
import { BrowserRouter, Route, Routes } from "react-router-dom";
import routerProvider from "@refinedev/react-router-v6";
import { dataProvider } from "@refinedev/supabase";
import { supabaseClient } from "./utils/supabaseClient";
import authProvider from "./providers/authProvider";

function App() {
  return (
    <BrowserRouter>
      <ThemeProvider theme={RefineThemes.Blue}>
        <CssBaseline />
        <GlobalStyles styles={{ html: { WebkitFontSmoothing: "auto" } }} />
        <Refine
          dataProvider={dataProvider(supabaseClient)}
          authProvider={authProvider}
          routerProvider={routerProvider}
          resources={[
            {
              name: "events",
              list: "/events",
              create: "/events/create",
              edit: "/events/edit/:id",
              show: "/events/show/:id",
            },
            {
              name: "sponsors",
              list: "/sponsors",
              create: "/sponsors/create",
              edit: "/sponsors/edit/:id",
            },
            {
              name: "attendees",
              list: "/attendees",
              show: "/attendees/show/:id",
            },
          ]}
          options={{
            syncWithLocation: true,
            warnWhenUnsavedChanges: true,
          }}
        >
          <Routes>
            <Route
              element={
                <ThemedLayoutV2>
                  {/* Outlet for resource pages */}
                </ThemedLayoutV2>
              }
            >
              <Route index element={<NavigateToResource />} />
              <Route path="*" element={<ErrorComponent />} />
            </Route>
          </Routes>
        </Refine>
      </ThemeProvider>
    </BrowserRouter>
  );
}
EOF

# 3. Configure Supabase client
cat > apps/admin/src/utils/supabaseClient.ts << 'EOF'
import { createClient } from "@supabase/supabase-js";

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const SUPABASE_ANON_KEY = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

export const supabaseClient = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: {
    persistSession: true,
  },
});
EOF

# 4. Create auth provider
cat > apps/admin/src/providers/authProvider.ts << 'EOF'
import { AuthProvider } from "@refinedev/core";
import { supabaseClient } from "../utils/supabaseClient";

const authProvider: AuthProvider = {
  login: async ({ email, password }) => {
    const { data, error } = await supabaseClient.auth.signInWithPassword({
      email,
      password,
    });
    
    if (error) {
      return {
        success: false,
        error: {
          message: error.message,
          name: "Login Error",
        },
      };
    }
    
    return {
      success: true,
      redirectTo: "/",
    };
  },
  
  logout: async () => {
    const { error } = await supabaseClient.auth.signOut();
    
    if (error) {
      return {
        success: false,
        error: {
          message: error.message,
          name: "Logout Error",
        },
      };
    }
    
    return {
      success: true,
      redirectTo: "/login",
    };
  },
  
  check: async () => {
    const { data } = await supabaseClient.auth.getUser();
    
    if (data?.user) {
      return {
        authenticated: true,
      };
    }
    
    return {
      authenticated: false,
      redirectTo: "/login",
    };
  },
  
  getIdentity: async () => {
    const { data } = await supabaseClient.auth.getUser();
    
    if (data?.user) {
      return {
        id: data.user.id,
        name: data.user.email,
        avatar: data.user.user_metadata?.avatar_url,
      };
    }
    
    return null;
  },
};

export default authProvider;
EOF
Success Criteria:

✅ Refine app structure created
✅ Supabase integration configured
✅ Authentication working
✅ Resource routing setup
✅ Theme applied correctly

Testing:

Admin app starts without errors
Login/logout functionality works
Navigation between resources
Theme switching works
Responsive layout verified

Production Checklist:

 Environment variables set
 Auth provider secured
 Error boundaries added
 Loading states implemented
 SEO metadata configured


Task 1.2: MUI v6 Theme Configuration
Priority: HIGH | Duration: 2 hours | Score: 0/100
References:

Refine MUI Theming
MUI v6 Theming
MUI CSS Variables

Steps:
bash# 1. Create custom theme
cat > apps/admin/src/themes/eventosTheme.ts << 'EOF'
import { createTheme, ThemeOptions } from "@mui/material/styles";
import { RefineThemes } from "@refinedev/mui";

const baseTheme = RefineThemes.Blue;

export const lightThemeOptions: ThemeOptions = {
  ...baseTheme,
  cssVariables: {
    colorSchemeSelector: "data-color-scheme",
  },
  colorSchemes: {
    light: {
      palette: {
        primary: {
          main: "#1976d2",
          light: "#42a5f5",
          dark: "#1565c0",
        },
        secondary: {
          main: "#dc004e",
          light: "#e33371",
          dark: "#9a0036",
        },
        background: {
          default: "#fafafa",
          paper: "#ffffff",
        },
      },
    },
  },
  typography: {
    fontFamily: '"Inter", "Roboto", "Helvetica", "Arial", sans-serif',
    h1: {
      fontSize: "2.5rem",
      fontWeight: 600,
    },
    h2: {
      fontSize: "2rem",
      fontWeight: 600,
    },
  },
  shape: {
    borderRadius: 8,
  },
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: "none",
        },
      },
    },
    MuiDataGrid: {
      styleOverrides: {
        root: {
          border: "none",
        },
      },
    },
  },
};

export const darkThemeOptions: ThemeOptions = {
  ...lightThemeOptions,
  colorSchemes: {
    dark: {
      palette: {
        mode: "dark",
        primary: {
          main: "#90caf9",
          light: "#a6d4fa",
          dark: "#648dae",
        },
        background: {
          default: "#121212",
          paper: "#1e1e1e",
        },
      },
    },
  },
};

export const eventosTheme = createTheme(lightThemeOptions);
EOF

# 2. Create theme provider wrapper
cat > apps/admin/src/providers/ThemeProvider.tsx << 'EOF'
import React, { createContext, useContext, useState, useMemo } from "react";
import { ThemeProvider as MuiThemeProvider, createTheme } from "@mui/material/styles";
import { lightThemeOptions, darkThemeOptions } from "../themes/eventosTheme";

interface ThemeContextType {
  mode: "light" | "dark";
  toggleColorMode: () => void;
}

const ThemeContext = createContext<ThemeContextType>({
  mode: "light",
  toggleColorMode: () => {},
});

export const useTheme = () => useContext(ThemeContext);

export const ThemeProvider: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [mode, setMode] = useState<"light" | "dark">("light");

  const colorMode = useMemo(
    () => ({
      mode,
      toggleColorMode: () => {
        setMode((prevMode) => (prevMode === "light" ? "dark" : "light"));
      },
    }),
    [mode]
  );

  const theme = useMemo(
    () => createTheme(mode === "light" ? lightThemeOptions : darkThemeOptions),
    [mode]
  );

  return (
    <ThemeContext.Provider value={colorMode}>
      <MuiThemeProvider theme={theme}>{children}</MuiThemeProvider>
    </ThemeContext.Provider>
  );
};
EOF

# 3. Update package.json with theme scripts
cat >> apps/admin/package.json << 'EOF'
{
  "scripts": {
    "theme:extract": "mui-theme-creator extract",
    "theme:build": "mui-theme-creator build"
  }
}
EOF
Success Criteria:

✅ Custom theme created
✅ Dark mode toggle works
✅ CSS variables configured
✅ Component overrides applied
✅ Typography system working

Testing:

Theme switching without flicker
CSS variables in DevTools
Component styling consistency
Dark mode contrast ratios
Mobile responsive theming

Production Checklist:

 Theme performance optimized
 Color contrast WCAG compliant
 Print styles configured
 Theme persistence (localStorage)
 SSR compatibility verified


Task 1.3: Dashboard Layout Components
Priority: HIGH | Duration: 4 hours | Score: 0/100
References:

MUI Grid System
Toolpad Core
Refine Layout

Steps:
bash# 1. Create dashboard layout
cat > apps/admin/src/components/layout/DashboardLayout.tsx << 'EOF'
import React from "react";
import {
  Box,
  Drawer,
  AppBar,
  Toolbar,
  List,
  Typography,
  Divider,
  IconButton,
  ListItem,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  Avatar,
  Menu,
  MenuItem,
} from "@mui/material";
import {
  Menu as MenuIcon,
  Dashboard,
  Event,
  Business,
  People,
  Settings,
  Logout,
} from "@mui/icons-material";
import { useNavigate, useLocation } from "react-router-dom";
import { useLogout, useGetIdentity } from "@refinedev/core";

const drawerWidth = 240;

const menuItems = [
  { text: "Dashboard", icon: <Dashboard />, path: "/" },
  { text: "Events", icon: <Event />, path: "/events" },
  { text: "Sponsors", icon: <Business />, path: "/sponsors" },
  { text: "Attendees", icon: <People />, path: "/attendees" },
  { text: "Settings", icon: <Settings />, path: "/settings" },
];

export const DashboardLayout: React.FC<{ children: React.ReactNode }> = ({ children }) => {
  const [mobileOpen, setMobileOpen] = React.useState(false);
  const [anchorEl, setAnchorEl] = React.useState<null | HTMLElement>(null);
  
  const navigate = useNavigate();
  const location = useLocation();
  const { mutate: logout } = useLogout();
  const { data: identity } = useGetIdentity();

  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  const handleMenuClick = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };

  const handleMenuClose = () => {
    setAnchorEl(null);
  };

  const drawer = (
    <div>
      <Toolbar>
        <Typography variant="h6" noWrap component="div">
          EventsOS Admin
        </Typography>
      </Toolbar>
      <Divider />
      <List>
        {menuItems.map((item) => (
          <ListItem key={item.text} disablePadding>
            <ListItemButton
              selected={location.pathname === item.path}
              onClick={() => navigate(item.path)}
            >
              <ListItemIcon>{item.icon}</ListItemIcon>
              <ListItemText primary={item.text} />
            </ListItemButton>
          </ListItem>
        ))}
      </List>
    </div>
  );

  return (
    <Box sx={{ display: "flex" }}>
      <AppBar
        position="fixed"
        sx={{
          width: { sm: `calc(100% - ${drawerWidth}px)` },
          ml: { sm: `${drawerWidth}px` },
        }}
      >
        <Toolbar>
          <IconButton
            color="inherit"
            aria-label="open drawer"
            edge="start"
            onClick={handleDrawerToggle}
            sx={{ mr: 2, display: { sm: "none" } }}
          >
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" noWrap component="div" sx={{ flexGrow: 1 }}>
            {/* Dynamic page title */}
          </Typography>
          <IconButton onClick={handleMenuClick} color="inherit">
            <Avatar src={identity?.avatar} alt={identity?.name}>
              {identity?.name?.[0]}
            </Avatar>
          </IconButton>
          <Menu
            anchorEl={anchorEl}
            open={Boolean(anchorEl)}
            onClose={handleMenuClose}
          >
            <MenuItem onClick={() => navigate("/profile")}>Profile</MenuItem>
            <MenuItem onClick={() => navigate("/settings")}>Settings</MenuItem>
            <Divider />
            <MenuItem onClick={() => logout()}>
              <ListItemIcon>
                <Logout fontSize="small" />
              </ListItemIcon>
              Logout
            </MenuItem>
          </Menu>
        </Toolbar>
      </AppBar>
      <Box
        component="nav"
        sx={{ width: { sm: drawerWidth }, flexShrink: { sm: 0 } }}
      >
        <Drawer
          variant="temporary"
          open={mobileOpen}
          onClose={handleDrawerToggle}
          ModalProps={{
            keepMounted: true,
          }}
          sx={{
            display: { xs: "block", sm: "none" },
            "& .MuiDrawer-paper": { boxSizing: "border-box", width: drawerWidth },
          }}
        >
          {drawer}
        </Drawer>
        <Drawer
          variant="permanent"
          sx={{
            display: { xs: "none", sm: "block" },
            "& .MuiDrawer-paper": { boxSizing: "border-box", width: drawerWidth },
          }}
          open
        >
          {drawer}
        </Drawer>
      </Box>
      <Box
        component="main"
        sx={{
          flexGrow: 1,
          p: 3,
          width: { sm: `calc(100% - ${drawerWidth}px)` },
          mt: 8,
        }}
      >
        {children}
      </Box>
    </Box>
  );
};
EOF

# 2. Create dashboard home page
cat > apps/admin/src/pages/dashboard/index.tsx << 'EOF'
import React from "react";
import { Grid2 as Grid, Paper, Typography, Box } from "@mui/material";
import { PeopleAlt, Event, Business, TrendingUp } from "@mui/icons-material";
import { useList } from "@refinedev/core";

const StatCard: React.FC<{
  title: string;
  value: number;
  icon: React.ReactNode;
  color: string;
}> = ({ title, value, icon, color }) => (
  <Paper
    sx={{
      p: 3,
      display: "flex",
      alignItems: "center",
      gap: 2,
      background: `linear-gradient(135deg, ${color}15 0%, ${color}30 100%)`,
    }}
  >
    <Box sx={{ color, fontSize: 48 }}>{icon}</Box>
    <Box>
      <Typography variant="h4" fontWeight="bold">
        {value}
      </Typography>
      <Typography variant="body2" color="text.secondary">
        {title}
      </Typography>
    </Box>
  </Paper>
);

export const DashboardPage: React.FC = () => {
  const { data: eventsData } = useList({ resource: "events" });
  const { data: sponsorsData } = useList({ resource: "sponsors" });
  const { data: attendeesData } = useList({ resource: "attendees" });

  return (
    <Box>
      <Typography variant="h4" gutterBottom>
        Dashboard Overview
      </Typography>
      
      <Grid container spacing={3}>
        <Grid size={{ xs: 12, sm: 6, md: 3 }}>
          <StatCard
            title="Total Events"
            value={eventsData?.total || 0}
            icon={<Event />}
            color="#1976d2"
          />
        </Grid>
        <Grid size={{ xs: 12, sm: 6, md: 3 }}>
          <StatCard
            title="Active Sponsors"
            value={sponsorsData?.total || 0}
            icon={<Business />}
            color="#388e3c"
          />
        </Grid>
        <Grid size={{ xs: 12, sm: 6, md: 3 }}>
          <StatCard
            title="Registered Attendees"
            value={attendeesData?.total || 0}
            icon={<PeopleAlt />}
            color="#f57c00"
          />
        </Grid>
        <Grid size={{ xs: 12, sm: 6, md: 3 }}>
          <StatCard
            title="Revenue (This Month)"
            value={0}
            icon={<TrendingUp />}
            color="#7b1fa2"
          />
        </Grid>
      </Grid>
      
      {/* Additional dashboard widgets */}
    </Box>
  );
};
EOF
Success Criteria:

✅ Responsive drawer navigation
✅ Mobile-friendly layout
✅ User menu functional
✅ Statistics cards updating
✅ Grid system working

Testing:

Mobile drawer toggle
Navigation active states
User menu interactions
Responsive breakpoints
Data loading states

Production Checklist:

 Accessibility labels added
 Keyboard navigation works
 Loading skeletons implemented
 Error states handled
 Performance optimized


6. Phase 2: Marketing Website Implementation
Task 2.1: Next.js SSR Configuration
Priority: CRITICAL | Duration: 3 hours | Score: 0/100
References:

MUI Next.js Guide
Next.js App Router

Steps:
bash# 1. Create Next.js configuration
cat > apps/website/next.config.mjs << 'EOF'
/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  modularizeImports: {
    '@mui/material': {
      transform: '@mui/material/{{member}}',
    },
    '@mui/icons-material': {
      transform: '@mui/icons-material/{{member}}',
    },
  },
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'res.cloudinary.com',
      },
    ],
  },
  experimental: {
    optimizePackageImports: ['@mui/material', '@mui/icons-material'],
  },
};

export default nextConfig;
EOF

# 2. Create app layout with SSR
cat > apps/website/src/app/layout.tsx << 'EOF'
import * as React from 'react';
import { AppRouterCacheProvider } from '@mui/material-nextjs/v14-appRouter';
import { ThemeProvider } from '@mui/material/styles';
import CssBaseline from '@mui/material/CssBaseline';
import { theme } from '@/lib/theme';
import type { Metadata } from 'next';

export const metadata: Metadata = {
  title: 'EventsOS - Fashion Event Management Platform',
  description: 'Discover and manage fashion events, connect with designers, and create unforgettable experiences.',
  keywords: 'fashion events, runway shows, fashion week, event management',
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <meta name="viewport" content="initial-scale=1, width=device-width" />
      </head>
      <body>
        <AppRouterCacheProvider options={{ enableCssLayer: true }}>
          <ThemeProvider theme={theme}>
            <CssBaseline />
            {children}
          </ThemeProvider>
        </AppRouterCacheProvider>
      </body>
    </html>
  );
}
EOF

# 3. Create theme configuration
cat > apps/website/src/lib/theme.ts << 'EOF'
'use client';

import { createTheme } from '@mui/material/styles';
import { Inter } from 'next/font/google';

const inter = Inter({
  weight: ['300', '400', '500', '600', '700'],
  subsets: ['latin'],
  display: 'swap',
});

export const theme = createTheme({
  cssVariables: {
    colorSchemeSelector: 'data-mui-color-scheme',
  },
  typography: {
    fontFamily: inter.style.fontFamily,
  },
  palette: {
    mode: 'light',
    primary: {
      main: '#1976d2',
    },
    secondary: {
      main: '#dc004e',
    },
  },
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: 'none',
        },
      },
    },
  },
});
EOF
Success Criteria:

✅ SSR working without hydration errors
✅ Theme properly initialized
✅ CSS-in-JS extraction working
✅ Fonts loading correctly
✅ SEO metadata rendered

Testing:

View source shows SSR content
No hydration warnings in console
Theme loads without flash
Font swap works correctly
Lighthouse SEO score >95

Production Checklist:

 Meta tags optimized
 Open Graph tags added
 Structured data implemented
 Sitemap generated
 Robots.txt configured


Task 2.2: Homepage Components
Priority: HIGH | Duration: 4 hours | Score: 0/100
Steps:
bash# 1. Create hero section
cat > apps/website/src/components/home/HeroSection.tsx << 'EOF'
import React from 'react';
import { Box, Container, Typography, Button, Stack } from '@mui/material';
import { ArrowForward, PlayCircle } from '@mui/icons-material';
import Link from 'next/link';

export const HeroSection: React.FC = () => {
  return (
    <Box
      sx={{
        background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
        color: 'white',
        pt: { xs: 8, md: 12 },
        pb: { xs: 8, md: 12 },
        position: 'relative',
        overflow: 'hidden',
      }}
    >
      <Container maxWidth="lg">
        <Stack spacing={4} alignItems="center" textAlign="center">
          <Typography
            variant="h1"
            sx={{
              fontSize: { xs: '2.5rem', md: '4rem' },
              fontWeight: 700,
              mb: 2,
            }}
          >
            Elevate Your Fashion Events
          </Typography>
          
          <Typography
            variant="h5"
            sx={{
              maxWidth: 800,
              opacity: 0.9,
              fontSize: { xs: '1.25rem', md: '1.5rem' },
            }}
          >
            From runway shows to exclusive galas, manage every detail of your
            fashion events with our AI-powered platform.
          </Typography>
          
          <Stack direction="row" spacing={2} sx={{ mt: 4 }}>
            <Button
              component={Link}
              href="/events"
              variant="contained"
              size="large"
              endIcon={<ArrowForward />}
              sx={{
                bgcolor: 'white',
                color: 'primary.main',
                '&:hover': {
                  bgcolor: 'grey.100',
                },
              }}
            >
              Explore Events
            </Button>
            
            <Button
              variant="outlined"
              size="large"
              startIcon={<PlayCircle />}
              sx={{
                borderColor: 'white',
                color: 'white',
                '&:hover': {
                  borderColor: 'white',
                  bgcolor: 'rgba(255, 255, 255, 0.1)',
                },
              }}
            >
              Watch Demo
            </Button>
          </Stack>
        </Stack>
      </Container>
    </Box>
  );
};
EOF

# 2. Create features section
cat > apps/website/src/components/home/FeaturesSection.tsx << 'EOF'
import React from 'react';
import {
  Container,
  Grid2 as Grid,
  Typography,
  Card,
  CardContent,
  Box,
} from '@mui/material';
import {
  CalendarMonth,
  Groups,
  Analytics,
  Campaign,
  Security,
  Speed,
} from '@mui/icons-material';

const features = [
  {
    icon: <CalendarMonth />,
    title: 'Event Management',
    description: 'Create and manage fashion shows, galas, and exhibitions with ease.',
  },
  {
    icon: <Groups />,
    title: 'Attendee Experience',
    description: 'Deliver seamless check-in and personalized experiences.',
  },
  {
    icon: <Analytics />,
    title: 'Real-time Analytics',
    description: 'Track attendance, engagement, and ROI with powerful insights.',
  },
  {
    icon: <Campaign />,
    title: 'Marketing Tools',
    description: 'Promote events across channels with integrated marketing.',
  },
  {
    icon: <Security />,
    title: 'Secure & Scalable',
    description: 'Enterprise-grade security with unlimited scalability.',
  },
  {
    icon: <Speed />,
    title: 'Lightning Fast',
    description: 'Optimized performance for the best user experience.',
  },
];

export const FeaturesSection: React.FC = () => {
  return (
    <Box sx={{ py: { xs: 8, md: 12 } }}>
      <Container maxWidth="lg">
        <Typography
          variant="h2"
          align="center"
          sx={{
            mb: 2,
            fontSize: { xs: '2rem', md: '3rem' },
            fontWeight: 600,
          }}
        >
          Everything You Need
        </Typography>
        
        <Typography
          variant="h6"
          align="center"
          color="text.secondary"
          sx={{ mb: 8, maxWidth: 600, mx: 'auto' }}
        >
          Powerful features designed specifically for fashion industry professionals
        </Typography>
        
        <Grid container spacing={4}>
          {features.map((feature, index) => (
            <Grid key={index} size={{ xs: 12, sm: 6, md: 4 }}>
              <Card
                sx={{
                  height: '100%',
                  transition: 'transform 0.2s',
                  '&:hover': {
                    transform: 'translateY(-4px)',
                  },
                }}
                elevation={0}
                variant="outlined"
              >
                <CardContent sx={{ textAlign: 'center', p: 4 }}>
                  <Box
                    sx={{
                      display: 'inline-flex',
                      p: 2,
                      bgcolor: 'primary.main',
                      color: 'white',
                      borderRadius: 2,
                      mb: 3,
                      fontSize: 40,
                    }}
                  >
                    {feature.icon}
                  </Box>
                  <Typography variant="h6" gutterBottom>
                    {feature.title}
                  </Typography>
                  <Typography variant="body2" color="text.secondary">
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
EOF
Success Criteria:

✅ Hero section responsive
✅ Features grid adaptive
✅ Animations smooth
✅ Images optimized
✅ CTA buttons working

Testing:

Mobile responsiveness
Animation performance
Link functionality
Color contrast ratios
Keyboard navigation

Production Checklist:

 Images lazy loaded
 Animations GPU accelerated
 Touch targets 44px+
 Focus indicators visible
 Loading states added


7. Phase 3: Core Event Features Development
Task 3.1: Event CRUD Operations
Priority: HIGH | Duration: 6 hours | Score: 0/100
Steps:
bash# 1. Create event list page
cat > apps/admin/src/pages/events/list.tsx << 'EOF'
import React from "react";
import {
  List,
  useDataGrid,
  EditButton,
  ShowButton,
  DeleteButton,
  DateField,
} from "@refinedev/mui";
import { DataGrid, GridColDef } from "@mui/x-data-grid";
import { Chip } from "@mui/material";

export const EventList: React.FC = () => {
  const { dataGridProps } = useDataGrid({
    resource: "events",
    pagination: {
      pageSize: 25,
    },
    sorters: {
      initial: [
        {
          field: "start_date",
          order: "desc",
        },
      ],
    },
  });

  const columns: GridColDef[] = [
    {
      field: "title",
      headerName: "Event Title",
      flex: 1,
      minWidth: 200,
    },
    {
      field: "event_type",
      headerName: "Type",
      width: 150,
      renderCell: ({ value }) => (
        <Chip
          label={value}
          color={
            value === "runway" ? "primary" : 
            value === "gala" ? "secondary" : "default"
          }
          size="small"
        />
      ),
    },
    {
      field: "start_date",
      headerName: "Start Date",
      width: 150,
      renderCell: ({ value }) => <DateField value={value} />,
    },
    {
      field: "venue",
      headerName: "Venue",
      width: 200,
      valueGetter: ({ row }) => row.venue?.name,
    },
    {
      field: "attendee_count",
      headerName: "Attendees",
      width: 120,
      type: "number",
    },
    {
      field: "status",
      headerName: "Status",
      width: 120,
      renderCell: ({ value }) => (
        <Chip
          label={value}
          color={
            value === "published" ? "success" :
            value === "draft" ? "warning" : "error"
          }
          size="small"
          variant="outlined"
        />
      ),
    },
    {
      field: "actions",
      headerName: "Actions",
      width: 120,
      sortable: false,
      renderCell: ({ row }) => (
        <>
          <EditButton hideText recordItemId={row.id} />
          <ShowButton hideText recordItemId={row.id} />
          <DeleteButton hideText recordItemId={row.id} />
        </>
      ),
    },
  ];

  return (
    <List>
      <DataGrid {...dataGridProps} columns={columns} autoHeight />
    </List>
  );
};
EOF

# 2. Create event form
cat > apps/admin/src/pages/events/create.tsx << 'EOF'
import React from "react";
import { Create } from "@refinedev/mui";
import { useForm } from "@refinedev/react-hook-form";
import {
  Box,
  TextField,
  Select,
  MenuItem,
  FormControl,
  InputLabel,
  Stack,
} from "@mui/material";
import { DateTimePicker } from "@mui/x-date-pickers/DateTimePicker";
import { Controller } from "react-hook-form";

export const EventCreate: React.FC = () => {
  const {
    saveButtonProps,
    register,
    control,
    formState: { errors },
  } = useForm();

  return (
    <Create saveButtonProps={saveButtonProps}>
      <Box component="form" sx={{ display: "flex", flexDirection: "column", gap: 3 }}>
        <TextField
          {...register("title", { required: "Title is required" })}
          error={!!errors.title}
          helperText={errors.title?.message}
          label="Event Title"
          fullWidth
        />
        
        <TextField
          {...register("description")}
          label="Description"
          multiline
          rows={4}
          fullWidth
        />
        
        <FormControl fullWidth>
          <InputLabel>Event Type</InputLabel>
          <Controller
            control={control}
            name="event_type"
            rules={{ required: "Event type is required" }}
            render={({ field }) => (
              <Select {...field} label="Event Type">
                <MenuItem value="runway">Runway Show</MenuItem>
                <MenuItem value="trade_show">Trade Show</MenuItem>
                <MenuItem value="gala">Gala</MenuItem>
                <MenuItem value="workshop">Workshop</MenuItem>
              </Select>
            )}
          />
        </FormControl>
        
        <Stack direction="row" spacing={2}>
          <Controller
            control={control}
            name="start_date"
            rules={{ required: "Start date is required" }}
            render={({ field }) => (
              <DateTimePicker
                label="Start Date & Time"
                value={field.value}
                onChange={field.onChange}
                slotProps={{
                  textField: {
                    fullWidth: true,
                    error: !!errors.start_date,
                    helperText: errors.start_date?.message,
                  },
                }}
              />
            )}
          />
          
          <Controller
            control={control}
            name="end_date"
            rules={{ required: "End date is required" }}
            render={({ field }) => (
              <DateTimePicker
                label="End Date & Time"
                value={field.value}
                onChange={field.onChange}
                slotProps={{
                  textField: {
                    fullWidth: true,
                    error: !!errors.end_date,
                    helperText: errors.end_date?.message,
                  },
                }}
              />
            )}
          />
        </Stack>
        
        <TextField
          {...register("max_attendees", { 
            valueAsNumber: true,
            min: { value: 1, message: "Must be at least 1" }
          })}
          type="number"
          label="Maximum Attendees"
          error={!!errors.max_attendees}
          helperText={errors.max_attendees?.message}
          fullWidth
        />
        
        <FormControl fullWidth>
          <InputLabel>Status</InputLabel>
          <Controller
            control={control}
            name="status"
            defaultValue="draft"
            render={({ field }) => (
              <Select {...field} label="Status">
                <MenuItem value="draft">Draft</MenuItem>
                <MenuItem value="published">Published</MenuItem>
                <MenuItem value="cancelled">Cancelled</MenuItem>
              </Select>
            )}
          />
        </FormControl>
      </Box>
    </Create>
  );
};
EOF
Success Criteria:

✅ CRUD operations working
✅ Form validation complete
✅ Date pickers functional
✅ File uploads working
✅ Real-time updates

Testing:

Create new event
Edit existing event
Delete with confirmation
Form validation errors
Optimistic updates

Production Checklist:

 Input sanitization
 XSS prevention
 CSRF protection
 Rate limiting
 Audit logging


Task 3.2: Supabase Schema & RLS
Priority: CRITICAL | Duration: 4 hours | Score: 0/100
Steps:
sql-- 1. Create database schema
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Events table
CREATE TABLE events (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  event_type TEXT CHECK (event_type IN ('runway', 'trade_show', 'gala', 'workshop')),
  start_date TIMESTAMPTZ NOT NULL,
  end_date TIMESTAMPTZ NOT NULL,
  venue_id UUID REFERENCES venues(id),
  max_attendees INTEGER DEFAULT 0,
  current_attendees INTEGER DEFAULT 0,
  status TEXT DEFAULT 'draft' CHECK (status IN ('draft', 'published', 'cancelled')),
  created_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Venues table
CREATE TABLE venues (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  address TEXT,
  city TEXT,
  capacity INTEGER,
  amenities JSONB DEFAULT '{}',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Sponsors table
CREATE TABLE sponsors (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  event_id UUID REFERENCES events(id) ON DELETE CASCADE,
  company_name TEXT NOT NULL,
  contact_email TEXT,
  contact_phone TEXT,
  tier TEXT CHECK (tier IN ('platinum', 'gold', 'silver', 'bronze')),
  logo_url TEXT,
  website TEXT,
  benefits JSONB DEFAULT '{}',
  amount DECIMAL(10, 2),
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'confirmed', 'cancelled')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Attendees table
CREATE TABLE attendees (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  event_id UUID REFERENCES events(id) ON DELETE CASCADE,
  user_id UUID REFERENCES auth.users(id),
  ticket_type TEXT CHECK (ticket_type IN ('general', 'vip', 'press', 'staff')),
  ticket_number TEXT UNIQUE,
  check_in_time TIMESTAMPTZ,
  special_requests JSONB DEFAULT '{}',
  dietary_restrictions TEXT[],
  status TEXT DEFAULT 'registered' CHECK (status IN ('registered', 'checked_in', 'cancelled')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Create indexes
CREATE INDEX idx_events_start_date ON events(start_date);
CREATE INDEX idx_events_status ON events(status);
CREATE INDEX idx_events_created_by ON events(created_by);
CREATE INDEX idx_attendees_event_id ON attendees(event_id);
CREATE INDEX idx_attendees_user_id ON attendees(user_id);
CREATE INDEX idx_sponsors_event_id ON sponsors(event_id);

-- 3. Row Level Security policies
ALTER TABLE events ENABLE ROW LEVEL SECURITY;
ALTER TABLE venues ENABLE ROW LEVEL SECURITY;
ALTER TABLE sponsors ENABLE ROW LEVEL SECURITY;
ALTER TABLE attendees ENABLE ROW LEVEL SECURITY;

-- Events policies
CREATE POLICY "Public events are viewable by everyone" ON events
  FOR SELECT USING (status = 'published');

CREATE POLICY "Users can view their own draft events" ON events
  FOR SELECT USING (auth.uid() = created_by);

CREATE POLICY "Users can create events" ON events
  FOR INSERT WITH CHECK (auth.uid() = created_by);

CREATE POLICY "Users can update their own events" ON events
  FOR UPDATE USING (auth.uid() = created_by);

CREATE POLICY "Users can delete their own events" ON events
  FOR DELETE USING (auth.uid() = created_by);

-- Attendees policies
CREATE POLICY "Users can view their own attendance" ON attendees
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "Event creators can view attendees" ON attendees
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM events 
      WHERE events.id = attendees.event_id 
      AND events.created_by = auth.uid()
    )
  );

CREATE POLICY "Users can register for events" ON attendees
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- 4. Functions and triggers
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Update attendee count
CREATE OR REPLACE FUNCTION update_event_attendee_count()
RETURNS TRIGGER AS $$
BEGIN
  IF TG_OP = 'INSERT' THEN
    UPDATE events 
    SET current_attendees = current_attendees + 1 
    WHERE id = NEW.event_id;
  ELSIF TG_OP = 'DELETE' THEN
    UPDATE events 
    SET current_attendees = current_attendees - 1 
    WHERE id = OLD.event_id;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_attendee_count
AFTER INSERT OR DELETE ON attendees
FOR EACH ROW EXECUTE FUNCTION update_event_attendee_count();
Success Criteria:

✅ Schema created successfully
✅ RLS policies active
✅ Indexes optimized
✅ Triggers functioning
✅ Performance acceptable

Testing:

RLS policy verification
Trigger functionality
Index performance
Foreign key constraints
Data integrity checks

Production Checklist:

 Backup strategy defined
 Migration scripts ready
 Performance benchmarked
 Security audit passed
 Monitoring configured


8. Phase 4: Testing & Quality Assurance
Task 4.1: Testing Infrastructure Setup
Priority: CRITICAL | Duration: 4 hours | Score: 0/100
Steps:
bash# 1. Install testing dependencies
pnpm add -DE jest @types/jest ts-jest
pnpm add -DE @testing-library/react @testing-library/jest-dom @testing-library/user-event
pnpm add -DE @playwright/test @axe-core/playwright
pnpm add -DE msw whatwg-fetch

# 2. Create Jest configuration
cat > jest.config.js << 'EOF'
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'jsdom',
  setupFilesAfterEnv: ['<rootDir>/jest.setup.ts'],
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1',
    '\\.(css|less|scss|sass)$': 'identity-obj-proxy',
  },
  transform: {
    '^.+\\.(ts|tsx)$': ['ts-jest', {
      tsconfig: {
        jsx: 'react',
      },
    }],
  },
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },
};
EOF

# 3. Create Jest setup file
cat > jest.setup.ts << 'EOF'
import '@testing-library/jest-RetrySContinueEditbash# 3. Create Jest setup file (continued)
cat > jest.setup.ts << 'EOF'
import '@testing-library/jest-dom';
import { cleanup } from '@testing-library/react';
import { afterEach } from 'vitest';

// Cleanup after each test
afterEach(() => {
 cleanup();
});

// Mock Next.js router
jest.mock('next/router', () => ({
 useRouter: () => ({
   push: jest.fn(),
   replace: jest.fn(),
   prefetch: jest.fn(),
   query: {},
   pathname: '/',
 }),
}));

// Mock window.matchMedia
Object.defineProperty(window, 'matchMedia', {
 writable: true,
 value: jest.fn().mockImplementation(query => ({
   matches: false,
   media: query,
   onchange: null,
   addListener: jest.fn(),
   removeListener: jest.fn(),
   addEventListener: jest.fn(),
   removeEventListener: jest.fn(),
   dispatchEvent: jest.fn(),
 })),
});
EOF

# 4. Create Playwright configuration
cat > playwright.config.ts << 'EOF'
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
 testDir: './e2e',
 fullyParallel: true,
 forbidOnly: !!process.env.CI,
 retries: process.env.CI ? 2 : 0,
 workers: process.env.CI ? 1 : undefined,
 reporter: 'html',
 use: {
   baseURL: 'http://localhost:3000',
   trace: 'on-first-retry',
   screenshot: 'only-on-failure',
 },
 projects: [
   {
     name: 'chromium',
     use: { ...devices['Desktop Chrome'] },
   },
   {
     name: 'firefox',
     use: { ...devices['Desktop Firefox'] },
   },
   {
     name: 'webkit',
     use: { ...devices['Desktop Safari'] },
   },
   {
     name: 'Mobile Chrome',
     use: { ...devices['Pixel 5'] },
   },
   {
     name: 'Mobile Safari',
     use: { ...devices['iPhone 12'] },
   },
 ],
 webServer: {
   command: 'pnpm dev',
   port: 3000,
   reuseExistingServer: !process.env.CI,
 },
});
EOF

# 5. Create test scripts in package.json
cat >> package.json << 'EOF'
{
 "scripts": {
   "test": "jest",
   "test:watch": "jest --watch",
   "test:coverage": "jest --coverage",
   "test:e2e": "playwright test",
   "test:e2e:ui": "playwright test --ui",
   "test:a11y": "pa11y-ci"
 }
}
EOF
Success Criteria:

✅ Jest configured and running
✅ Playwright installed
✅ Coverage reporting works
✅ E2E tests executable
✅ A11y tests configured

Testing:

Unit test execution
Coverage report generation
E2E test suite runs
Cross-browser testing
Accessibility validation

Production Checklist:

 CI integration complete
 Coverage thresholds met
 Test data management
 Performance benchmarks
 Security testing added


Task 4.2: Component Unit Tests
Priority: HIGH | Duration: 6 hours | Score: 0/100
Steps:
bash# 1. Create EventCard test
cat > __tests__/components/EventCard.test.tsx << 'EOF'
import React from 'react';
import { render, screen, fireEvent } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { EventCard } from '@/components/EventCard';
import { ThemeProvider } from '@mui/material/styles';
import { theme } from '@/lib/theme';

const mockEvent = {
  id: '1',
  title: 'Fashion Week 2024',
  description: 'Annual fashion showcase',
  event_type: 'runway',
  start_date: '2024-09-15T19:00:00Z',
  venue: {
    name: 'Grand Ballroom',
    city: 'New York',
  },
  image_url: 'https://example.com/image.jpg',
  current_attendees: 150,
  max_attendees: 200,
};

const renderWithTheme = (component: React.ReactNode) => {
  return render(
    <ThemeProvider theme={theme}>
      {component}
    </ThemeProvider>
  );
};

describe('EventCard', () => {
  it('renders event information correctly', () => {
    renderWithTheme(<EventCard event={mockEvent} />);
    
    expect(screen.getByText('Fashion Week 2024')).toBeInTheDocument();
    expect(screen.getByText('Annual fashion showcase')).toBeInTheDocument();
    expect(screen.getByText('Grand Ballroom, New York')).toBeInTheDocument();
    expect(screen.getByText('150 / 200 attendees')).toBeInTheDocument();
  });

  it('displays correct event type chip', () => {
    renderWithTheme(<EventCard event={mockEvent} />);
    
    const chip = screen.getByText('runway');
    expect(chip).toHaveClass('MuiChip-colorPrimary');
  });

  it('handles click events', async () => {
    const handleClick = jest.fn();
    renderWithTheme(<EventCard event={mockEvent} onClick={handleClick} />);
    
    const card = screen.getByRole('article');
    await userEvent.click(card);
    
    expect(handleClick).toHaveBeenCalledWith(mockEvent);
  });

  it('shows sold out badge when full', () => {
    const soldOutEvent = {
      ...mockEvent,
      current_attendees: 200,
    };
    
    renderWithTheme(<EventCard event={soldOutEvent} />);
    expect(screen.getByText('SOLD OUT')).toBeInTheDocument();
  });

  it('is keyboard accessible', async () => {
    const handleClick = jest.fn();
    renderWithTheme(<EventCard event={mockEvent} onClick={handleClick} />);
    
    const card = screen.getByRole('article');
    card.focus();
    
    await userEvent.keyboard('{Enter}');
    expect(handleClick).toHaveBeenCalled();
  });
});
EOF

# 2. Create Form validation test
cat > __tests__/utils/validation.test.ts << 'EOF'
import { validateEventForm, validateEmail, validateDateRange } from '@/utils/validation';

describe('Event Form Validation', () => {
  describe('validateEventForm', () => {
    it('validates required fields', () => {
      const errors = validateEventForm({});
      
      expect(errors.title).toBe('Title is required');
      expect(errors.start_date).toBe('Start date is required');
      expect(errors.event_type).toBe('Event type is required');
    });

    it('validates date range', () => {
      const errors = validateEventForm({
        title: 'Test Event',
        start_date: '2024-12-31',
        end_date: '2024-12-30',
        event_type: 'gala',
      });
      
      expect(errors.end_date).toBe('End date must be after start date');
    });

    it('validates max attendees', () => {
      const errors = validateEventForm({
        title: 'Test Event',
        start_date: '2024-12-30',
        end_date: '2024-12-31',
        event_type: 'workshop',
        max_attendees: -1,
      });
      
      expect(errors.max_attendees).toBe('Must be a positive number');
    });

    it('passes valid form data', () => {
      const errors = validateEventForm({
        title: 'Fashion Gala 2024',
        description: 'Annual charity gala',
        start_date: '2024-12-30T19:00:00Z',
        end_date: '2024-12-30T23:00:00Z',
        event_type: 'gala',
        max_attendees: 200,
      });
      
      expect(Object.keys(errors)).toHaveLength(0);
    });
  });

  describe('validateEmail', () => {
    it('validates correct email formats', () => {
      expect(validateEmail('user@example.com')).toBe(true);
      expect(validateEmail('user+tag@example.co.uk')).toBe(true);
    });

    it('rejects invalid email formats', () => {
      expect(validateEmail('invalid')).toBe(false);
      expect(validateEmail('user@')).toBe(false);
      expect(validateEmail('@example.com')).toBe(false);
    });
  });

  describe('validateDateRange', () => {
    it('validates correct date ranges', () => {
      const start = new Date('2024-01-01');
      const end = new Date('2024-01-02');
      expect(validateDateRange(start, end)).toBe(true);
    });

    it('rejects invalid date ranges', () => {
      const start = new Date('2024-01-02');
      const end = new Date('2024-01-01');
      expect(validateDateRange(start, end)).toBe(false);
    });
  });
});
EOF

# 3. Create integration test
cat > __tests__/integration/eventFlow.test.tsx << 'EOF'
import React from 'react';
import { render, screen, waitFor } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { rest } from 'msw';
import { setupServer } from 'msw/node';
import { EventsPage } from '@/pages/events';
import { TestWrapper } from '@/test/utils';

const server = setupServer(
  rest.get('/api/events', (req, res, ctx) => {
    return res(
      ctx.json({
        data: [
          {
            id: '1',
            title: 'Fashion Week',
            start_date: '2024-09-15',
            event_type: 'runway',
          },
        ],
        total: 1,
      })
    );
  }),
  
  rest.post('/api/events', async (req, res, ctx) => {
    const body = await req.json();
    return res(
      ctx.status(201),
      ctx.json({
        id: '2',
        ...body,
      })
    );
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());

describe('Event Management Flow', () => {
  it('displays events list', async () => {
    render(
      <TestWrapper>
        <EventsPage />
      </TestWrapper>
    );
    
    await waitFor(() => {
      expect(screen.getByText('Fashion Week')).toBeInTheDocument();
    });
  });

  it('creates new event', async () => {
    const user = userEvent.setup();
    
    render(
      <TestWrapper>
        <EventsPage />
      </TestWrapper>
    );
    
    // Click create button
    await user.click(screen.getByText('Create Event'));
    
    // Fill form
    await user.type(screen.getByLabelText('Event Title'), 'New Fashion Show');
    await user.selectOptions(screen.getByLabelText('Event Type'), 'runway');
    
    // Submit
    await user.click(screen.getByText('Save'));
    
    await waitFor(() => {
      expect(screen.getByText('Event created successfully')).toBeInTheDocument();
    });
  });

  it('handles API errors gracefully', async () => {
    server.use(
      rest.get('/api/events', (req, res, ctx) => {
        return res(ctx.status(500), ctx.json({ error: 'Server error' }));
      })
    );
    
    render(
      <TestWrapper>
        <EventsPage />
      </TestWrapper>
    );
    
    await waitFor(() => {
      expect(screen.getByText('Failed to load events')).toBeInTheDocument();
    });
  });
});
EOF
Success Criteria:

✅ Component tests passing
✅ Integration tests working
✅ API mocking functional
✅ Edge cases covered
✅ Coverage >80%

Testing:

Run unit test suite
Check coverage report
Verify mock data
Test error scenarios
Performance benchmarks

Production Checklist:

 All components tested
 Critical paths covered
 Error boundaries tested
 Performance tests added
 Security tests included


Task 4.3: E2E & Accessibility Tests
Priority: HIGH | Duration: 4 hours | Score: 0/100
Steps:
bash# 1. Create E2E test for event creation
cat > e2e/event-creation.spec.ts << 'EOF'
import { test, expect } from '@playwright/test';
import { AxeBuilder } from '@axe-core/playwright';

test.describe('Event Creation Flow', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/login');
    await page.fill('[name="email"]', 'test@example.com');
    await page.fill('[name="password"]', 'password123');
    await page.click('button[type="submit"]');
    await expect(page).toHaveURL('/dashboard');
  });

  test('creates new fashion event', async ({ page }) => {
    // Navigate to events
    await page.click('text=Events');
    await expect(page).toHaveURL('/events');
    
    // Click create button
    await page.click('text=Create Event');
    
    // Fill form
    await page.fill('[name="title"]', 'Summer Fashion Show 2024');
    await page.fill('[name="description"]', 'Exclusive runway show featuring emerging designers');
    await page.selectOption('[name="event_type"]', 'runway');
    
    // Set dates
    await page.click('[data-testid="start-date"]');
    await page.click('text=15'); // Select date
    await page.click('text=OK');
    
    await page.fill('[name="max_attendees"]', '200');
    
    // Upload image
    const fileInput = await page.locator('input[type="file"]');
    await fileInput.setInputFiles('test-assets/event-image.jpg');
    
    // Submit form
    await page.click('button[type="submit"]');
    
    // Verify success
    await expect(page.locator('.MuiAlert-success')).toContainText('Event created successfully');
    await expect(page).toHaveURL(/\/events\/\d+/);
  });

  test('validates required fields', async ({ page }) => {
    await page.goto('/events/create');
    
    // Try to submit empty form
    await page.click('button[type="submit"]');
    
    // Check validation messages
    await expect(page.locator('text=Title is required')).toBeVisible();
    await expect(page.locator('text=Event type is required')).toBeVisible();
    await expect(page.locator('text=Start date is required')).toBeVisible();
  });

  test('has no accessibility violations', async ({ page }) => {
    await page.goto('/events/create');
    
    const accessibilityScanResults = await new AxeBuilder({ page })
      .withTags(['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa'])
      .analyze();
    
    expect(accessibilityScanResults.violations).toEqual([]);
  });
});
EOF

# 2. Create mobile responsiveness test
cat > e2e/mobile-responsive.spec.ts << 'EOF'
import { test, expect, devices } from '@playwright/test';

test.describe('Mobile Responsiveness', () => {
  test.use(devices['iPhone 12']);

  test('navigation menu works on mobile', async ({ page }) => {
    await page.goto('/');
    
    // Check hamburger menu is visible
    await expect(page.locator('[data-testid="mobile-menu"]')).toBeVisible();
    
    // Open menu
    await page.click('[data-testid="mobile-menu"]');
    
    // Check menu items
    await expect(page.locator('nav[role="navigation"]')).toBeVisible();
    await expect(page.locator('text=Events')).toBeVisible();
    await expect(page.locator('text=Designers')).toBeVisible();
    
    // Navigate to events
    await page.click('text=Events');
    await expect(page).toHaveURL('/events');
    
    // Check mobile layout
    const eventCards = await page.locator('[data-testid="event-card"]').all();
    for (const card of eventCards) {
      const box = await card.boundingBox();
      expect(box?.width).toBeLessThan(400); // Mobile width
    }
  });

  test('forms are usable on mobile', async ({ page }) => {
    await page.goto('/contact');
    
    // Check form elements are properly sized
    const inputs = await page.locator('input, textarea').all();
    for (const input of inputs) {
      const box = await input.boundingBox();
      expect(box?.height).toBeGreaterThanOrEqual(44); // Touch target size
    }
    
    // Test form interaction
    await page.fill('[name="name"]', 'Test User');
    await page.fill('[name="email"]', 'test@example.com');
    await page.fill('[name="message"]', 'Test message');
    
    // Submit should work
    await page.click('button[type="submit"]');
    await expect(page.locator('.MuiAlert-success')).toBeVisible();
  });
});
EOF

# 3. Create performance test
cat > e2e/performance.spec.ts << 'EOF'
import { test, expect } from '@playwright/test';

test.describe('Performance Tests', () => {
  test('homepage loads within performance budget', async ({ page }) => {
    const startTime = Date.now();
    
    await page.goto('/', { waitUntil: 'networkidle' });
    
    const loadTime = Date.now() - startTime;
    expect(loadTime).toBeLessThan(3000); // 3 second budget
    
    // Check Core Web Vitals
    const metrics = await page.evaluate(() => {
      return new Promise((resolve) => {
        new PerformanceObserver((list) => {
          const entries = list.getEntries();
          const fcp = entries.find(e => e.name === 'first-contentful-paint');
          const lcp = entries.find(e => e.entryType === 'largest-contentful-paint');
          
          resolve({
            fcp: fcp?.startTime,
            lcp: lcp?.startTime,
          });
        }).observe({ entryTypes: ['paint', 'largest-contentful-paint'] });
      });
    });
    
    expect(metrics.fcp).toBeLessThan(1800); // FCP < 1.8s
    expect(metrics.lcp).toBeLessThan(2500); // LCP < 2.5s
  });

  test('events page handles large datasets', async ({ page }) => {
    // Mock API to return 1000 events
    await page.route('/api/events*', async (route) => {
      const events = Array.from({ length: 1000 }, (_, i) => ({
        id: i + 1,
        title: `Event ${i + 1}`,
        start_date: new Date().toISOString(),
        event_type: 'runway',
      }));
      
      await route.fulfill({
        status: 200,
        contentType: 'application/json',
        body: JSON.stringify({ data: events, total: 1000 }),
      });
    });
    
    await page.goto('/events');
    
    // Check virtual scrolling works
    const visibleItems = await page.locator('[data-testid="event-row"]').count();
    expect(visibleItems).toBeLessThan(50); // Should virtualize
    
    // Scroll performance
    const scrollStartTime = Date.now();
    await page.evaluate(() => window.scrollTo(0, document.body.scrollHeight));
    const scrollTime = Date.now() - scrollStartTime;
    
    expect(scrollTime).toBeLessThan(100); // Smooth scrolling
  });
});
EOF

# 4. Create accessibility audit script
cat > scripts/a11y-audit.js << 'EOF'
const pa11y = require('pa11y');
const fs = require('fs').promises;

const urls = [
  'http://localhost:3000',
  'http://localhost:3000/events',
  'http://localhost:3000/about',
  'http://localhost:3000/contact',
];

async function runAudit() {
  const results = [];
  
  for (const url of urls) {
    console.log(`Auditing ${url}...`);
    
    try {
      const result = await pa11y(url, {
        standard: 'WCAG2AA',
        runners: ['axe', 'htmlcs'],
        includeWarnings: true,
      });
      
      results.push({
        url,
        issues: result.issues,
        summary: {
          errors: result.issues.filter(i => i.type === 'error').length,
          warnings: result.issues.filter(i => i.type === 'warning').length,
          notices: result.issues.filter(i => i.type === 'notice').length,
        },
      });
    } catch (error) {
      results.push({
        url,
        error: error.message,
      });
    }
  }
  
  // Generate report
  const report = {
    timestamp: new Date().toISOString(),
    results,
    summary: {
      totalErrors: results.reduce((sum, r) => sum + (r.summary?.errors || 0), 0),
      totalWarnings: results.reduce((sum, r) => sum + (r.summary?.warnings || 0), 0),
    },
  };
  
  await fs.writeFile(
    'a11y-report.json',
    JSON.stringify(report, null, 2)
  );
  
  console.log('\nAccessibility Audit Complete');
  console.log(`Total Errors: ${report.summary.totalErrors}`);
  console.log(`Total Warnings: ${report.summary.totalWarnings}`);
  
  process.exit(report.summary.totalErrors > 0 ? 1 : 0);
}

runAudit();
EOF
Success Criteria:

✅ E2E tests passing
✅ Mobile tests working
✅ Performance within budget
✅ Zero a11y violations
✅ Cross-browser compatible

Testing:

Run E2E test suite
Mobile device testing
Performance profiling
Accessibility audit
Browser matrix validation

Production Checklist:

 All user journeys tested
 Performance budgets met
 WCAG 2.1 AA compliant
 Mobile experience verified
 Security headers tested


9. Phase 5: Production Deployment & Launch
Task 5.1: CI/CD Pipeline Setup
Priority: CRITICAL | Duration: 3 hours | Score: 0/100
Steps:
bash# 1. Create GitHub Actions workflow
mkdir -p .github/workflows
cat > .github/workflows/ci.yml << 'EOF'
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  NODE_VERSION: '18.19.1'
  PNPM_VERSION: '9.7.0'

jobs:
  validate:
    name: Validate Code
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          
      - name: Setup pnpm
        uses: pnpm/action-setup@v2
        with:
          version: ${{ env.PNPM_VERSION }}
          
      - name: Get pnpm store directory
        id: pnpm-cache
        shell: bash
        run: |
          echo "STORE_PATH=$(pnpm store path)" >> $GITHUB_OUTPUT
          
      - name: Setup pnpm cache
        uses: actions/cache@v3
        with:
          path: ${{ steps.pnpm-cache.outputs.STORE_PATH }}
          key: ${{ runner.os }}-pnpm-store-${{ hashFiles('**/pnpm-lock.yaml') }}
          restore-keys: |
            ${{ runner.os }}-pnpm-store-
            
      - name: Install dependencies
        run: pnpm install --frozen-lockfile
        
      - name: Validate lockfile
        run: |
          if [ -n "$(git status --porcelain pnpm-lock.yaml)" ]; then
            echo "Error: pnpm-lock.yaml is out of sync"
            exit 1
          fi
          
      - name: Type check
        run: pnpm type-check
        
      - name: Lint
        run: pnpm lint
        
      - name: Format check
        run: pnpm format:check

  test:
    name: Test Suite
    runs-on: ubuntu-latest
    needs: validate
    
    strategy:
      matrix:
        test-type: [unit, integration, a11y]
        
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup environment
        uses: ./.github/actions/setup
        
      - name: Run ${{ matrix.test-type }} tests
        run: pnpm test:${{ matrix.test-type }}
        
      - name: Upload coverage
        if: matrix.test-type == 'unit'
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage/lcov.info

  e2e:
    name: E2E Tests
    runs-on: ubuntu-latest
    needs: validate
    
    strategy:
      matrix:
        browser: [chromium, firefox, webkit]
        
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup environment
        uses: ./.github/actions/setup
        
      - name: Install Playwright
        run: pnpm playwright install --with-deps ${{ matrix.browser }}
        
      - name: Run E2E tests
        run: pnpm test:e2e --project=${{ matrix.browser }}
        
      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: playwright-report-${{ matrix.browser }}
          path: playwright-report/

  build:
    name: Build Application
    runs-on: ubuntu-latest
    needs: [validate, test]
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup environment
        uses: ./.github/actions/setup
        
      - name: Build applications
        run: |
          pnpm build:admin
          pnpm build:website
          
      - name: Check bundle size
        run: |
          pnpm analyze
          # Fail if bundle exceeds limit
          
      - name: Upload build artifacts
        uses: actions/upload-artifact@v3
        with:
          name: build-artifacts
          path: |
            apps/admin/.next
            apps/website/.next

  deploy-preview:
    name: Deploy Preview
    runs-on: ubuntu-latest
    needs: build
    if: github.event_name == 'pull_request'
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          github-comment: true

  deploy-production:
    name: Deploy to Production
    runs-on: ubuntu-latest
    needs: [build, e2e]
    if: github.ref == 'refs/heads/main'
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Deploy to Vercel Production
        uses: amondnet/vercel-action@v25
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.VERCEL_ORG_ID }}
          vercel-project-id: ${{ secrets.VERCEL_PROJECT_ID }}
          vercel-args: '--prod'
          
      - name: Run smoke tests
        run: |
          pnpm test:smoke --url=${{ steps.deploy.outputs.url }}
          
      - name: Notify team
        uses: 8398a7/action-slack@v3
        with:
          status: ${{ job.status }}
          text: 'Production deployment completed'
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
EOF

# 2. Create reusable setup action
mkdir -p .github/actions/setup
cat > .github/actions/setup/action.yml << 'EOF'
name: 'Setup Environment'
description: 'Setup Node.js, pnpm, and dependencies'

runs:
  using: 'composite'
  steps:
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18.19.1'
        
    - name: Setup pnpm
      uses: pnpm/action-setup@v2
      with:
        version: '9.7.0'
        
    - name: Get pnpm store directory
      id: pnpm-cache
      shell: bash
      run: |
        echo "STORE_PATH=$(pnpm store path)" >> $GITHUB_OUTPUT
        
    - name: Setup pnpm cache
      uses: actions/cache@v3
      with:
        path: ${{ steps.pnpm-cache.outputs.STORE_PATH }}
        key: ${{ runner.os }}-pnpm-store-${{ hashFiles('**/pnpm-lock.yaml') }}
        restore-keys: |
          ${{ runner.os }}-pnpm-store-
          
    - name: Install dependencies
      shell: bash
      run: pnpm install --frozen-lockfile
EOF
Success Criteria:

✅ CI pipeline running
✅ All checks passing
✅ Preview deployments working
✅ Production deploys automated
✅ Notifications configured

Testing:

Create test PR
Verify all checks run
Preview deployment works
Merge to main
Production deployment succeeds

Production Checklist:

 Secrets configured
 Branch protection enabled
 Required checks set
 Deploy permissions restricted
 Rollback procedure tested


Task 5.2: Vercel Production Configuration
Priority: CRITICAL | Duration: 2 hours | Score: 0/100
Steps:
bash# 1. Create Vercel configuration
cat > vercel.json << 'EOF'
{
  "$schema": "https://openapi.vercel.sh/vercel.json",
  "framework": "nextjs",
  "buildCommand": "pnpm build",
  "installCommand": "pnpm install --frozen-lockfile",
  "regions": ["iad1"],
  "functions": {
    "apps/website/api/*": {
      "maxDuration": 30,
      "memory": 1024
    },
    "apps/admin/api/*": {
      "maxDuration": 60,
      "memory": 1024
    }
  },
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        },
        {
          "key": "Referrer-Policy",
          "value": "strict-origin-when-cross-origin"
        },
        {
          "key": "Permissions-Policy",
          "value": "camera=(), microphone=(), geolocation=()"
        }
      ]
    },
    {
      "source": "/(.*).js",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    },
    {
      "source": "/(.*).css",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "public, max-age=31536000, immutable"
        }
      ]
    },
    {
      "source": "/api/(.*)",
      "headers": [
        {
          "key": "Cache-Control",
          "value": "no-store, max-age=0"
        }
      ]
    }
  ],
  "rewrites": [
    {
      "source": "/admin/:path*",
      "destination": "/apps/admin/:path*"
    }
  ],
  "env": {
    "NODE_OPTIONS": "--max-old-space-size=4096"
  }
}
EOF

# 2. Create environment variable configuration
cat > .env.production << 'EOF'
# Production Environment Variables
# Copy to Vercel Dashboard

# Database
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_KEY=your-service-key

# Authentication
NEXTAUTH_URL=https://eventos.yourdomain.com
NEXTAUTH_SECRET=generate-with-openssl-rand-base64-32

# External Services
CLOUDINARY_URL=cloudinary://api_key:api_secret@cloud_name
NEXT_PUBLIC_CLOUDINARY_CLOUD_NAME=your-cloud-name

# Analytics
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX
NEXT_PUBLIC_VERCEL_ANALYTICS_ID=your-analytics-id

# Monitoring
SENTRY_DSN=https://your-sentry-dsn
SENTRY_AUTH_TOKEN=your-sentry-token

# Feature Flags
NEXT_PUBLIC_ENABLE_ANALYTICS=true
NEXT_PUBLIC_ENABLE_CHAT_SUPPORT=true
EOF

# 3. Create CSP configuration
cat > lib/csp.ts << 'EOF'
export const ContentSecurityPolicy = `
  default-src 'self';
  script-src 'self' 'unsafe-eval' 'unsafe-inline' *.vercel-analytics.com *.google-analytics.com;
  style-src 'self' 'unsafe-inline' *.googleapis.com;
  img-src 'self' blob: data: *.cloudinary.com *.google-analytics.com;
  font-src 'self' *.gstatic.com;
  connect-src 'self' *.supabase.co *.google-analytics.com *.vercel-analytics.com;
  media-src 'self' *.cloudinary.com;
  object-src 'none';
  base-uri 'self';
  form-action 'self';
  frame-ancestors 'none';
  upgrade-insecure-requests;
`;

export const securityHeaders = [
  {
    key: 'Content-Security-Policy',
    value: ContentSecurityPolicy.replace(/\s{2,}/g, ' ').trim()
  }
];
EOF
Success Criteria:

✅ Vercel project configured
✅ Environment variables set
✅ Security headers active
✅ Caching optimized
✅ Functions configured

Testing:

Deploy to preview
Check security headers
Verify env variables
Test function timeouts
Validate caching

Production Checklist:

 Custom domain configured
 SSL certificate active
 Analytics enabled
 Error tracking setup
 Performance monitoring on


Task 5.3: Monitoring & Analytics Setup
Priority: HIGH | Duration: 3 hours | Score: 0/100
Steps:
bash# 1. Install monitoring dependencies
pnpm add -E @sentry/nextjs@7.100.0
pnpm add -E @vercel/analytics@1.1.0
pnpm add -E @vercel/speed-insights@1.0.0

# 2. Configure Sentry
cat > sentry.client.config.ts << 'EOF'
import * as Sentry from '@sentry/nextjs';

Sentry.init({
  dsn: process.env.NEXT_PUBLIC_SENTRY_DSN,
  environment: process.env.NODE_ENV,
  integrations: [
    Sentry.replayIntegration({
      maskAllText: false,
      blockAllMedia: false,
    }),
  ],
  tracesSampleRate: process.env.NODE_ENV === 'production' ? 0.1 : 1.0,
  replaysSessionSampleRate: 0.1,
  replaysOnErrorSampleRate: 1.0,
  beforeSend(event, hint) {
    // Filter out non-critical errors
    if (event.exception) {
      const error = hint.originalException;
      // Add custom filtering logic
    }
    return event;
  },
});
EOF

# 3. Create analytics wrapper
cat > components/Analytics.tsx << 'EOF'
'use client';

import { Analytics as VercelAnalytics } from '@vercel/analytics/react';
import { SpeedInsights } from '@vercel/speed-insights/next';
import Script from 'next/script';

export function Analytics() {
  const GA_ID = process.env.NEXT_PUBLIC_GA_ID;

  return (
    <>
      <VercelAnalytics />
      <SpeedInsights />
      
      {GA_ID && (
        <>
          <Script
            src={`https://www.googletagmanager.com/gtag/js?id=${GA_ID}`}
            strategy="afterInteractive"
          />
          <Script id="google-analytics" strategy="afterInteractive">
            {`
              window.dataLayer = window.dataLayer || [];
              function gtag(){dataLayer.push(arguments);}
              gtag('js', new Date());
              gtag('config', '${GA_ID}', {
                page_path: window.location.pathname,
              });
            `}
          </Script>
        </>
      )}
    </>
  );
}
EOF

# 4. Create health check endpoint
cat > app/api/health/route.ts << 'EOF'
import { NextResponse } from 'next/server';
import { supabaseClient } from '@/lib/supabase';

export async function GET() {
  const checks = {
    status: 'healthy',
    timestamp: new Date().toISOString(),
    checks: {
      database: 'unknown',
      auth: 'unknown',
      storage: 'unknown',
    },
  };

  try {
    // Check database
    const { error: dbError } = await supabaseClient
      .from('events')
      .select('id')
      .limit(1);
    
    checks.checks.database = dbError ? 'unhealthy' : 'healthy';

    // Check auth
    const { error: authError } = await supabaseClient.auth.getSession();
    checks.checks.auth = authError ? 'unhealthy' : 'healthy';

    // Check storage
    const { error: storageError } = await supabaseClient
      .storage
      .from('images')
      .list('', { limit: 1 });
    
    checks.checks.storage = storageError ? 'unhealthy' : 'healthy';

    // Overall status
    const allHealthy = Object.values(checks.checks).every(
      (status) => status === 'healthy'
    );
    
    checks.status = allHealthy ? 'healthy' : 'degraded';

    return NextResponse.json(checks, {
      status: allHealthy ? 200 : 503,
    });
  } catch (error) {
    return NextResponse.json(
      {
        status: 'unhealthy',
        timestamp: new Date().toISOString(),
        error: error.message,
      },
      { status: 503 }
    );
  }
}
EOF

# 5. Create monitoring dashboard
cat > scripts/monitoring-setup.sh << 'EOF'
#!/bin/bash

# Setup Better Uptime monitoring
curl -X POST https://betteruptime.com/api/v2/monitors \
  -H "Authorization: Bearer $BETTER_UPTIME_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "monitor_type": "status",
    "url": "https://eventos.yourdomain.com/api/health",
    "regions": ["us", "eu", "as"],
    "check_frequency": 180,
    "request_timeout": 30,
    "confirmation_period": 2,
    "expected_status_codes": [200]
  }'

# Setup Vercel monitoring
vercel env add NEXT_PUBLIC_VERCEL_ANALYTICS_ID production
vercel env add MONITORING_EMAIL production

echo "Monitoring setup complete!"
EOF

chmod +x scripts/monitoring-setup.sh
Success Criteria:

✅ Sentry error tracking active
✅ Analytics collecting data
✅ Performance monitoring on
✅ Health checks passing
✅ Uptime monitoring configured

Testing:

Trigger test error
Verify Sentry capture
Check analytics data
Test health endpoint
Simulate downtime

Production Checklist:

 Error alerts configured
 Performance budgets set
 Custom dashboards created
 Team access granted
 Runbooks documented


10. Component Architecture & Integration
Refine + MUI v6 Component Map
Component TypeRefine ComponentMUI v6 ComponentUse CaseDocumentationData DisplayTable<DataGrid>@mui/x-data-gridEvent listingsDataGrid DocsList<List>List, ListItemNavigation menusList DocsShow<Show>Card, TypographyEvent detailsRefine ShowFormsCreate<Create>TextField, SelectNew eventsRefine CreateEdit<Edit>Form componentsUpdate eventsRefine EditAutoCompleteuseAutoCompleteAutocompleteVenue selectionAutoComplete HookLayoutLayout<ThemedLayoutV2>Box, DrawerAdmin shellThemed LayoutGrid-Grid2Responsive layoutsGrid SystemContainer-ContainerContent wrapperContainerNavigationBreadcrumb<Breadcrumb>BreadcrumbsPage navigationBreadcrumbMenu<ThemedSiderV2>Drawer, ListSidebar menuSiderFeedbackNotificationuseNotificationSnackbar, AlertSuccess/ErrorNotificationsLoading<LoadingComponent>Skeleton, CircularProgressLoading statesMUI SkeletonAuthenticationLogin<AuthPage>Custom formUser loginAuth PagesRegister<AuthPage>Custom formUser signupMUI Auth Example
Integration Patterns
typescript// Example: Event List with Refine + MUI v6
import { List, useDataGrid } from "@refinedev/mui";
import { DataGrid, GridColDef, GridToolbar } from "@mui/x-data-grid";
import { Box, Chip, IconButton, Tooltip } from "@mui/material";
import { Edit, Visibility, Delete } from "@mui/icons-material";

export const EventList = () => {
  const { dataGridProps } = useDataGrid({
    resource: "events",
    pagination: { pageSize: 25 },
    sorters: { initial: [{ field: "start_date", order: "desc" }] },
    filters: { initial: [{ field: "status", operator: "eq", value: "published" }] },
  });

  const columns: GridColDef[] = [
    // Column definitions with MUI components
  ];

  return (
    <List>
      <DataGrid
        {...dataGridProps}
        columns={columns}
        slots={{ toolbar: GridToolbar }}
        slotProps={{
          toolbar: {
            showQuickFilter: true,
            quickFilterProps: { debounceMs: 500 },
          },
        }}
      />
    </List>
  );
};

11. Production Readiness Master Checklist
Infrastructure Readiness
CategoryItemStatusPriorityVerificationEnvironment✅Node.js 18.19.1 locked⏸️CRITICALnode --version✅pnpm 9.7.0 configured⏸️CRITICALpnpm --version✅Git hooks active⏸️HIGHCommit test✅Environment variables set⏸️CRITICALBuild testDependencies✅All versions pinned⏸️CRITICALpnpm ls✅Lockfile synced⏸️CRITICALpnpm install --frozen-lockfile✅Security audit passed⏸️HIGHpnpm audit✅Licenses verified⏸️MEDIUMLicense checkerBuild Process✅TypeScript strict mode⏸️HIGHpnpm type-check✅ESLint no errors⏸️HIGHpnpm lint✅Build succeeds⏸️CRITICALpnpm build✅Bundle size <500KB⏸️HIGHBundle analyzer
Security Checklist
CategoryItemStatusPriorityVerificationAuthentication✅Supabase RLS enabled⏸️CRITICALPolicy test✅Session management⏸️CRITICALAuth flow test✅Password policies⏸️HIGHValidation test✅2FA available⏸️MEDIUMFeature testData Protection✅HTTPS enforced⏸️CRITICALSSL test✅CSP headers set⏸️HIGHHeader check✅XSS prevention⏸️CRITICALSecurity scan✅SQL injection blocked⏸️CRITICALPenetration testAPI Security✅Rate limiting active⏸️HIGHLoad test✅CORS configured⏸️HIGHCross-origin test✅API keys secured⏸️CRITICALEnv check✅Input validation⏸️HIGHFuzzing test
Performance Checklist
MetricTargetCurrentStatusActionCore Web VitalsLCP<2.5s-⏸️Optimize imagesFID<100ms-⏸️Reduce JSCLS<0.1-⏸️Fix layout shiftsLoad PerformanceFirst Load JS<300KB-⏸️Code splittingTotal Bundle<500KB-⏸️Tree shakingImage Load<3s-⏸️CDN optimizationRuntime PerformanceAPI Response<200ms-⏸️Query optimizationSearch Speed<500ms-⏸️Index tuningRender Time<16ms-⏸️React optimization
Quality Assurance
Test TypeCoverageTargetStatusReportUnit Tests0%>85%⏸️coverage/index.htmlIntegration0%>75%⏸️test-results.jsonE2E Tests0%Critical paths⏸️playwright-reportAccessibility0%WCAG 2.1 AA⏸️a11y-report.jsonPerformance0%All pages⏸️lighthouse-reportSecurity0%OWASP Top 10⏸️security-scan

12. Risk Assessment & Mitigation
Technical Risks
RiskProbabilityImpactMitigation StrategyContingency PlanDependency conflictsMediumHighExact pinning, lockfile managementRollback, version freezeSSR hydration errorsMediumHighProper cache configurationClient-side fallbackDatabase overloadLowCriticalConnection pooling, cachingScale up, read replicasAPI rate limitsMediumMediumRequest throttling, cachingRetry logic, queuingBundle size bloatMediumMediumCode splitting, monitoringLazy loading, CDN
Business Risks
RiskProbabilityImpactMitigation StrategyContingency PlanLaunch delaysMediumHighBuffer time, phased rolloutSoft launch, betaUser adoptionLowHighUser testing, onboardingFeature adjustmentsScalability issuesLowHighLoad testing, architectureEmergency scalingData lossVery LowCriticalBackups, replicationRecovery proceduresSecurity breachLowCriticalSecurity audit, monitoringIncident response
Mitigation Procedures
bash# 1. Rollback procedure
git revert HEAD
git push origin main
vercel rollback

# 2. Database recovery
supabase db reset --db-url $PROD_DB_URL
supabase db push --db-url $PROD_DB_URL

# 3. Emergency scaling
vercel scale --min 3 --max 10

# 4. Feature toggle
curl -X POST $API_URL/features/disable \
  -H "Authorization: Bearer $ADMIN_TOKEN" \
  -d '{"feature": "new-feature"}'

🎯 Final Project Summary
Overall Readiness: 25/100
Critical Path to Production:

Week 0: Environment setup (25% → 40%)
Week 1: Refine dashboard (40% → 55%)
Week 2: Marketing website (55% → 70%)
Week 3: Core features (70% → 85%)
Week 4: Testing & QA (85% → 95%)
Week 5: Production launch (95% → 100%)

Immediate Actions Required:

Fix Node.js and pnpm versions
Install all dependencies with exact versions
Configure Git hooks and CI/CD
Set up Refine with MUI v6
Create Supabase schema with RLS

Success Factors:

✅ Comprehensive planning complete
✅ Technology stack validated
✅ Team resources available
✅ Testing strategy defined
✅ Production checklist ready
