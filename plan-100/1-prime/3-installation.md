Installation
To use Refine with Material UI, you need to install the following package @refinedev/mui along with the Material UI packages:

npm install @refinedev/mui @mui/material @mui/lab @mui/x-data-grid @emotion/react @emotion/styled
⚡ Try Refine
Start a new project with Refine in seconds using the following command:

npm create refine-app@latest my-refine-app

Installation & Usage
npm install @refinedev/supabase
import { dataProvider, liveProvider, createClient } from "@refinedev/supabase";

const supabaseClient = createClient("SUPABASE_URL", "SUPABASE_KEY");

const App = () => {
  return (
    <Refine
      dataProvider={dataProvider(supabaseClient)}
      liveProvider={liveProvider(supabaseClient)}
      /* ... */
    >
      {/* ... */}
    </Refine>
  );
};

https://www.npmjs.com/package/@refinedev/core

npm create refine-app@latest my-refine-app
```
npm install @refinedev/cli
```
## Quick Start

[](https://www.npmjs.com/package/@refinedev/core#quick-start)

Here's Refine in action, the below code is an example of a simple CRUD application using Refine + React Router + Material UI:

```tsx
import React from "react";
import { Refine, useMany } from "@refinedev/core";
import { ThemedLayoutV2 } from "@refinedev/mui";
import dataProvider from "@refinedev/simple-rest";
import routerProvider from "@refinedev/react-router";
import { BrowserRouter, Outlet, Route, Routes } from "react-router";

import CssBaseline from "@mui/material/CssBaseline";

export default function App() {
  return (
    <BrowserRouter>
      <CssBaseline />
      <Refine
        dataProvider={dataProvider("https://api.fake-rest.refine.dev")}
        routerProvider={routerProvider}
        resources={[
          {
            name: "products",
            list: "/products",
          },
        ]}
      >
        <Routes>
          <Route
            element={
              <ThemedLayoutV2>
                <Outlet />
              </ThemedLayoutV2>
            }
          >
            <Route path="/products">
              <Route index element={<ProductList />} />
            </Route>
          </Route>
        </Routes>
      </Refine>
    </BrowserRouter>
  );
}

// src/pages/products/list.tsx

import { List, useDataGrid, DateField } from "@refinedev/mui";
import { DataGrid, GridColDef } from "@mui/x-data-grid";

export const ProductList = () => {
  const { dataGridProps } = useDataGrid();

  const { data: categories, isLoading } = useMany({
    resource: "categories",
    ids:
      dataGridProps?.rows?.map((item) => item?.category?.id).filter(Boolean) ??
      [],
    queryOptions: {
      enabled: !!dataGridProps?.rows,
    },
  });

  const columns = React.useMemo<GridColDef[]>(
    () => [
      { field: "id", headerName: "ID", type: "number" },
      { field: "name", flex: 1, headerName: "Name" },
      {
        field: "category",
        flex: 1,
        headerName: "Category",
        display: "flex",
        renderCell: ({ value }) =>
          isLoading
            ? "Loading..."
            : categories?.data?.find((item) => item.id === value?.id)?.title,
      },
      {
        field: "createdAt",
        flex: 1,
        headerName: "Created at",
        display: "flex",
        renderCell: ({ value }) => <DateField value={value} />,
      },
    ],
    [categories?.data, isLoading],
  );

  return (
    <List>
      <DataGrid {...dataGridProps} columns={columns} />
    </List>
  );
};






```https://www.npmjs.com/package/@refinedev/cli

npm install @refinedev/cli

https://www.npmjs.com/package/@refinedev/react-hook-form

Installation & Usage
npm install @refinedev/react-hook-form react-hook-form
import { useForm } from "@refinedev/react-hook-form";

const EditPost = () => {
  const { register, handleSubmit, formState, refineCore } = useForm({
    refineCoreProps: {
      resource: "posts",
      id: "1",
    },
  });

  return; /* ... */
};






https://www.npmjs.com/package/@refinedev/nextjs-router
npm i @refinedev/nextjs-router





