// Simple secure Express server
import express from 'express';
import helmet from 'helmet';
import compression from 'compression';
import cors from 'cors';
import pino from 'pino';
import pinoHttp from 'pino-http';
import { readFileSync } from 'fs';

// Initialize logger
const logger = pino({
  level: process.env.LOG_LEVEL || 'info',
  transport: {
    target: 'pino-pretty',
    options: {
      colorize: true
    }
  }
});

const app = express();
const PORT = process.env.PORT || 3000;

// Security middleware
app.use(helmet());
app.use(compression());
app.use(cors({
  origin: process.env.CORS_ORIGIN || false,
  credentials: true
}));
app.use(pinoHttp({ logger }));

// Parse JSON bodies
app.use(express.json({ limit: '10mb' }));

// Health check endpoint (required for Docker)
app.get('/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  });
});
// Read database URL from secret file if available
let dbUrl = process.env.DATABASE_URL;
if (process.env.DATABASE_URL_FILE) {
  try {
    dbUrl = readFileSync(process.env.DATABASE_URL_FILE, 'utf8').trim();
    logger.info('Database URL loaded from secret file');
  } catch (err) {
    logger.error('Failed to read database URL from file:', err);
  }
}

// Example API endpoint
app.get('/api/v1/status', (req, res) => {
  res.json({
    service: 'EventsOps API',
    version: process.env.VERSION || '1.0.0',
    environment: process.env.NODE_ENV || 'development',
    database: dbUrl ? 'connected' : 'not configured'
  });
});

// Error handling
app.use((err: Error, req: express.Request, res: express.Response, next: express.NextFunction) => {
  logger.error(err);
  res.status(500).json({
    error: 'Internal server error',
    message: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

// Graceful shutdown
const server = app.listen(PORT, () => {
  logger.info(`Server running on port ${PORT}`);
});

process.on('SIGTERM', () => {
  logger.info('SIGTERM received, shutting down gracefully');
  server.close(() => {
    logger.info('Server closed');
    process.exit(0);
  });
});

export default app;