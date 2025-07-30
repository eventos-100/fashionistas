Introduction
Refine provides an integration package for Material UI framework. This package provides a set of ready to use components and hooks that connects Refine with Material UI components. While Refine's integration offers a set of components and hooks, it is not a replacement for the Material UI packages, you will be able to use all the features of Material UI in the same way you would use it in a regular React application. Refine's integration only provides components and hooks for an easier usage of Material UI components in combination with Refine's features and functionalities.

Installation
Installing the package is as simple as just by running the following command without any additional configuration:

pnpm add @refinedev/mui @refinedev/react-hook-form @emotion/react @emotion/styled @mui/lab @mui/material @mui/x-data-grid react-hook-form

Usage
We'll wrap our app with the <ThemeProvider /> to make sure we have the theme available for our app, then we'll use the layout components to wrap them around our routes. Check out the examples below to see how to use Refine's Material UI integration.

import React from "react";

import { Refine } from "@refinedev/core";
import routerProvider from "@refinedev/nextjs-router/pages";
import dataProvider from "@refinedev/simple-rest";
import type { AppProps } from "next/app";

import { RefineThemes, ThemedLayoutV2, notificationProvider, RefineSnackbarProvider } from "@refinedev/mui";
import CssBaseline from "@mui/material/CssBaseline";
import GlobalStyles from "@mui/material/GlobalStyles";
import { ThemeProvider } from "@mui/material/styles";

import authProvider from "../src/auth-provider";

export type ExtendedNextPage = NextPage & {
  noLayout?: boolean;
};

type ExtendedAppProps = AppProps & {
  Component: ExtendedNextPage;
};

function App({ Component, pageProps }: ExtendedAppProps) {
  const renderComponent = () => {
      if (Component.noLayout) {
          return <Component {...pageProps} />;
      }

      return (
          <ThemedLayoutV2>
              <Component {...pageProps} />
          </ThemedLayoutV2>
      );
  }

  return (
    <ThemeProvider theme={RefineThemes.Blue}>
      <CssBaseline />
      <GlobalStyles
          styles={{ html: { WebkitFontSmoothing: "auto" } }}
      />
      <RefineSnackbarProvider>
        <Refine
          routerProvider={routerProvider}
          dataProvider={dataProvider("https://api.fake-rest.refine.dev")}
          notificationProvider={notificationProvider}
          authProvider={authProvider}
          resources={[
            {
              name: "products",
              list: "/products",
              show: "/products/:id",
              edit: "/products/:id/edit",
              create: "/products/create"
            },
          ]}
          options={{ syncWithLocation: true }}
        >
          {renderComponent()}
        </Refine>
      </RefineSnackbarProvider>
    </ThemeProvider>
  );
}

export default App;



import React from "react";
import { EditButton, List, ShowButton, useDataGrid } from "@refinedev/mui";
import { DataGrid, GridColDef } from "@mui/x-data-grid";

import authProvider from "../../src/auth-provider";

export default function ProductList() {
  const { dataGridProps } = useDataGrid();

  const columns = React.useMemo<GridColDef<IProduct>[]>(
    () => [
        {
            field: "id",
            headerName: "ID",
            type: "number",
            width: 50,
        },
        { field: "name", headerName: "Name", minWidth: 300, flex: 1 },
        { field: "price", headerName: "Price", minWidth: 100, flex: 1 },
        {
          field: "actions",
          headerName: "Actions",
          display: "flex",
          renderCell: function render({ row }) {
              return (
                  <div>
                      <EditButton hideText recordItemId={row.id} />
                      <ShowButton hideText recordItemId={row.id} />
                  </div>
              );
          },
          align: "center",
          headerAlign: "center",
          minWidth: 80,
        },
      ],
    []
  );

  return (
    <List>
        <DataGrid {...dataGridProps} columns={columns}  />
    </List>
  );
};

/**
 * Same check can also be done via `<Authenticated />` component.
 * But we're using a server-side check for a better UX.
 */
