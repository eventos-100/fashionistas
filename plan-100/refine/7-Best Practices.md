# EventsOS Best Practices & Guidelines

## 1. Refine Best Practices

### Resource Configuration
```typescript
// Always define resources with full metadata
const eventResource = {
  name: 'events',
  list: '/events',
  show: '/events/show/:id',
  create: '/events/create',
  edit: '/events/edit/:id',
  meta: {
    label: 'Fashion Events',
    icon: <EventIcon />,
    canDelete: true,
    audit: true, // Enable audit logging
  },
};
```

### Data Hooks Usage
```typescript
// ✅ CORRECT: Use Refine hooks for data operations
const { data, isLoading } = useList({
  resource: 'events',
  filters: [{ field: 'status', operator: 'eq', value: 'active' }],
  pagination: { current: 1, pageSize: 20 },
  sorters: [{ field: 'event_date', order: 'asc' }],
});

// ❌ WRONG: Direct Supabase queries in components
const events = await supabase.from('events').select('*');
```

### Form Management
```typescript
// Use Refine's form hooks with validation
const { formProps, saveButtonProps } = useForm({
  resource: 'events',
  action: 'create',
  redirect: 'show',
  onMutationSuccess: (data) => {
    notification.success('Event created successfully!');
  },
});
```

## 2. Supabase Best Practices

### RLS Policies
```sql
-- Always include organization filtering
CREATE POLICY "events_select_policy" ON events
FOR SELECT USING (
  organization_id = (auth.jwt() ->> 'org_id')::uuid
);

-- Audit trail for changes
CREATE POLICY "events_audit_policy" ON events
FOR ALL USING (
  auth.uid() IS NOT NULL
);
```

### Real-time Subscriptions
```typescript
// Efficient real-time updates
useEffect(() => {
  const channel = supabase
    .channel('events-changes')
    .on('postgres_changes', {
      event: '*',
      schema: 'public',
      table: 'events',
      filter: `organization_id=eq.${orgId}`,
    }, (payload) => {
      queryClient.invalidateQueries(['events']);
    })
    .subscribe();

  return () => {
    supabase.removeChannel(channel);
  };
}, [orgId]);
```

## 3. Material-UI v6 Best Practices

### Theme Customization
```typescript
// Consistent theming for fashion industry
export const fashionTheme = createTheme({
  palette: {
    primary: {
      main: '#000000', // Elegant black
      contrastText: '#FFFFFF',
    },
    secondary: {
      main: '#FFD700', // Gold accents
    },
    background: {
      default: '#FAFAFA',
      paper: '#FFFFFF',
    },
  },
  typography: {
    fontFamily: '"Helvetica Neue", Arial, sans-serif',
    h1: {
      fontSize: '2.5rem',
      fontWeight: 300,
      letterSpacing: '-0.02em',
    },
  },
  shape: {
    borderRadius: 8,
  },
  components: {
    MuiButton: {
      styleOverrides: {
        root: {
          textTransform: 'none',
          fontWeight: 500,
        },
      },
    },
    MuiDataGrid: {
      styleOverrides: {
        root: {
          border: 'none',
          '& .MuiDataGrid-cell:focus': {
            outline: 'none',
          },
        },
      },
    },
  },
});
```

### Component Patterns
```typescript
// Consistent loading states
export const LoadingState = () => (
  <Box display="flex" justifyContent="center" p={4}>
    <CircularProgress />
  </Box>
);

// Consistent empty states
export const EmptyState = ({ message, action }: EmptyStateProps) => (
  <Box textAlign="center" py={8}>
    <Typography variant="h6" color="text.secondary" gutterBottom>
      {message}
    </Typography>
    {action && (
      <Button variant="contained" sx={{ mt: 2 }} onClick={action.onClick}>
        {action.label}
      </Button>
    )}
  </Box>
);
```

## 4. Event Management Best Practices

### Event Lifecycle Management
```typescript
// State machine for event status
enum EventStatus {
  DRAFT = 'draft',
  PUBLISHED = 'published',
  REGISTRATION_OPEN = 'registration_open',
  REGISTRATION_CLOSED = 'registration_closed',
  IN_PROGRESS = 'in_progress',
  COMPLETED = 'completed',
  CANCELLED = 'cancelled',
}

// Transition validation
const canTransitionTo = (current: EventStatus, next: EventStatus): boolean => {
  const transitions = {
    [EventStatus.DRAFT]: [EventStatus.PUBLISHED, EventStatus.CANCELLED],
    [EventStatus.PUBLISHED]: [EventStatus.REGISTRATION_OPEN, EventStatus.CANCELLED],
    [EventStatus.REGISTRATION_OPEN]: [EventStatus.REGISTRATION_CLOSED, EventStatus.CANCELLED],
    // ... etc
  };
  
  return transitions[current]?.includes(next) ?? false;
};
```

### Capacity Management
```typescript
// Real-time capacity tracking
const useEventCapacity = (eventId: string) => {
  const { data: registrations } = useList({
    resource: 'registrations',
    filters: [{ field: 'event_id', operator: 'eq', value: eventId }],
    queryOptions: {
      refetchInterval: 5000, // Poll every 5 seconds during registration
    },
  });

  const { data: event } = useOne({
    resource: 'events',
    id: eventId,
  });

  return {
    current: registrations?.total || 0,
    capacity: event?.data?.capacity || 0,
    available: (event?.data?.capacity || 0) - (registrations?.total || 0),
    percentage: ((registrations?.total || 0) / (event?.data?.capacity || 1)) * 100,
  };
};
```

## 5. Performance Optimization

### Code Splitting
```typescript
// Lazy load heavy components
const AnalyticsDashboard = lazy(() => import('./pages/analytics'));
const EventReports = lazy(() => import('./pages/reports'));

// Route-based splitting
<Route 
  path="/analytics" 
  element={
    <Suspense fallback={<LoadingState />}>
      <AnalyticsDashboard />
    </Suspense>
  } 
/>
```

### Data Optimization
```typescript
// Pagination for large datasets
const ITEMS_PER_PAGE = 25;

// Virtual scrolling for lists
<DataGrid
  {...dataGridProps}
  rowHeight={52}
  pagination
  paginationMode="server"
  rowsPerPageOptions={[25, 50, 100]}
  disableVirtualization={false}
/>
```

## 6. Error Handling

### Global Error Boundary
```typescript
export class ErrorBoundary extends Component<Props, State> {
  state = { hasError: false, error: null };

  static getDerivedStateFromError(error: Error) {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, info: ErrorInfo) {
    // Log to Sentry
    Sentry.captureException(error, { contexts: { react: info } });
  }

  render() {
    if (this.state.hasError) {
      return <ErrorFallback error={this.state.error} />;
    }
    return this.props.children;
  }
}
```

## 7. Accessibility

### WCAG Compliance
```typescript
// Keyboard navigation
<IconButton
  aria-label="Edit event"
  onClick={handleEdit}
  onKeyDown={(e) => {
    if (e.key === 'Enter' || e.key === ' ') {
      handleEdit();
    }
  }}
>
  <EditIcon />
</IconButton>

// Screen reader support
<Typography variant="srOnly">
  {registrations} out of {capacity} seats filled
</Typography>
```