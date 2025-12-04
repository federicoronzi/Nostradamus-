# Nostradamus Mobile App 📱

App mobile cross-platform per il progetto Nostradamus, sviluppata con React Native.

## 📋 Descrizione

L'app mobile Nostradamus porta le funzionalità di previsione e analisi predittiva direttamente sul tuo dispositivo mobile. Supporta sia iOS che Android e offre un'interfaccia intuitiva per interagire con il backend di Nostradamus.

## ✨ Funzionalità

- **Interfaccia utente moderna**: Design pulito e responsive con supporto per modalità chiara/scura
- **Generazione predizioni**: Crea predizioni personalizzate specificando il numero di periodi
- **Visualizzazione risultati**: Mostra i risultati con statistiche e grafici
- **Integrazione API**: Comunicazione con il backend Nostradamus tramite API REST
- **Cross-platform**: Funziona su iOS e Android da un'unica codebase

## 🚀 Prerequisiti

Prima di iniziare, assicurati di avere installato:

### Requisiti Generali
- **Node.js**: versione 16 o superiore
- **npm** o **yarn**: gestore di pacchetti
- **Git**: per clonare il repository

### Per iOS
- **macOS**: richiesto per lo sviluppo iOS
- **Xcode**: versione 14 o superiore
- **CocoaPods**: `sudo gem install cocoapods`
- **iOS Simulator**: installato con Xcode

### Per Android
- **Android Studio**: versione 2022.1 o superiore
- **Android SDK**: API level 33 o superiore
- **JDK**: Java Development Kit 11 o superiore
- **Android Emulator**: configurato tramite Android Studio

## 📦 Installazione

### 1. Clona il Repository

```bash
git clone https://github.com/federicoronzi/Nostradamus-.git
cd Nostradamus-/mobile-app
```

### 2. Installa le Dipendenze

```bash
npm install
```

o con yarn:

```bash
yarn install
```

### 3. Installazione Specifica per iOS

```bash
cd ios
pod install
cd ..
```

## 🔧 Configurazione

### Configurazione API

Modifica il file `src/services/NostradamusService.js` per configurare l'URL del tuo backend:

```javascript
const API_BASE_URL = 'http://your-backend-url/api';
```

### Variabili d'Ambiente

Crea un file `.env` nella directory principale:

```env
API_BASE_URL=http://localhost:5000/api
API_TIMEOUT=10000
```

## 🏃 Esecuzione

### Avviare Metro Bundler

Prima di eseguire l'app, avvia Metro (il bundler JavaScript):

```bash
npm start
```

o

```bash
yarn start
```

### Eseguire su iOS

In un nuovo terminale:

```bash
npm run ios
```

o per un dispositivo specifico:

```bash
npm run ios -- --simulator="iPhone 14 Pro"
```

### Eseguire su Android

In un nuovo terminale:

```bash
npm run android
```

Assicurati di avere un emulatore Android in esecuzione o un dispositivo collegato con USB debugging abilitato.

## 🔨 Build per Produzione

### Build iOS

1. Apri il progetto in Xcode:
```bash
open ios/NostradamusMobile.xcworkspace
```

2. Seleziona il tuo dispositivo/simulator target
3. Configura il team di sviluppo nelle impostazioni di signing
4. Clicca su Product > Archive
5. Segui il processo di distribuzione di Xcode

### Build Android

1. Genera la chiave di firma (solo la prima volta):
```bash
keytool -genkeypair -v -storetype PKCS12 -keystore my-release-key.keystore -alias my-key-alias -keyalg RSA -keysize 2048 -validity 10000
```

2. Configura il signing nel file `android/gradle.properties`:
```properties
MYAPP_RELEASE_STORE_FILE=my-release-key.keystore
MYAPP_RELEASE_KEY_ALIAS=my-key-alias
MYAPP_RELEASE_STORE_PASSWORD=*****
MYAPP_RELEASE_KEY_PASSWORD=*****
```

3. Build dell'APK:
```bash
cd android
./gradlew assembleRelease
```

L'APK sarà disponibile in: `android/app/build/outputs/apk/release/app-release.apk`

