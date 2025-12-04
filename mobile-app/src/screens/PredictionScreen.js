/**
 * Prediction Screen
 * Screen for generating and displaying predictions
 */

import React, { useState } from 'react';
import {
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  ActivityIndicator,
  useColorScheme,
  ScrollView,
  TextInput,
  Alert,
} from 'react-native';
import NostradamusService from '../services/NostradamusService';
import { ALERTS, PLACEHOLDERS, BUTTONS } from '../constants';

const PredictionScreen = ({ navigation }) => {
  const isDarkMode = useColorScheme() === 'dark';
  const [loading, setLoading] = useState(false);
  const [periods, setPeriods] = useState('30');
  const [prediction, setPrediction] = useState(null);
  const [error, setError] = useState(null);

  const styles = createStyles(isDarkMode);

  const handleGeneratePrediction = async () => {
    const periodsNum = parseInt(periods, 10);
    
    if (isNaN(periodsNum) || periodsNum <= 0) {
      Alert.alert(ALERTS.ERROR_TITLE, ALERTS.INVALID_PERIODS);
      return;
    }

    setLoading(true);
    setError(null);
    setPrediction(null);

    try {
      const result = await NostradamusService.generatePrediction(periodsNum);
      setPrediction(result);
    } catch (err) {
      setError('Errore nella generazione della predizione');
      Alert.alert(ALERTS.ERROR_TITLE, ALERTS.PREDICTION_ERROR);
      console.error('Error generating prediction:', err);
    } finally {
      setLoading(false);
    }
  };

  return (
    <ScrollView style={styles.container}>
      <View style={styles.content}>
        {/* Input Section */}
        <View style={styles.card}>
          <Text style={styles.cardTitle}>Parametri Predizione</Text>
          
          <Text style={styles.label}>Numero di periodi:</Text>
          <TextInput
            style={styles.input}
            value={periods}
            onChangeText={setPeriods}
            keyboardType="numeric"
            placeholder={PLACEHOLDERS.ENTER_PERIODS}
            placeholderTextColor={isDarkMode ? '#666' : '#999'}
          />

          <TouchableOpacity
            style={[styles.button, loading && styles.buttonDisabled]}
            onPress={handleGeneratePrediction}
            disabled={loading}
            activeOpacity={0.7}>
            {loading ? (
              <ActivityIndicator color="#fff" />
            ) : (
              <Text style={styles.buttonText}>{BUTTONS.GENERATE_PREDICTION}</Text>
            )}
          </TouchableOpacity>
        </View>

        {/* Results Section */}
        {prediction && (
          <View style={styles.card}>
            <Text style={styles.cardTitle}>Risultati</Text>
            
            <View style={styles.resultRow}>
              <Text style={styles.resultLabel}>Modello:</Text>
              <Text style={styles.resultValue}>{prediction.model}</Text>
            </View>

            <View style={styles.resultRow}>
              <Text style={styles.resultLabel}>Periodi:</Text>
              <Text style={styles.resultValue}>{prediction.periods}</Text>
            </View>

            <View style={styles.resultRow}>
              <Text style={styles.resultLabel}>Timestamp:</Text>
              <Text style={styles.resultValue}>{prediction.timestamp}</Text>
            </View>

            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Valori Predetti:</Text>
              <ScrollView horizontal style={styles.valuesContainer}>
                {prediction.predictions.map((value, index) => (
                  <View key={index} style={styles.valueCard}>
                    <Text style={styles.valueIndex}>T+{index + 1}</Text>
                    <Text style={styles.valueNumber}>
                      {value.toFixed(2)}
                    </Text>
                  </View>
                ))}
              </ScrollView>
            </View>

            <View style={styles.section}>
              <Text style={styles.sectionTitle}>Statistiche:</Text>
              <View style={styles.statsContainer}>
                <View style={styles.statItem}>
                  <Text style={styles.statLabel}>Media</Text>
                  <Text style={styles.statValue}>
                    {prediction.statistics.mean.toFixed(2)}
                  </Text>
                </View>
                <View style={styles.statItem}>
                  <Text style={styles.statLabel}>Min</Text>
                  <Text style={styles.statValue}>
                    {prediction.statistics.min.toFixed(2)}
                  </Text>
                </View>
                <View style={styles.statItem}>
                  <Text style={styles.statLabel}>Max</Text>
                  <Text style={styles.statValue}>
                    {prediction.statistics.max.toFixed(2)}
                  </Text>
                </View>
              </View>
            </View>
          </View>
        )}

        {error && (
          <View style={[styles.card, styles.errorCard]}>
            <Text style={styles.errorText}>{error}</Text>
          </View>
        )}

        {!prediction && !loading && !error && (
          <View style={styles.card}>
            <Text style={styles.infoText}>
              Inserisci i parametri e premi "Genera Predizione" per iniziare
            </Text>
          </View>
        )}
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
    label: {
      fontSize: 16,
      color: isDarkMode ? '#ccc' : '#666',
      marginBottom: 8,
      fontWeight: '500',
    },
    input: {
      backgroundColor: isDarkMode ? '#1a1a1a' : '#f5f5f5',
      borderRadius: 8,
      padding: 12,
      fontSize: 16,
      color: isDarkMode ? '#fff' : '#333',
      borderWidth: 1,
      borderColor: isDarkMode ? '#444' : '#ddd',
      marginBottom: 20,
    },
    button: {
      backgroundColor: '#4a90e2',
      borderRadius: 8,
      padding: 15,
      alignItems: 'center',
    },
    buttonDisabled: {
      backgroundColor: '#7fb3e8',
    },
    buttonText: {
      color: '#fff',
      fontSize: 16,
      fontWeight: 'bold',
    },
    resultRow: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      marginBottom: 12,
      paddingBottom: 12,
      borderBottomWidth: 1,
      borderBottomColor: isDarkMode ? '#444' : '#eee',
    },
    resultLabel: {
      fontSize: 16,
      color: isDarkMode ? '#aaa' : '#666',
      fontWeight: '500',
    },
    resultValue: {
      fontSize: 16,
      color: isDarkMode ? '#fff' : '#333',
      fontWeight: '600',
    },
    section: {
      marginTop: 20,
    },
    sectionTitle: {
      fontSize: 18,
      fontWeight: 'bold',
      color: isDarkMode ? '#fff' : '#333',
      marginBottom: 12,
    },
    valuesContainer: {
      flexDirection: 'row',
    },
    valueCard: {
      backgroundColor: isDarkMode ? '#1a1a1a' : '#f9f9f9',
      borderRadius: 8,
      padding: 12,
      marginRight: 10,
      minWidth: 80,
      alignItems: 'center',
      borderWidth: 1,
      borderColor: isDarkMode ? '#444' : '#e0e0e0',
    },
    valueIndex: {
      fontSize: 12,
      color: isDarkMode ? '#888' : '#999',
      marginBottom: 4,
    },
    valueNumber: {
      fontSize: 18,
      fontWeight: 'bold',
      color: isDarkMode ? '#4a90e2' : '#2c5aa0',
    },
    statsContainer: {
      flexDirection: 'row',
      justifyContent: 'space-around',
    },
    statItem: {
      alignItems: 'center',
      padding: 12,
      backgroundColor: isDarkMode ? '#1a1a1a' : '#f9f9f9',
      borderRadius: 8,
      minWidth: 90,
    },
    statLabel: {
      fontSize: 14,
      color: isDarkMode ? '#888' : '#999',
      marginBottom: 6,
    },
    statValue: {
      fontSize: 20,
      fontWeight: 'bold',
      color: isDarkMode ? '#4a90e2' : '#2c5aa0',
    },
    errorCard: {
      backgroundColor: isDarkMode ? '#3d1f1f' : '#ffe5e5',
      borderColor: '#e74c3c',
      borderWidth: 1,
    },
    errorText: {
      fontSize: 16,
      color: '#e74c3c',
      textAlign: 'center',
    },
    infoText: {
      fontSize: 16,
      color: isDarkMode ? '#ccc' : '#666',
      textAlign: 'center',
      lineHeight: 24,
    },
  });

export default PredictionScreen;
