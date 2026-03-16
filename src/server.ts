import express from 'express';
import mongoose from 'mongoose';
import cors from 'cors';
import { waitlistRouter } from './routes/waitlist';
import { customersRouter } from './routes/customers';
import { designersRouter } from './routes/designers';
import { statisticsRouter } from './routes/statistics';
import { healthCheckRouter } from './routes/healthCheck';

const app = express();
const PORT = process.env.PORT || 3000;
const DB_URI = process.env.MONGODB_URI || 'your_mongodb_uri_here';

// Middleware setup
app.use(cors()); // Enable CORS
app.use(express.json()); // Parse JSON requests

// Database connection
mongoose.connect(DB_URI, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => console.log('Database connected successfully!'))
  .catch(err => console.error('Database connection error:', err));

// API route handlers
app.use('/api/waitlist', waitlistRouter);
app.use('/api/customers', customersRouter);
app.use('/api/designers', designersRouter);
app.use('/api/statistics', statisticsRouter);
app.use('/api/health', healthCheckRouter);

// Error handling middleware
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Something broke!');
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