export const getServerSideProps = async () => {
  const { authenticated } = await authProvider.check();

  if (!authenticated) {
    return {
      redirect: {
        destination: "/login",
        permanent: false,
      },
    };
  }

  return {
    props: {},
  };
}

interface IProduct {
  id: string;
  name: string;
  price: number;
  description: string;
}


import {
  Show,
  NumberField,
  TextFieldComponent as TextField,
  MarkdownField,
  DateField,
} from "@refinedev/mui";
import { useShow } from "@refinedev/core";
import Typography from "@mui/material/Typography";
import Stack from "@mui/material/Stack";

import authProvider from "../../src/auth-provider";

export default function ProductShow() {
  const { queryResult } = useShow();
  const { data, isLoading } = queryResult;

  const record = data?.data;

  return (
    <Show isLoading={isLoading}>
      <Stack gap={1}>
        <Typography variant="body1" fontWeight="bold">
            Id
        </Typography>
        <NumberField value={record?.id ?? ""} />
        <Typography variant="body1" fontWeight="bold">
            Name
        </Typography>
        <TextField value={record?.name} />
        <Typography variant="body1" fontWeight="bold">
            Material
        </Typography>
        <TextField value={record?.material} />
        <Typography variant="body1" fontWeight="bold">
            Description
        </Typography>
        <MarkdownField value={record?.description} />
        <Typography variant="body1" fontWeight="bold">
            Price
        </Typography>
        <TextField value={record?.price} />
      </Stack>
    </Show>
  );
};

/**
 * Same check can also be done via `<Authenticated />` component.
 * But we're using a server-side check for a better UX.
 */
export const getServerSideProps = async () => {
  const { authenticated } = await authProvider.check();

  if (!authenticated) {
    return {
      redirect: {
        destination: "/login",
        permanent: false,
      },
    };
  }

  return {
    props: {},
  };
}


import { HttpError } from "@refinedev/core";
import { Edit, useAutocomplete } from "@refinedev/mui";
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import Autocomplete from "@mui/material/Autocomplete";
import { useForm } from "@refinedev/react-hook-form";

import { Controller } from "react-hook-form";

import authProvider from "../../../src/auth-provider";

export default function ProductEdit() {
  const {
    saveButtonProps,
    refineCore: { queryResult, autoSaveProps },
    register,
    control,
    formState: { errors },
  } = useForm();

  return (
    <Edit saveButtonProps={saveButtonProps}>
      <Box
      component="form"
      sx={{ display: "flex", flexDirection: "column" }}
      autoComplete="off"
      >
        <TextField
            id="name"
            {...register("name", {
                required: "This field is required",
            })}
            error={!!errors.name}
            helperText={errors.name?.message}
            margin="normal"
            fullWidth
            label="Name"
            name="name"
            autoFocus
        />
        <TextField
            id="material"
            {...register("material", {
                required: "This field is required",
            })}
            error={!!errors.material}
            helperText={errors.material?.message}
            margin="normal"
            fullWidth
            label="Material"
            name="material"
            autoFocus
        />
        <TextField
          id="description"
          {...register("description", {
              required: "This field is required",
          })}
          error={!!errors.description}
          helperText={errors.description?.message}
          margin="normal"
          label="Description"
          multiline
          rows={4}
        />
        <TextField
            id="price"
            {...register("price", {
                required: "This field is required",
            })}
            error={!!errors.price}
            helperText={errors.price?.message}
            margin="normal"
            fullWidth
            label="Price"
            name="price"
            autoFocus
        />
      </Box>
  </Edit>
  );
};

/**
 * Same check can also be done via `<Authenticated />` component.
 * But we're using a server-side check for a better UX.
 */
export const getServerSideProps = async () => {
  const { authenticated } = await authProvider.check();

  if (!authenticated) {
    return {
      redirect: {
        destination: "/login",
        permanent: false,
      },
    };
  }

  return {
    props: {},
  };
}


