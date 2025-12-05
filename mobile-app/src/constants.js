/**
 * Constants and messages for the Nostradamus Mobile App
 * Centralizes all user-facing text for easier maintenance and i18n
 */

// Alert Messages
export const ALERTS = {
  ERROR_TITLE: 'Errore',
  INVALID_PERIODS: 'Inserisci un numero valido di periodi',
  PREDICTION_ERROR: 'Si è verificato un errore durante la generazione della predizione',
};

// Screen Titles
export const TITLES = {
  APP_NAME: 'Nostradamus',
  HOME: 'Nostradamus',
  PREDICTIONS: 'Predizioni',
};

// Labels and Text
export const LABELS = {
  VERSION: 'Versione',
  AUTHOR: 'Autore',
  LICENSE: 'Licenza',
  MODEL: 'Modello',
  PERIODS: 'Periodi',
  TIMESTAMP: 'Timestamp',
  MEAN: 'Media',
  MIN: 'Minimo',
  MAX: 'Massimo',
};

// Button Text
export const BUTTONS = {
  GENERATE_PREDICTION: 'Genera Predizione',
};

// Placeholder Text
export const PLACEHOLDERS = {
  ENTER_PERIODS: 'Inserisci numero di periodi',
};

// Info Messages
export const MESSAGES = {
  LOADING: 'Caricamento...',
  LOADING_ERROR: 'Errore nel caricamento delle informazioni',
  SUBTITLE: 'Sistema di Previsione e Analisi Predittiva',
  FOOTER_VERSION: 'Nostradamus Mobile App v0.1.0',
  FOOTER_COPYRIGHT: '© 2024 Federico Ronzi',
  NO_PREDICTION: 'Inserisci i parametri e premi "Genera Predizione" per iniziare',
};

// Features List
export const FEATURES = [
  'Previsioni su serie temporali',
  'Analisi dati in tempo reale',
  'Algoritmi di machine learning',
  'Visualizzazione risultati',
];

// Section Titles
export const SECTIONS = {
  APP_INFO: 'Informazioni App',
  FEATURES: 'Funzionalità',
  PARAMETERS: 'Parametri Predizione',
  RESULTS: 'Risultati',
  STATISTICS: 'Statistiche',
  PREDICTED_VALUES: 'Valori Predetti',
  FIRST_VALUES: 'Primi',
  LAST_VALUES: 'Ultimi',
};

// API Configuration
export const API = {
  DEFAULT_TIMEOUT: 10000,
  DEFAULT_PERIODS: 30,
  MAX_PERIODS: 365,
};

export default {
  ALERTS,
  TITLES,
  LABELS,
  BUTTONS,
  PLACEHOLDERS,
  MESSAGES,
  FEATURES,
  SECTIONS,
  API,
};
