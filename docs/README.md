# Documentazione Nostradamus

Benvenuto nella documentazione di Nostradamus!

## Indice

1. [Introduzione](#introduzione)
2. [Installazione](#installazione)
3. [Guida Rapida](#guida-rapida)
4. [API Reference](#api-reference)
5. [Esempi](#esempi)
6. [FAQ](#faq)

## Introduzione

Nostradamus è un framework Python per la previsione e l'analisi predittiva. Fornisce strumenti per:

- Previsioni su serie temporali
- Analisi esplorativa dei dati
- Valutazione dei modelli
- Visualizzazione dei risultati

## Installazione

Vedi le istruzioni nel [README.md](../README.md).

## Guida Rapida

### Primo Esempio

```python
from nostradamus import Predictor

# Crea un predittore
predictor = Predictor(model='auto')

# Addestra il modello (quando implementato)
# predictor.fit(data)

# Genera previsioni (quando implementato)
# predictions = predictor.predict(periods=30)
```

## API Reference

La documentazione completa dell'API sarà disponibile nelle prossime versioni.

## Esempi

Gli esempi sono disponibili nella cartella `examples/` del repository.

## FAQ

### D: Quali modelli sono supportati?

R: Attualmente il progetto è in fase di sviluppo. I modelli pianificati includono:
- ARIMA
- Prophet
- LSTM
- Random Forest
- E altri modelli di serie temporali

### D: Come posso contribuire?

R: Vedi la sezione "Contribuire" nel README.md principale.

### D: Il progetto è stabile?

R: Il progetto è attualmente in fase Alpha (v0.1.0). L'API potrebbe cambiare nelle future versioni.