import { HttpError } from "@refinedev/core";
import { Create, useAutocomplete } from "@refinedev/mui";
import Box from "@mui/material/Box";
import TextField from "@mui/material/TextField";
import Autocomplete from "@mui/material/Autocomplete";
import { useForm } from "@refinedev/react-hook-form";

import { Controller } from "react-hook-form";

import authProvider from "../../src/auth-provider";

export default function ProductCreate() {
  const {
    saveButtonProps,
    refineCore: { queryResult, autoSaveProps },
    register,
    control,
    formState: { errors },
  } = useForm();

  return (
    <Create saveButtonProps={saveButtonProps}>
      <Box
      component="form"
      sx={{ display: "flex", flexDirection: "column" }}
      autoComplete="off"
      >
        <TextField
            id="name"
            {...register("name", {
                required: "This field is required",
            })}
            error={!!errors.name}
            helperText={errors.name?.message}
            margin="normal"
            fullWidth
            label="Name"
            name="name"
            autoFocus
        />
        <TextField
            id="material"
            {...register("material", {
                required: "This field is required",
            })}
            error={!!errors.material}
            helperText={errors.material?.message}
            margin="normal"
            fullWidth
            label="Material"
            name="material"
            autoFocus
        />
        <TextField
          id="description"
          {...register("description", {
              required: "This field is required",
          })}
          error={!!errors.description}
          helperText={errors.description?.message}
          margin="normal"
          label="Description"
          multiline
          rows={4}
        />
        <TextField
            id="price"
            {...register("price", {
                required: "This field is required",
            })}
            error={!!errors.price}
            helperText={errors.price?.message}
            margin="normal"
            fullWidth
            label="Price"
            name="price"
            autoFocus
        />
      </Box>
  </Create>
  );
};

/**
 * Same check can also be done via `<Authenticated />` component.
 * But we're using a server-side check for a better UX.
 */
export const getServerSideProps = async () => {
  const { authenticated } = await authProvider.check();

  if (!authenticated) {
    return {
      redirect: {
        destination: "/login",
        permanent: false,
      },
    };
  }

  return {
    props: {},
  };
}import React from "react";
import { AuthPage } from "@refinedev/mui";
import authProvider from "../src/auth-provider";

import type { ExtendedNextPage } from "./_app";

const Login: ExtendedNextPage = () => {
  return <AuthPage type="login" />;
};

Login.noLayout = true;

export default Login;

/**
 * Same check can also be done via `<Authenticated />` component.
 * But we're using a server-side check for a better UX.
 */
