# Guida al Contributo

Grazie per il tuo interesse nel contribuire a Nostradamus! 🎉

## Come Contribuire

### Segnalare Bug

Se trovi un bug, per favore apri un issue con:
- Descrizione chiara del problema
- Passi per riprodurre il bug
- Comportamento atteso vs comportamento effettivo
- Versione di Python e sistema operativo

### Proporre Nuove Funzionalità

Per proporre nuove funzionalità:
1. Apri un issue per discutere l'idea
2. Aspetta feedback prima di iniziare l'implementazione
3. Assicurati che la funzionalità sia in linea con gli obiettivi del progetto

### Pull Request

#### Setup Ambiente di Sviluppo

```bash
# Clone repository
git clone https://github.com/federicoronzi/Nostradamus-.git
cd Nostradamus-

# Crea ambiente virtuale
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate

# Installa dipendenze di sviluppo
pip install -r requirements.txt
pip install -e .
```

#### Processo di Contributo

1. **Fork** il repository
2. **Crea un branch** per la tua feature:
   ```bash
   git checkout -b feature/nome-feature
   ```
3. **Implementa** le modifiche
4. **Aggiungi test** per le nuove funzionalità
5. **Esegui i test**:
   ```bash
   pytest tests/
   ```
6. **Formatta il codice**:
   ```bash
   black src/ tests/
   flake8 src/ tests/
   ```
7. **Commit** con messaggi descrittivi:
   ```bash
   git commit -m "Add: descrizione chiara della modifica"
   ```
8. **Push** al tuo fork:
   ```bash
   git push origin feature/nome-feature
   ```
9. **Apri una Pull Request** su GitHub

### Stile del Codice

- Segui [PEP 8](https://pep8.org/) per lo stile Python
- Usa `black` per la formattazione automatica
- Aggiungi docstring a tutte le funzioni e classi
- Scrivi test per le nuove funzionalità

### Commit Messages

Usa messaggi commit chiari e descrittivi:
- `Add: nuova funzionalità`
- `Fix: correzione bug`
- `Update: modifica esistente`
- `Docs: aggiornamento documentazione`
- `Test: aggiunta o modifica test`
- `Refactor: refactoring codice`

### Test

- Scrivi test unitari per nuove funzionalità
- Assicurati che tutti i test passino prima di aprire una PR
- Mantieni una copertura dei test >80%

### Documentazione

- Aggiorna la documentazione per nuove funzionalità
- Aggiungi esempi quando appropriato
- Usa docstring in formato NumPy/Google

## Code of Conduct

Sii rispettoso e costruttivo nelle interazioni con altri contributori.

## Domande?

Se hai domande, apri un issue o contatta i maintainer.

Grazie per il tuo contributo! 🙏
