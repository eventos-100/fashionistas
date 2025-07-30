import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import { CopilotKit } from "@copilotkit/react-core";
import "@copilotkit/react-ui/styles.css";
import { validateEnv } from "@/lib/env-validator";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  title: "Incident Report Form - CopilotKit Example",
  description: "AI-powered incident report form with CopilotKit integration",
  robots: {
    index: false,
    follow: false,
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  // Validate environment on server side
  if (typeof window === 'undefined') {
    const envValidation = validateEnv();
    if (!envValidation.success) {
      console.error('Environment validation failed. CopilotKit may not work properly.');
    }
  }

  const apiKey = process.env.NEXT_PUBLIC_COPILOT_PUBLIC_API_KEY;

  return (
    <html lang="en">
      <body className={`${geistSans.variable} ${geistMono.variable} antialiased`}>
        <CopilotKit 
          publicApiKey={apiKey}
          showDevConsole={process.env.NODE_ENV === 'development'}
        >
          {children}
        </CopilotKit>
      </body>
    </html>
  );
}
