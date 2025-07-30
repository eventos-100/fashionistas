# EventsOS Core Implementation

## 1. Supabase Configuration

### `/src/utils/supabase.ts`
```typescript
import { createClient } from '@supabase/supabase-js';
import type { Database } from '../types/database';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;

export const supabase = createClient<Database>(supabaseUrl, supabaseAnonKey, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
  },
  realtime: {
    params: {
      eventsPerSecond: 10,
    },
  },
});
```

### `/src/providers/dataProvider.ts`
```typescript
import { dataProvider as supabaseDataProvider } from '@refinedev/supabase';
import { supabase } from '../utils/supabase';

export const dataProvider = (() => {
  const baseProvider = supabaseDataProvider(supabase);
  
  return {
    ...baseProvider,
    getList: async (params: any) => {
      // Add organization filter
      const orgId = localStorage.getItem('organization_id');
      if (orgId && params.resource !== 'organizations') {
        params.filters = [
          ...(params.filters || []),
          { field: 'organization_id', operator: 'eq', value: orgId }
        ];
      }
      return baseProvider.getList(params);
    },
  };
})();
```

## 2. Main Application

### `/src/App.tsx`
```typescript
import { Refine } from '@refinedev/core';
import { RefineKbar, RefineKbarProvider } from '@refinedev/kbar';
import { notificationProvider, ThemedLayoutV2, RefineSnackbarProvider } from '@refinedev/mui';
import { CssBaseline, GlobalStyles, ThemeProvider } from '@mui/material';
import routerBindings from '@refinedev/react-router-v6';
import { BrowserRouter, Routes, Route, Outlet } from 'react-router-dom';

import { authProvider } from './providers/authProvider';
import { dataProvider } from './providers/dataProvider';
import { theme } from './theme';

// Pages
import { DashboardPage } from './pages/dashboard';
import { EventList, EventShow, EventCreate, EventEdit } from './pages/events';
import { AnalyticsPage } from './pages/analytics';
import { LoginPage } from './pages/login';

// Resources configuration
const resources = [
  {
    name: 'events',
    list: '/events',
    show: '/events/show/:id',
    create: '/events/create',
    edit: '/events/edit/:id',
    meta: { 
      label: 'Events',
      icon: '🎪',
      canDelete: true 
    },
  },
  {
    name: 'registrations',
    list: '/registrations',
    meta: { 
      label: 'Registrations',
      icon: '📝',
      parent: 'events'
    },
  },
  {
    name: 'sponsors',
    list: '/sponsors',
    create: '/sponsors/create',
    edit: '/sponsors/edit/:id',
    meta: { 
      label: 'Sponsors',
      icon: '💎' 
    },
  },
  {
    name: 'analytics',
    list: '/analytics',
    meta: { 
      label: 'Analytics',
      icon: '📊',
      hide: false 
    },
  },
];

function App() {
  return (
    <BrowserRouter>
      <RefineKbarProvider>
        <ThemeProvider theme={theme}>
          <CssBaseline />
          <GlobalStyles styles={{ body: { backgroundColor: '#fafafa' } }} />
          <RefineSnackbarProvider>
            <Refine
              dataProvider={dataProvider}
              authProvider={authProvider}
              notificationProvider={notificationProvider}
              routerProvider={routerBindings}
              resources={resources}
              options={{
                syncWithLocation: true,
                warnWhenUnsavedChanges: true,
                projectId: 'eventos-dashboard',
              }}
            >
              <Routes>
                <Route path="/login" element={<LoginPage />} />
                <Route element={
                  <ThemedLayoutV2>
                    <Outlet />
                  </ThemedLayoutV2>
                }>
                  <Route index element={<DashboardPage />} />
                  <Route path="/events">
                    <Route index element={<EventList />} />
                    <Route path="show/:id" element={<EventShow />} />
                    <Route path="create" element={<EventCreate />} />
                    <Route path="edit/:id" element={<EventEdit />} />
                  </Route>
                  <Route path="/analytics" element={<AnalyticsPage />} />
                </Route>
              </Routes>
              <RefineKbar />
            </Refine>
          </RefineSnackbarProvider>
        </ThemeProvider>
      </RefineKbarProvider>
    </BrowserRouter>
  );
}

export default App;
```

## 3. Dashboard Implementation

