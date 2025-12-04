/**
 * Nostradamus Service
 * Service for communicating with the Nostradamus backend API
 */

import axios from 'axios';

// Configure the base URL for your Nostradamus API
// In production, this should be set via environment variables
const API_BASE_URL = 'http://localhost:5000/api';

// Create axios instance with default config
const apiClient = axios.create({
  baseURL: API_BASE_URL,
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
});

class NostradamusService {
  /**
   * Get application information
   * @returns {Promise<Object>} App info including version, author, license
   */
  static async getAppInfo() {
    try {
      // Mock response for demonstration
      // In production, this would call the actual API
      // const response = await apiClient.get('/info');
      // return response.data;
      
      return {
        version: '0.1.0',
        author: 'Federico Ronzi',
        license: 'MIT',
        status: 'active',
      };
    } catch (error) {
      console.error('Error fetching app info:', error);
      throw error;
    }
  }

  /**
   * Generate a prediction
   * @param {number} periods - Number of periods to predict
   * @returns {Promise<Object>} Prediction results
   */
  static async generatePrediction(periods = 30) {
    try {
      // Mock response for demonstration
      // In production, this would call the actual API
      // const response = await apiClient.post('/predict', { periods });
      // return response.data;

      // Simulate API delay
      await new Promise(resolve => setTimeout(resolve, 1500));

      // Generate mock prediction data
      const predictions = Array.from({ length: periods }, (_, i) => {
        const base = 100;
        const trend = i * 0.5;
        const noise = (Math.random() - 0.5) * 10;
        return base + trend + noise;
      });

      const mean = predictions.reduce((a, b) => a + b, 0) / predictions.length;
      const min = Math.min(...predictions);
      const max = Math.max(...predictions);

      return {
        model: 'auto',
        periods,
        predictions,
        statistics: {
          mean,
          min,
          max,
        },
        timestamp: new Date().toISOString(),
        status: 'success',
      };
    } catch (error) {
      console.error('Error generating prediction:', error);
      throw error;
    }
  }

  /**
   * Get historical data
   * @param {string} datasetId - Dataset identifier
   * @returns {Promise<Object>} Historical data
   */
  static async getHistoricalData(datasetId) {
    try {
      // const response = await apiClient.get(`/data/${datasetId}`);
      // return response.data;
      
      return {
        datasetId,
        records: [],
        timestamp: new Date().toISOString(),
      };
    } catch (error) {
      console.error('Error fetching historical data:', error);
      throw error;
    }
  }

  /**
   * Get available models
   * @returns {Promise<Array>} List of available prediction models
   */
  static async getAvailableModels() {
    try {
      // const response = await apiClient.get('/models');
      // return response.data;
      
      return [
        { id: 'auto', name: 'Auto', description: 'Automatic model selection' },
        { id: 'arima', name: 'ARIMA', description: 'AutoRegressive Integrated Moving Average' },
        { id: 'prophet', name: 'Prophet', description: 'Facebook Prophet' },
        { id: 'lstm', name: 'LSTM', description: 'Long Short-Term Memory' },
      ];
    } catch (error) {
      console.error('Error fetching models:', error);
      throw error;
    }
  }
}

export default NostradamusService;