export const getServerSideProps = async () => {
  const { authenticated } = await authProvider.check();

  if (authenticated) {
    return {
      redirect: {
        destination: "/products",
        permanent: false,
      },
    };
  }

  return {
    props: {},
  };
  
  Tables
Refine provides a seamless integration with the <DataGrid /> component of Material UI from pagination to sorting and filtering via the useDataGrid hook exported from the @refinedev/mui package. This useDataGrid hook extends the useTable hook of @refinedev/core package and provides a set of additional features and transformations to make it work with Material UI's <DataGrid /> component without any additional configuration.

pages/products/list.tsx
import { useDataGrid } from "@refinedev/mui";
import { DataGrid, GridColDef } from "@mui/x-data-grid";

const columns: GridColDef<IProduct>[] = [
  { field: "id", headerName: "ID", type: "number", width: 50 },
  { field: "name", headerName: "Name", minWidth: 200, flex: 1 },
  { field: "price", headerName: "Price", minWidth: 300, flex: 1 },
];

export const ProductList: FC = () => {
  const { dataGridProps } = useDataGrid<IProduct>();

  return (
    <List>
      <DataGrid {...dataGridProps} columns={columns} />
    </List>
  );
};

interface IProduct {
  id: string;
  name: string;
  price: number;
  description: string;
}

Was this helpful?


Forms
Material UI offers form elements yet it does not provide a form management solution. To have a complete solution, Refine recommends using @refinedev/react-hook-form package which is built on top of Refine's useForm hook and React Hook Form's useForm hook.

Refine's documentations and examples of Material UI uses @refinedev/react-hook-form package for form management but you have the option to use any form management solution you want.

pages/products/create.tsx
import { useForm } from "@refinedev/react-hook-form";
import { Create } from "@refinedev/mui";
import TextField from "@mui/material/TextField";
import Box from "@mui/material/Box";

export const ProductCreate: FC = () => {
  const {
    saveButtonProps,
    refineCore: { queryResult, autoSaveProps },
    register,
    control,
    formState: { errors },
  } = useForm<IProduct>();

  return (
    <Create saveButtonProps={saveButtonProps}>
      <Box
        component="form"
        sx={{ display: "flex", flexDirection: "column" }}
        autoComplete="off"
      >
        <TextField
          id="name"
          {...register("name", {
            required: "This field is required",
          })}
          error={!!errors.name}
          helperText={errors.name?.message}
          label="Name"
          name="name"
        />
        <TextField
          id="price"
          {...register("price", {
            required: "This field is required",
          })}
          error={!!errors.price}
          helperText={errors.price?.message}
          label="Price"
          name="price"
        />
        <TextField
          id="description"
          {...register("description", {
            required: "This field is required",
          })}
          error={!!errors.description}
          helperText={errors.description?.message}
          label="Description"
          name="description"
        />
      </Box>
    </Create>
  );
};

interface IProduct {
  id: string;
  name: string;
  price: number;
  description: string;
}

@refinedev/mui also provides useAutocomplete hook which can be used to implement autocomplete fields with relational data. This hook leverages the useSelect hook from the @refinedev/core package.

Additional hooks of @refinedev/react-hook-form such as useStepsForm and useModalForm can also be used together with Refine's Material UI integration with ease.

Was this helpful?


Notifications
Material UI has its own notification elements but lacks the notification management solution. As recommended by the Material UI's documentation; Refine's integration provides a notification provider which uses notistack package under the hood. This integration is provided by the notificationProvider exported from the @refinedev/mui package which can be directly used in the notificationProvider prop of the <Refine /> component.

app.tsx
import { Refine } from "@refinedev/core";
import { useNotificationProvider } from "@refinedev/mui";

const App = () => {
  return (
    <Refine notificationProvider={useNotificationProvider}>{/* ... */}</Refine>
  );
};

TIP
Usage of <RefineSnackbarProvider /> is required to manage notifications through notistack. The component itself is a wrapper of the SnackbarProvider component of notistack package.

Was this helpful?


Predefined Components and Views
Layouts, Menus and Breadcrumbs
Refine provides Layout components that can be used to implement a layout for the application. These components are crafted using Material UI's components and includes Refine's features and functionalities such as navigation menus, headers, authentication, authorization and more.


import React from "react";

import { Refine } from "@refinedev/core";
import routerProvider from "@refinedev/nextjs-router/pages";
import dataProvider from "@refinedev/simple-rest";
import type { AppProps } from "next/app";

import { RefineThemes, ThemedLayoutV2, notificationProvider, RefineSnackbarProvider } from "@refinedev/mui";
import CssBaseline from "@mui/material/CssBaseline";
import GlobalStyles from "@mui/material/GlobalStyles";
import { ThemeProvider } from "@mui/material/styles";

function App({ Component, pageProps }: AppProps) {
    return (
        <ThemeProvider theme={RefineThemes.Blue}>
            <CssBaseline />
            <GlobalStyles
                styles={{ html: { WebkitFontSmoothing: "auto" } }}
            />
            <RefineSnackbarProvider>
                <Refine
                    routerProvider={routerProvider}
                    dataProvider={dataProvider("https://api.fake-rest.refine.dev")}
                    notificationProvider={notificationProvider}
                    resources={[
                        {
                        name: "products",
                        list: "/products",
                        },
                    ]}
                >
                  <ThemedLayoutV2>
                    <Component {...pageProps} />
                  </ThemedLayoutV2>
                </Refine>
            </RefineSnackbarProvider>
        </ThemeProvider>
    );
}

export default App;


<ThemedLayoutV2 /> component consists of a header, sider and a content area. The sider have a navigation menu items for the defined resources of Refine, if an authentication provider is present, it will also have a functional logout button. The header contains the app logo and name and also information about the current user if an authentication provider is present.

Additionally, Refine also provides a <Breadcrumb /> component that uses the Material UI's component as a base and provide appropriate breadcrumbs for the current route. This component is used in the basic views provided by Refine's Material UI package automatically.

Was this helpful?


Buttons
Refine's Material UI integration offers variety of buttons that are built above the <Button /> component of Material UI and includes many logical functionalities such as;

Authorization checks
Confirmation dialogs
Loading states
Invalidation
Navigation
Form actions
Import/Export and more.
You can use buttons such as <EditButton /> or <ListButton /> etc. in your views to provide navigation for the related routes or <DeleteButton /> and <SaveButton /> etc. to perform related actions without having to worry about the authorization checks and other logical functionalities.

An example usage of the <EditButton /> component is as follows:

pages/products/list.tsx
import { useDataGrid, EditButton } from "@refinedev/mui";
import { DataGrid, GridColDef } from "@mui/x-data-grid";

const columns: GridColDef[] = [
  { field: "id", headerName: "ID", type: "number", width: 50 },
  { field: "name", headerName: "Name", minWidth: 200, flex: 1 },
  { field: "price", headerName: "Price", minWidth: 300, flex: 1 },
  {
    field: "actions",
    headerName: "Actions",
    display: "flex",
    renderCell: function render({ row }) {
        return (
          <EditButton hideText recordItemId={row.id} />
        );
    },
  }
]

export const ProductList: FC = () => {
  const { dataGridProps } = useDataGrid();

  return (
    <List>
      <DataGrid {...dataGridProps} columns={columns}  />
    </List>
  );
};

The list of provided buttons are:

<CreateButton />
<EditButton />
<ListButton />
<ShowButton />
<CloneButton />
<DeleteButton />
<SaveButton />
<RefreshButton />
<ImportButton />
<ExportButton />
Many of these buttons are already used in the views provided by Refine's Material UI integration. If you're using the basic view elements provided by Refine, you will have the appropriate buttons placed in your application out of the box.

Was this helpful?


Views
Views are designed as wrappers around the content of the pages in the application. They are designed to be used within the layouts and provide basic functionalities such as titles based on the resource, breadcrumbs, related actions and authorization checks. Refine's Material UI integration uses components such as <Card /> and <Box /> to provide these views and provides customization options by passing related props to these components.

The list of provided views are:

<List />
<Show />
<Edit />
<Create />
list.tsx
show.tsx
edit.tsx
create.tsx
import React from "react";
import { EditButton, List, ShowButton, useDataGrid } from "@refinedev/mui";
import { DataGrid, GridColDef } from "@mui/x-data-grid";

export const ProductList = () => {
  const { dataGridProps } = useDataGrid();

  const columns = React.useMemo<GridColDef<IProduct>[]>(
    () => [
        {
            field: "id",
            headerName: "ID",
            type: "number",
            width: 50,
        },
        { field: "name", headerName: "Name", minWidth: 300, flex: 1 },
        { field: "price", headerName: "Price", minWidth: 100, flex: 1 },
        {
          field: "actions",
          headerName: "Actions",
          display: "flex",
          renderCell: function render({ row }) {
              return (
                  <div>
                      <EditButton hideText recordItemId={row.id} />
                      <ShowButton hideText recordItemId={row.id} />
                  </div>
              );
          },
          align: "center",
          headerAlign: "center",
          minWidth: 80,
        },
      ],
    []
  );



/products

Something went wrong

Cannot find module '@mui/utils/7.2.0' from '/node_modules/@mui/x-data-grid/components/columnHeaders/GridColumnGroupHeader.js'

Was this helpful?


Fields
Refine's Material UI also provides field components to render values with appropriate design and format of Material UI. These components are built on top of respective Material UI components and also provide logic for formatting of the values. While these components might not always be suitable for your use case, they can be combined or extended to provide the desired functionality.

The list of provided field components are:

<BooleanField />
<DateField />
<EmailField />
<FileField />
<MarkdownField />
<NumberField />
<TagField />
<TextField />
<UrlField />
pages/products/show.tsx
import { useShow } from "@refinedev/core";
import { Show, TextField, NumberField } from "@refinedev/mui";
import Typography from "@mui/material/Typography";

export const ProductShow = () => {
  const { queryResult } = useShow<IProduct>();
  const { data, isLoading } = queryResult;
  const record = data?.data;

  return (
    <Show isLoading={isLoading}>
      <Typography variant="body1" fontWeight="bold">
        Id
      </Typography>
      <TextField value={record?.id} />

      <Typography variant="body1" fontWeight="bold">
        Title
      </Typography>
      <TextField value={record?.title} />

      <Typography variant="body1" fontWeight="bold">
        Title
      </Typography>
      <NumberField
        value={record?.price}
        options={{ style: "currency", currency: "USD" }}
      />
    </Show>
  );
};

interface IProduct {
  id: string;
  name: string;
  price: number;
  description: string;
}

Was this helpful?


Auth Pages
Auth pages are designed to be used as the pages of the authentication flow of the application. They offer an out of the box solution for the login, register, forgot password and reset password pages by leveraging the authentication hooks of Refine. Auth page components are built on top of basic Material UI components such as <TextField /> and <Card /> etc.

The list of types of auth pages that are available in the UI integrations are:

<AuthPage type="login" />
<AuthPage type="register" />
<AuthPage type="forgot-password" />
<AuthPage type="reset-password" />
An example usage of the <AuthPage /> component is as follows:

login.tsx
register.tsx
forgot-password.tsx
reset-password.tsx
import { AuthPage } from "@refinedev/mui";

export const LoginPage = () => {
    return (
        <AuthPage
            type="login"
            formProps={{
                defaultValues: {
                  email: "demo@refine.dev",
                  password: "demodemo",
                },
            }}
        />
    );
};



/login


Was this helpful?


Error Components
Refine's Material UI integration also provides an <ErrorComponent /> component that you can use to render a 404 page in your app. While these components does not offer much functionality, they are provided as an easy way to render an error page with a consistent design language.

An example usage of the <ErrorComponent /> component is as follows:

pages/404.tsx
import { ErrorComponent } from "@refinedev/mui";

const NotFoundPage = () => {
  return <ErrorComponent />;
};

Was this helpful?


Theming
Since Refine offers application level components such as layout, sidebar and header and page level components for each action, it is important to have it working with the styling of Material UI. All components and providers exported from the @refinedev/mui package will use the current theme of Material UI without any additional configuration.

Additionally, Refine also provides a set of carefully crafted themes for Material UI which outputs a nice UI with Refine's components with light and dark theme support. These themes are exported as RefineThemes object from the @refinedev/mui package and can be used in <ThemeProvider /> component of Material UI.

theme-provider.tsx
export const ThemeProvider = ({ children }) => (
    // Available themes: Blue, Purple, Magenta, Red, Orange, Yellow, Green
    // Change the line below to change the theme
    <MuiThemeProvider theme={RefineThemes.Magenta}>
        <CssBaseline />
        <GlobalStyles
            styles={{ html: { WebkitFontSmoothing: "auto" } }}
        />
        <RefineSnackbarProvider>
            {children}
        </RefineSnackbarProvider>
        
            </MuiThemeProvider>
            
            
            Inferencer
You can automatically generate views for your resources using @refinedev/inferencer. Inferencer exports the MuiListInferencer, MuiShowInferencer, MuiEditInferencer, MuiCreateInferencer components and finally the MuiInferencer component, which combines all in one place.
  
  
