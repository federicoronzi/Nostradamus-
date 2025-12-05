# Guida Completa: App Mobile e Bot Telegram

Questa guida fornisce una panoramica completa dei nuovi componenti aggiunti al progetto Nostradamus.

## 📱 App Mobile React Native

### Panoramica
L'app mobile Nostradamus è un'applicazione cross-platform sviluppata con React Native che porta le funzionalità di previsione su dispositivi iOS e Android.

### Posizione
```
Nostradamus-/mobile-app/
```

### File Principali
- `src/App.tsx` - Componente principale con navigazione
- `src/screens/HomeScreen.js` - Schermata principale
- `src/screens/PredictionScreen.js` - Schermata predizioni
- `src/services/NostradamusService.js` - Servizio API
- `src/constants.js` - Costanti e messaggi
- `package.json` - Dipendenze npm

### Avvio Rapido
```bash
cd mobile-app
npm install
npm run android  # o npm run ios
```

### Configurazione API
L'URL dell'API può essere configurato tramite variabile d'ambiente:
```javascript
// .env o processo di build
API_BASE_URL=http://your-api-url/api
```

### Caratteristiche Principali
- ✅ Interfaccia nativa per iOS/Android
- ✅ Supporto tema chiaro/scuro
- ✅ Generazione predizioni
- ✅ Visualizzazione statistiche
- ✅ Navigazione con React Navigation

### Documentazione Completa
Vedi [mobile-app/README.md](../mobile-app/README.md)

---

## 🤖 Bot Telegram Python

### Panoramica
Il bot Telegram permette agli utenti di interagire con Nostradamus attraverso un'interfaccia conversazionale su Telegram.

### Posizione
```
Nostradamus-/telegram-bot/
```

### File Principali
- `bot.py` - Script principale del bot
- `config.py` - Gestione configurazione
- `requirements.txt` - Dipendenze Python
- `test_bot.py` - Test suite
- `.env.example` - Template configurazione

### Avvio Rapido
```bash
cd telegram-bot
pip install -r requirements.txt
export TELEGRAM_BOT_TOKEN='your-token'
python bot.py
```

### Configurazione
1. Ottieni un token da [@BotFather](https://t.me/botfather)
2. Crea file `.env`:
```env
TELEGRAM_BOT_TOKEN=your-token-here
API_BASE_URL=http://localhost:5000/api
```

### Comandi Disponibili
- `/start` - Avvia il bot
- `/help` - Mostra aiuto
- `/predict <N>` - Genera predizione per N periodi
- `/models` - Lista modelli disponibili
- `/info` - Info sul progetto
- `/about` - Info sul bot

### Caratteristiche Principali
- ✅ Comandi interattivi
- ✅ Bottoni inline
- ✅ Gestione predizioni
- ✅ Statistiche in tempo reale
- ✅ Configurazione via variabili d'ambiente

### Documentazione Completa
Vedi [telegram-bot/README.md](../telegram-bot/README.md)

---

## 🔧 Integrazione con Backend

Entrambi i componenti sono progettati per integrarsi con un backend Nostradamus. Attualmente usano dati mock per dimostrazione.

### Per Abilitare l'Integrazione Reale

#### Mobile App
Modifica `src/services/NostradamusService.js`:
```javascript
// Rimuovi i mock e usa chiamate API reali
const response = await apiClient.post('/predict', { periods });
return response.data;
```

#### Telegram Bot
Modifica `bot.py`:
```python
# Sostituisci _generate_mock_prediction con chiamate API
import requests
response = requests.post(f'{api_url}/predict', json={'periods': periods})
return response.json()
```

---

## 🚀 Deployment

### App Mobile

#### iOS
1. Apri progetto in Xcode
2. Configura signing & capabilities
3. Archive e distribuzione via App Store Connect

#### Android
1. Genera chiave di firma
2. Configura gradle.properties
3. Build APK/AAB
4. Distribuzione via Google Play Console

### Bot Telegram

#### Server Linux
```bash
# Come servizio systemd
sudo systemctl enable nostradamus-bot
sudo systemctl start nostradamus-bot
```

#### Docker
```bash
docker build -t nostradamus-bot .
docker run -e TELEGRAM_BOT_TOKEN='token' nostradamus-bot
```

#### Heroku
```bash
heroku create nostradamus-bot
heroku config:set TELEGRAM_BOT_TOKEN='token'
git push heroku main
```

---

## 🧪 Testing

### Mobile App
```bash
cd mobile-app
npm test
npm run lint
```

### Telegram Bot
```bash
cd telegram-bot
pytest test_bot.py -v
```

---

## 📊 Struttura Progetto Completa

```
Nostradamus-/
├── src/                      # Core Python package
├── tests/                    # Test Python core
├── mobile-app/              # ← App mobile React Native
│   ├── src/
│   │   ├── screens/        # Schermate
│   │   ├── services/       # Servizi API
│   │   └── constants.js    # Costanti
│   ├── package.json
│   └── README.md
├── telegram-bot/            # ← Bot Telegram Python
│   ├── bot.py             # Bot principale
│   ├── config.py          # Configurazione
│   ├── test_bot.py        # Test
│   ├── requirements.txt   # Dipendenze
│   └── README.md
├── docs/                    # Documentazione
├── examples/                # Esempi
├── data/                    # Dati
└── README.md               # Documentazione principale
```

---

## 🔒 Sicurezza

### Token e Credenziali
- ❌ Mai committare token o API keys
- ✅ Usa file `.env` (incluso in `.gitignore`)
- ✅ Usa variabili d'ambiente in produzione
- ✅ Ruota i token periodicamente

### Mobile App
- API URL configurabile
- Timeout delle richieste
- Validazione input utente

### Telegram Bot
- Validazione parametri
- Rate limiting (configurabile)
- Logging di sicurezza

---

## 🐛 Troubleshooting Comune

### Mobile App

**Problema**: Metro non si avvia
```bash
npx react-native start --reset-cache
```

**Problema**: Errore connessione API
- Android emulator: usa `10.0.2.2` invece di `localhost`
- iOS simulator: può usare `localhost`

### Telegram Bot

**Problema**: Token non trovato
```bash
export TELEGRAM_BOT_TOKEN='your-token'
# o crea file .env
```

**Problema**: Bot non risponde
- Verifica connessione internet
- Controlla validità token
- Vedi log per errori

---

## 📚 Risorse Aggiuntive

### Mobile App
- [React Native Docs](https://reactnative.dev/)
- [React Navigation](https://reactnavigation.org/)
- [Axios](https://axios-http.com/)

### Telegram Bot
- [python-telegram-bot](https://docs.python-telegram-bot.org/)
- [Telegram Bot API](https://core.telegram.org/bots/api)
- [BotFather](https://t.me/botfather)

### Nostradamus
- [Repository GitHub](https://github.com/federicoronzi/Nostradamus-)
- [README Principale](../README.md)

---

## 🤝 Contribuire

Entrambi i componenti sono parte del progetto Nostradamus e accettano contribuzioni:

1. Fork del repository
2. Crea branch feature
3. Commit modifiche
4. Push al branch
5. Apri Pull Request

---

## 📞 Supporto

Per problemi o domande:
- Apri un [issue su GitHub](https://github.com/federicoronzi/Nostradamus-/issues)
- Consulta la documentazione specifica di ogni componente
- Contatta gli autori

---

**Ultima modifica**: Dicembre 2024  
**Versione**: 0.1.0  
**Autore**: Federico Ronzi