4. Build dell'AAB (per Google Play):
```bash
cd android
./gradlew bundleRelease
```

## 🧪 Testing

### Test Unitari

```bash
npm test
```

### Test con Coverage

```bash
npm test -- --coverage
```

### Linting

```bash
npm run lint
```

## 📁 Struttura del Progetto

```
mobile-app/
├── android/                # Progetto Android nativo
├── ios/                    # Progetto iOS nativo
├── src/                    # Codice sorgente
│   ├── App.tsx            # Componente principale
│   ├── screens/           # Schermate dell'app
│   │   ├── HomeScreen.js
│   │   └── PredictionScreen.js
│   ├── services/          # Servizi API
│   │   └── NostradamusService.js
│   └── components/        # Componenti riutilizzabili
├── index.js               # Entry point
├── app.json               # Configurazione app
├── package.json           # Dipendenze npm
├── babel.config.js        # Configurazione Babel
├── metro.config.js        # Configurazione Metro
└── README.md             # Questo file
```

## 🔌 Integrazione API

L'app comunica con il backend Nostradamus attraverso il servizio `NostradamusService`. Le principali funzioni disponibili sono:

- `getAppInfo()`: Ottiene informazioni sull'applicazione
- `generatePrediction(periods)`: Genera una predizione per N periodi
- `getHistoricalData(datasetId)`: Recupera dati storici
- `getAvailableModels()`: Lista dei modelli disponibili

### Esempio di Utilizzo

```javascript
import NostradamusService from './src/services/NostradamusService';

// Genera una predizione per 30 periodi
const prediction = await NostradamusService.generatePrediction(30);
console.log(prediction);
```

## 🎨 Personalizzazione

### Cambio Icona e Splash Screen

1. Sostituisci i file in `android/app/src/main/res/` per Android
2. Sostituisci i file in `ios/NostradamusMobile/Images.xcassets/` per iOS

### Tema e Stili

Gli stili sono definiti in ogni componente usando `StyleSheet.create()`. L'app supporta automaticamente il tema chiaro/scuro in base alle impostazioni del dispositivo.

## 🐛 Troubleshooting

### Errore Metro Bundler

Se Metro non si avvia correttamente:
```bash
npx react-native start --reset-cache
```

### Errore Build Android

Pulisci la build:
```bash
cd android
./gradlew clean
cd ..
```

### Errore Build iOS

Pulisci la build e reinstalla i pods:
```bash
cd ios
pod deintegrate
pod install
cd ..
```

### Problemi di Rete

Se l'app non riesce a connettersi al backend:
- Verifica che l'URL dell'API sia corretto
- Su Android emulator, usa `10.0.2.2` invece di `localhost`
- Su iOS simulator, puoi usare `localhost`
- Assicurati che il backend sia in esecuzione

## 📚 Risorse Utili

- [React Native Documentation](https://reactnative.dev/)
- [React Navigation](https://reactnavigation.org/)
- [Axios Documentation](https://axios-http.com/)
- [Android Developer Guide](https://developer.android.com/)
- [iOS Developer Guide](https://developer.apple.com/)

## 🤝 Contribuire

Contribuzioni sono benvenute! Per contribuire:

1. Fai fork del progetto
2. Crea un branch per la tua feature (`git checkout -b feature/AmazingFeature`)
3. Commit le modifiche (`git commit -m 'Add some AmazingFeature'`)
4. Push al branch (`git push origin feature/AmazingFeature`)
5. Apri una Pull Request

## 📄 Licenza

Questo progetto è distribuito sotto licenza MIT. Vedi il file LICENSE per maggiori dettagli.

## 👥 Autori

- **Federico Ronzi** - [federicoronzi](https://github.com/federicoronzi)

## 🙏 Ringraziamenti

- React Native community
- Facebook per React Native
- Contributori del progetto Nostradamus

## 📞 Supporto

Per domande o problemi:
- Apri un issue su [GitHub](https://github.com/federicoronzi/Nostradamus-/issues)
- Contatta gli autori tramite GitHub

---

**Nota**: Questo è un progetto in sviluppo attivo. Alcune funzionalità potrebbero richiedere configurazioni aggiuntive.
