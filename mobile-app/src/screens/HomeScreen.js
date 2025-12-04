/**
 * Home Screen
 * Main screen showing app information and navigation options
 */

import React, { useState, useEffect } from 'react';
import {
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  ActivityIndicator,
  useColorScheme,
  ScrollView,
} from 'react-native';
import NostradamusService from '../services/NostradamusService';

const HomeScreen = ({ navigation }) => {
  const isDarkMode = useColorScheme() === 'dark';
  const [loading, setLoading] = useState(false);
  const [appInfo, setAppInfo] = useState(null);
  const [error, setError] = useState(null);

  const styles = createStyles(isDarkMode);

  useEffect(() => {
    loadAppInfo();
  }, []);

  const loadAppInfo = async () => {
    setLoading(true);
    setError(null);
    try {
      const info = await NostradamusService.getAppInfo();
      setAppInfo(info);
    } catch (err) {
      setError('Errore nel caricamento delle informazioni');
      console.error('Error loading app info:', err);
    } finally {
      setLoading(false);
    }
  };

  const handlePredictionPress = () => {
    navigation.navigate('Prediction');
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.content}>
        {/* Header */}
        <View style={styles.header}>
          <Text style={styles.title}>🔮 Nostradamus</Text>
          <Text style={styles.subtitle}>
            Sistema di Previsione e Analisi Predittiva
          </Text>
        </View>

        {/* App Info Card */}
        <View style={styles.card}>
          <Text style={styles.cardTitle}>Informazioni App</Text>
          {loading ? (
            <ActivityIndicator size="large" color="#4a90e2" />
          ) : error ? (
            <Text style={styles.errorText}>{error}</Text>
          ) : appInfo ? (
            <View>
              <Text style={styles.infoText}>Versione: {appInfo.version}</Text>
              <Text style={styles.infoText}>Autore: {appInfo.author}</Text>
              <Text style={styles.infoText}>Licenza: {appInfo.license}</Text>
            </View>
          ) : (
            <Text style={styles.infoText}>Caricamento...</Text>
          )}
        </View>

        {/* Features Card */}
        <View style={styles.card}>
          <Text style={styles.cardTitle}>Funzionalità</Text>
          <View style={styles.featuresList}>
            <Text style={styles.featureItem}>
              ✓ Previsioni su serie temporali
            </Text>
            <Text style={styles.featureItem}>
              ✓ Analisi dati in tempo reale
            </Text>
            <Text style={styles.featureItem}>
              ✓ Algoritmi di machine learning
            </Text>
            <Text style={styles.featureItem}>
              ✓ Visualizzazione risultati
            </Text>
          </View>
        </View>

        {/* Action Button */}
        <TouchableOpacity
          style={styles.button}
          onPress={handlePredictionPress}
          activeOpacity={0.7}>
          <Text style={styles.buttonText}>Genera Predizione</Text>
        </TouchableOpacity>

        {/* Footer */}
        <View style={styles.footer}>
          <Text style={styles.footerText}>
            Nostradamus Mobile App v0.1.0
          </Text>
          <Text style={styles.footerText}>
            © 2024 Federico Ronzi
          </Text>
        </View>
      </View>
    </ScrollView>
  );
};

const createStyles = (isDarkMode) =>
  StyleSheet.create({
    container: {
      flex: 1,
      backgroundColor: isDarkMode ? '#1a1a1a' : '#f5f5f5',
    },
    content: {
      padding: 20,
    },
    header: {
      alignItems: 'center',
      marginVertical: 30,
    },
    title: {
      fontSize: 36,
      fontWeight: 'bold',
      color: isDarkMode ? '#fff' : '#333',
      marginBottom: 10,
    },
    subtitle: {
      fontSize: 16,
      color: isDarkMode ? '#ccc' : '#666',
      textAlign: 'center',
    },
    card: {
      backgroundColor: isDarkMode ? '#2c2c2c' : '#fff',
      borderRadius: 12,
      padding: 20,
      marginBottom: 20,
      shadowColor: '#000',
      shadowOffset: { width: 0, height: 2 },
      shadowOpacity: 0.1,
      shadowRadius: 4,
      elevation: 3,
    },
    cardTitle: {
      fontSize: 20,
      fontWeight: 'bold',
      color: isDarkMode ? '#fff' : '#333',
      marginBottom: 15,
    },
    infoText: {
      fontSize: 16,
      color: isDarkMode ? '#ccc' : '#666',
      marginBottom: 8,
    },
    errorText: {
      fontSize: 16,
      color: '#e74c3c',
      textAlign: 'center',
    },
    featuresList: {
      marginTop: 5,
    },
    featureItem: {
      fontSize: 16,
      color: isDarkMode ? '#ccc' : '#666',
      marginBottom: 10,
      lineHeight: 24,
    },
    button: {
      backgroundColor: '#4a90e2',
      borderRadius: 12,
      padding: 18,
      alignItems: 'center',
      marginVertical: 20,
      shadowColor: '#4a90e2',
      shadowOffset: { width: 0, height: 4 },
      shadowOpacity: 0.3,
      shadowRadius: 8,
      elevation: 5,
    },
    buttonText: {
      color: '#fff',
      fontSize: 18,
      fontWeight: 'bold',
    },
    footer: {
      alignItems: 'center',
      marginTop: 30,
      marginBottom: 20,
    },
    footerText: {
      fontSize: 12,
      color: isDarkMode ? '#888' : '#999',
      marginTop: 5,
    },
  });

export default HomeScreen;
