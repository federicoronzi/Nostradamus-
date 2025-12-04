# Nostradamus Telegram Bot 🤖

Bot Telegram per interagire con il sistema di previsione Nostradamus attraverso un'interfaccia conversazionale.

## 📋 Descrizione

Il bot Telegram di Nostradamus permette agli utenti di generare predizioni, ottenere informazioni sul sistema e interagire con le funzionalità di analisi predittiva direttamente da Telegram.

## ✨ Funzionalità

- **Comandi interattivi**: Interfaccia conversazionale intuitiva
- **Generazione predizioni**: Crea predizioni personalizzate specificando i periodi
- **Statistiche in tempo reale**: Visualizza media, minimo e massimo dei risultati
- **Informazioni modelli**: Scopri i modelli di previsione disponibili
- **Bottoni inline**: Navigazione facile con pulsanti interattivi
- **Supporto markdown**: Messaggi formattati e leggibili

## 🚀 Prerequisiti

- **Python**: versione 3.8 o superiore
- **pip**: gestore di pacchetti Python
- **Account Telegram**: per creare e utilizzare il bot
- **Token Bot**: ottenuto da [@BotFather](https://t.me/botfather)

## 📦 Installazione

### 1. Clona il Repository

```bash
git clone https://github.com/federicoronzi/Nostradamus-.git
cd Nostradamus-/telegram-bot
```

### 2. Crea un Ambiente Virtuale (Raccomandato)

```bash
python -m venv venv

# Su Linux/Mac:
source venv/bin/activate

# Su Windows:
venv\Scripts\activate
```

### 3. Installa le Dipendenze

```bash
pip install -r requirements.txt
```

## 🔧 Configurazione

### 1. Crea il Bot su Telegram

1. Apri Telegram e cerca [@BotFather](https://t.me/botfather)
2. Invia il comando `/newbot`
3. Segui le istruzioni per scegliere un nome e username
4. Copia il **token** fornito da BotFather

### 2. Configura le Variabili d'Ambiente

Crea un file `.env` nella directory `telegram-bot`:

```bash
cp .env.example .env
```

Modifica il file `.env` e inserisci il tuo token:

```env
TELEGRAM_BOT_TOKEN=123456789:ABCdefGHIjklMNOpqrsTUVwxyz
API_BASE_URL=http://localhost:5000/api
LOG_LEVEL=INFO
```

**IMPORTANTE**: Non committare il file `.env` su Git! È già incluso nel `.gitignore`.

### 3. (Opzionale) Configura il Backend

Se hai un backend Nostradamus in esecuzione, aggiorna l'URL nel file `.env`:

```env
API_BASE_URL=http://your-server:5000/api
```

## 🏃 Esecuzione

### Avvio Semplice

```bash
export TELEGRAM_BOT_TOKEN='your-token-here'
python bot.py
```

### Avvio con File .env

```bash
python bot.py
```

Il bot leggerà automaticamente le configurazioni dal file `.env`.

### Avvio in Background (Linux/Mac)

```bash
nohup python bot.py > bot.log 2>&1 &
```

### Avvio come Servizio Systemd (Linux)

1. Crea il file `/etc/systemd/system/nostradamus-bot.service`:

```ini
[Unit]
Description=Nostradamus Telegram Bot
After=network.target

[Service]
Type=simple
User=your-username
WorkingDirectory=/path/to/Nostradamus-/telegram-bot
Environment="TELEGRAM_BOT_TOKEN=your-token-here"
ExecStart=/path/to/venv/bin/python bot.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

2. Abilita e avvia il servizio:

```bash
sudo systemctl daemon-reload
sudo systemctl enable nostradamus-bot
sudo systemctl start nostradamus-bot
sudo systemctl status nostradamus-bot
```

## 🎮 Utilizzo

### Comandi Disponibili

| Comando | Descrizione |
|---------|-------------|
| `/start` | Avvia il bot e mostra il menu principale |
| `/help` | Mostra l'elenco completo dei comandi |
| `/info` | Informazioni sul progetto Nostradamus |
| `/predict <periodi>` | Genera una predizione per N periodi |
| `/models` | Lista dei modelli di previsione disponibili |
| `/about` | Informazioni sul bot |

### Esempi d'Uso

#### Generare una Predizione

```
/predict 30
```

Questo genererà una predizione per i prossimi 30 periodi.

#### Visualizzare i Modelli

```
/models
```

Mostra tutti i modelli di previsione supportati (ARIMA, Prophet, LSTM, ecc.).

#### Ottenere Aiuto

```
/help
```

Visualizza tutti i comandi disponibili e come usarli.

## 🔌 Integrazione con Backend

Il bot può integrarsi con il backend Nostradamus per generare predizioni reali. Per abilitare l'integrazione:

1. Assicurati che il backend Nostradamus sia in esecuzione
2. Configura `API_BASE_URL` nel file `.env`
3. Modifica la funzione `_generate_mock_prediction()` in `bot.py` per chiamare l'API reale

### Esempio di Integrazione API

```python
import requests

def _generate_prediction(self, periods: int):
    api_url = os.getenv('API_BASE_URL', 'http://localhost:5000/api')
    response = requests.post(
        f'{api_url}/predict',
        json={'periods': periods}
    )
    return response.json()
```

## 📁 Struttura del Progetto

```
telegram-bot/
├── bot.py                 # Script principale del bot
├── requirements.txt       # Dipendenze Python
├── .env.example          # Template configurazione
├── .env                  # Configurazione (non committare!)
├── README.md             # Questo file
└── logs/                 # Directory per i log (creata automaticamente)
```

## 🐛 Troubleshooting

### Bot non si avvia

**Problema**: Errore "TELEGRAM_BOT_TOKEN non trovato"

**Soluzione**: Assicurati di aver configurato correttamente la variabile d'ambiente:
```bash
export TELEGRAM_BOT_TOKEN='your-token-here'
```

### Errori di connessione

**Problema**: Il bot non risponde ai comandi

**Soluzione**: 
- Verifica la connessione internet
- Controlla che il token sia valido
- Verifica i log per errori specifici

### Problemi con l'API

**Problema**: Errori durante la generazione delle predizioni

**Soluzione**:
- Verifica che il backend sia in esecuzione
- Controlla l'URL dell'API in `.env`
- Verifica i log del backend

## 🚀 Deploy su Server

### Deploy su VPS/Server Linux

1. Installa Python e pip:
```bash
sudo apt update
sudo apt install python3 python3-pip python3-venv
```

2. Clona il repository e configura:
```bash
git clone https://github.com/federicoronzi/Nostradamus-.git
cd Nostradamus-/telegram-bot
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

3. Configura e avvia:
```bash
cp .env.example .env
nano .env  # Inserisci il token
python bot.py
```

### Deploy su Heroku

1. Crea un `Procfile`:
```
worker: python telegram-bot/bot.py
```

2. Configura le variabili d'ambiente su Heroku:
```bash
heroku config:set TELEGRAM_BOT_TOKEN='your-token-here'
```

3. Deploy:
```bash
git push heroku main
heroku ps:scale worker=1
```

### Deploy su Docker

1. Crea un `Dockerfile`:
```dockerfile
FROM python:3.11-slim

WORKDIR /app
COPY telegram-bot/requirements.txt .
RUN pip install -r requirements.txt

COPY telegram-bot/ .
COPY src/ ../src/

CMD ["python", "bot.py"]
```

2. Build e run:
```bash
docker build -t nostradamus-bot .
docker run -e TELEGRAM_BOT_TOKEN='your-token' nostradamus-bot
```

## 🔒 Sicurezza

- **Non condividere il token**: Il token del bot è sensibile, non condividerlo
- **File .env**: Mai committare il file `.env` su repository pubblici
- **HTTPS**: Usa HTTPS per le comunicazioni con il backend
- **Rate limiting**: Implementa rate limiting per evitare abusi
- **Validazione input**: Valida sempre gli input degli utenti

## 🧪 Testing

### Test Manuale

1. Avvia il bot
2. Apri Telegram e cerca il tuo bot
3. Testa ogni comando:
   - `/start`
   - `/help`
   - `/predict 30`
   - `/models`
   - `/about`

### Test Automatici

```bash
# Installa pytest
pip install pytest pytest-asyncio

# Esegui i test (quando disponibili)
pytest tests/
```

## 📊 Monitoraggio e Logging

Il bot genera log dettagliati. Per visualizzarli:

```bash
# In tempo reale
tail -f bot.log

# Ultimi 100 righe
tail -n 100 bot.log

# Cerca errori
grep ERROR bot.log
```

### Configurazione Logging Avanzata

Modifica il livello di log in `.env`:

```env
LOG_LEVEL=DEBUG  # Per debug dettagliato
LOG_LEVEL=INFO   # Per informazioni generali (default)
LOG_LEVEL=WARNING # Solo avvisi ed errori
```

## 🤝 Contribuire

Contribuzioni sono benvenute! Per contribuire:

1. Fai fork del progetto
2. Crea un branch per la tua feature (`git checkout -b feature/BotFeature`)
3. Commit le modifiche (`git commit -m 'Add bot feature'`)
4. Push al branch (`git push origin feature/BotFeature`)
5. Apri una Pull Request

## 📚 Risorse Utili

- [python-telegram-bot Documentation](https://docs.python-telegram-bot.org/)
- [Telegram Bot API](https://core.telegram.org/bots/api)
- [BotFather Guide](https://core.telegram.org/bots#botfather)
- [Nostradamus Project](https://github.com/federicoronzi/Nostradamus-)

## 📄 Licenza

Questo progetto è distribuito sotto licenza MIT. Vedi il file LICENSE per maggiori dettagli.

## 👥 Autori

- **Federico Ronzi** - [federicoronzi](https://github.com/federicoronzi)

## 🙏 Ringraziamenti

- Community python-telegram-bot
- Telegram Bot API team
- Contributori del progetto Nostradamus

## 📞 Supporto

Per domande o problemi:
- Apri un issue su [GitHub](https://github.com/federicoronzi/Nostradamus-/issues)
- Contatta gli autori tramite GitHub

---

**Nota**: Questo bot è in sviluppo attivo. Alcune funzionalità potrebbero richiedere il backend Nostradamus completo per funzionare appieno.