### `/src/pages/dashboard/index.tsx`
```typescript
import React from 'react';
import { useList } from '@refinedev/core';
import { 
  Box, 
  Grid, 
  Card, 
  CardContent, 
  Typography,
  Skeleton,
  Alert
} from '@mui/material';
import { 
  TrendingUp,
  People,
  EventAvailable,
  AttachMoney 
} from '@mui/icons-material';
import { MetricCard } from '../../components/dashboard/MetricCard';
import { EventsChart } from '../../components/dashboard/EventsChart';
import { UpcomingEvents } from '../../components/dashboard/UpcomingEvents';

export const DashboardPage: React.FC = () => {
  const { data: events, isLoading: eventsLoading } = useList({
    resource: 'events',
    pagination: { pageSize: 100 },
  });

  const { data: registrations, isLoading: regLoading } = useList({
    resource: 'registrations',
    pagination: { pageSize: 1000 },
  });

  if (eventsLoading || regLoading) {
    return (
      <Box p={3}>
        <Grid container spacing={3}>
          {[1, 2, 3, 4].map((i) => (
            <Grid item xs={12} sm={6} md={3} key={i}>
              <Skeleton variant="rectangular" height={120} />
            </Grid>
          ))}
        </Grid>
      </Box>
    );
  }

  // Calculate metrics
  const totalRevenue = registrations?.data?.reduce((sum, reg) => 
    sum + (reg.payment_amount || 0), 0
  ) || 0;

  const avgAttendance = events?.data?.length 
    ? Math.round((registrations?.total || 0) / events.data.length)
    : 0;

  return (
    <Box p={3}>
      <Typography variant="h4" gutterBottom fontWeight="bold">
        Fashion Week Dashboard
      </Typography>
      
      <Grid container spacing={3}>
        {/* Metrics Row */}
        <Grid item xs={12} sm={6} md={3}>
          <MetricCard
            title="Total Events"
            value={events?.total || 0}
            icon={<EventAvailable />}
            color="primary"
            trend="+12%"
          />
        </Grid>
        
        <Grid item xs={12} sm={6} md={3}>
          <MetricCard
            title="Total Registrations"
            value={registrations?.total || 0}
            icon={<People />}
            color="secondary"
            trend="+24%"
          />
        </Grid>
        
        <Grid item xs={12} sm={6} md={3}>
          <MetricCard
            title="Revenue"
            value={`$${totalRevenue.toLocaleString()}`}
            icon={<AttachMoney />}
            color="success"
            trend="+18%"
          />
        </Grid>
        
        <Grid item xs={12} sm={6} md={3}>
          <MetricCard
            title="Avg Attendance"
            value={avgAttendance}
            icon={<TrendingUp />}
            color="info"
            trend="+5%"
          />
        </Grid>

        {/* Charts Row */}
        <Grid item xs={12} md={8}>
          <EventsChart events={events?.data || []} />
        </Grid>
        
        <Grid item xs={12} md={4}>
          <UpcomingEvents />
        </Grid>
      </Grid>
    </Box>
  );
};
```

## 4. Events Management

### `/src/pages/events/list.tsx`
```typescript
import React from 'react';
import { 
  List, 
  useDataGrid, 
  EditButton, 
  ShowButton, 
  DeleteButton 
} from '@refinedev/mui';
import { DataGrid, GridColDef } from '@mui/x-data-grid';
import { Box, Chip, Stack } from '@mui/material';
import { format } from 'date-fns';

export const EventList: React.FC = () => {
  const { dataGridProps } = useDataGrid({
    resource: 'events',
    pagination: { pageSize: 25 },
    sorters: { initial: [{ field: 'event_date', order: 'desc' }] },
  });

  const columns: GridColDef[] = [
    { 
      field: 'id', 
      headerName: 'ID', 
      width: 70,
      align: 'center',
    },
    { 
      field: 'title', 
      headerName: 'Event Title', 
      flex: 1,
      minWidth: 200,
    },
    { 
      field: 'event_type',
      headerName: 'Type',
      width: 120,
      renderCell: ({ value }) => (
        <Chip 
          label={value} 
          size="small" 
          color={value === 'runway' ? 'primary' : 'default'}
        />
      ),
    },
    { 
      field: 'event_date',
      headerName: 'Date',
      width: 120,
      valueFormatter: ({ value }) => 
        value ? format(new Date(value), 'MMM dd, yyyy') : '-',
    },
    { 
      field: 'venue',
      headerName: 'Venue',
      width: 180,
    },
    { 
      field: 'capacity',
      headerName: 'Capacity',
      width: 100,
      align: 'center',
    },
    { 
      field: 'status',
      headerName: 'Status',
      width: 100,
      renderCell: ({ value }) => (
        <Chip
          label={value}
          size="small"
          color={
            value === 'active' ? 'success' : 
            value === 'draft' ? 'default' : 
            'error'
          }
        />
      ),
    },
    {
      field: 'actions',
      headerName: 'Actions',
      width: 150,
      sortable: false,
      renderCell: ({ row }) => (
        <Stack direction="row" spacing={1}>
          <ShowButton hideText recordItemId={row.id} />
          <EditButton hideText recordItemId={row.id} />
          <DeleteButton hideText recordItemId={row.id} />
        </Stack>
      ),
    },
  ];

  return (
    <List>
      <DataGrid 
        {...dataGridProps} 
        columns={columns} 
        autoHeight
        density="comfortable"
        sx={{
          '& .MuiDataGrid-cell:hover': {
            cursor: 'pointer',
          },
        }}
      />
    </List>
  );
};
```