'use client';

import { useEffect } from 'react';
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { AlertCircle } from "lucide-react";

export default function Error({
  error,
  reset,
}: {
  error: Error & { digest?: string };
  reset: () => void;
}) {
  useEffect(() => {
    // Log the error to an error reporting service
    console.error('Application error:', error);
  }, [error]);

  return (
    <div className="flex min-h-screen items-center justify-center p-4">
      <Card className="w-full max-w-md">
        <CardHeader>
          <div className="flex items-center gap-2">
            <AlertCircle className="h-5 w-5 text-red-600" />
            <CardTitle className="text-red-600">Something went wrong!</CardTitle>
          </div>
          <CardDescription>
            An unexpected error occurred while processing your request.
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="rounded-md bg-gray-50 p-3">
            <p className="text-sm text-gray-600">
              {error.message || 'An unknown error occurred'}
            </p>
            {error.digest && (
              <p className="mt-1 text-xs text-gray-500">
                Error ID: {error.digest}
              </p>
            )}
          </div>
          <Button 
            onClick={reset}
            className="w-full"
            variant="default"
          >
            Try again
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}