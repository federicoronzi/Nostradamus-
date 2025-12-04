# Nostradamus

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Python](https://img.shields.io/badge/python-3.8%2B-blue.svg)

## 📖 Descrizione del Progetto

Nostradamus è un progetto di previsione e analisi predittiva che utilizza tecniche avanzate di machine learning e data science per generare predizioni accurate basate su dati storici. Il nome si ispira al famoso astrologo e veggente Nostradamus, simboleggiando la capacità del sistema di "predire" tendenze future.

## 🎯 Obiettivi Principali

- **Previsioni Accurate**: Implementare modelli di machine learning per previsioni su serie temporali
- **Analisi dei Dati**: Fornire strumenti per l'analisi esplorativa dei dati
- **Scalabilità**: Architettura modulare e scalabile per gestire dataset di diverse dimensioni
- **Facilità d'Uso**: API intuitiva e documentazione completa per utenti di tutti i livelli
- **Visualizzazione**: Dashboard interattive per visualizzare predizioni e metriche

## ✨ Caratteristiche

- Supporto per diversi algoritmi di previsione (ARIMA, Prophet, LSTM, ecc.)
- Preprocessing automatico dei dati
- Valutazione delle performance con metriche standard
- Export dei risultati in vari formati
- Integrazione con pipeline di data science esistenti

## 🚀 Installazione

### Prerequisiti

- Python 3.8 o superiore
- pip (gestore pacchetti Python)
- virtualenv (consigliato)

### Installazione Base

1. Clona il repository:
```bash
git clone https://github.com/federicoronzi/Nostradamus-.git
cd Nostradamus-
```

2. Crea un ambiente virtuale (consigliato):
```bash
python -m venv venv
source venv/bin/activate  # Su Windows: venv\Scripts\activate
```

3. Installa le dipendenze:
```bash
pip install -r requirements.txt
```

## 📦 Dipendenze Richieste

Le principali dipendenze del progetto includono:

- **numpy**: Calcolo numerico e manipolazione array
- **pandas**: Analisi e manipolazione dati
- **scikit-learn**: Algoritmi di machine learning
- **matplotlib**: Visualizzazione dati
- **seaborn**: Visualizzazione statistica avanzata
- **jupyter**: Ambiente notebook per analisi interattive

Tutte le dipendenze sono specificate nel file `requirements.txt`.

## 💻 Utilizzo

### Esempio Base

```python
from nostradamus import Predictor
from nostradamus.data import load_sample_data

# Carica i dati di esempio
data = load_sample_data()

# Crea un predittore
predictor = Predictor(model='auto')

# Addestra il modello
predictor.fit(data)

# Genera previsioni
predictions = predictor.predict(periods=30)

# Visualizza i risultati
predictor.plot_predictions()
```

### Esempi Avanzati

Per esempi più dettagliati, consulta la cartella `examples/` o i notebook Jupyter in `notebooks/`.

### App Mobile

Nostradamus include un'app mobile multipiattaforma sviluppata con React Native. Per maggiori informazioni:

```bash
cd mobile-app
# Vedi mobile-app/README.md per istruzioni complete
```

Caratteristiche principali:
- Interfaccia nativa per iOS e Android
- Generazione predizioni in tempo reale
- Visualizzazione statistiche e grafici
- Supporto tema chiaro/scuro

Consulta [mobile-app/README.md](mobile-app/README.md) per istruzioni dettagliate di installazione e utilizzo.

### Bot Telegram

Interagisci con Nostradamus direttamente da Telegram! Il bot offre:

```bash
cd telegram-bot
# Vedi telegram-bot/README.md per istruzioni complete
```

Funzionalità:
- Comandi interattivi (`/predict`, `/info`, `/models`)
- Generazione predizioni via chat
- Interfaccia conversazionale intuitiva
- Deploy semplice su server o cloud

Consulta [telegram-bot/README.md](telegram-bot/README.md) per configurazione e deploy.

## 📁 Struttura del Progetto

```
Nostradamus-/
├── src/                    # Codice sorgente principale
│   └── nostradamus/        # Package principale
├── tests/                  # Test unitari e di integrazione
├── docs/                   # Documentazione
├── examples/               # Esempi di utilizzo
├── notebooks/              # Jupyter notebooks
├── data/                   # Dati di esempio
├── mobile-app/             # App mobile React Native
├── telegram-bot/           # Bot Telegram
├── requirements.txt        # Dipendenze Python
├── setup.py                # Script di installazione
├── LICENSE                 # Licenza del progetto
└── README.md              # Questo file
```

## 🧪 Test

Per eseguire i test:

```bash
pytest tests/
```

Per il test coverage:

```bash
pytest --cov=nostradamus tests/
```

## 📚 Documentazione

La documentazione completa è disponibile nella cartella `docs/`. Per generare la documentazione HTML:

```bash
cd docs/
make html
```

## 🤝 Contribuire

Contribuzioni sono benvenute! Per favore:

1. Fai fork del repository
2. Crea un branch per la tua feature (`git checkout -b feature/AmazingFeature`)
3. Commit delle modifiche (`git commit -m 'Add some AmazingFeature'`)
4. Push al branch (`git push origin feature/AmazingFeature`)
5. Apri una Pull Request

## 📄 Licenza

Questo progetto è distribuito sotto licenza MIT. Vedi il file `LICENSE` per maggiori dettagli.

## 👥 Autori

- **Federico Ronzi** - [federicoronzi](https://github.com/federicoronzi)

## 🙏 Ringraziamenti

- Community open source per gli strumenti e le librerie utilizzate
- Contributori che aiutano a migliorare il progetto

## 📞 Contatti

Per domande o supporto, apri un issue su GitHub o contatta gli autori.

---

**Nota**: Questo progetto è in fase di sviluppo attivo. Alcune funzionalità potrebbero non essere ancora complete.