# Checklist Pre-Compilazione e Deployment iOS

Questa checklist ti guida attraverso tutti i passaggi necessari per preparare, compilare e distribuire l'app Nostradamus su iOS.

## 📋 Fase 1: Verifica Ambiente

### Sistema e Tool

- [ ] macOS 12.0 o superiore installato
- [ ] Xcode 14.0 o superiore installato e aggiornato
- [ ] Xcode Command Line Tools installati (`xcode-select --install`)
- [ ] Node.js 16.0 o superiore installato
- [ ] npm 8.0 o superiore installato
- [ ] CocoaPods 1.11.0 o superiore installato
- [ ] Git installato e configurato

**Script di Verifica**:
```bash
./check-environment.sh
```

### Account e Certificati

- [ ] Apple Developer Account configurato
  - Account gratuito: OK per sviluppo e testing su dispositivi propri
  - Account a pagamento (€99/anno): Richiesto per App Store e TestFlight
- [ ] Team configurato in Xcode (Preferences > Accounts)
- [ ] Certificati di sviluppo configurati (automatic signing consigliato)

---

## 📦 Fase 2: Configurazione Progetto

### Dipendenze

- [ ] Clonato il repository: `git clone https://github.com/federicoronzi/Nostradamus-.git`
- [ ] Dipendenze JavaScript installate: `npm install`
- [ ] Dipendenze iOS native installate: `cd ios && pod install && cd ..`
- [ ] Nessun errore durante `pod install`
- [ ] File `NostradamusMobile.xcworkspace` generato correttamente

### Configurazione App

- [ ] Bundle Identifier configurato correttamente in Xcode
  - Default: `com.federicoronzi.nostradamus.NostradamusMobile`
  - Verificare in: Target > General > Bundle Identifier
- [ ] Display Name configurato: "Nostradamus"
  - Verificare in: `Info.plist` > CFBundleDisplayName
- [ ] Versione app aggiornata (se necessario)
  - Formato: Major.Minor.Patch (es. 1.0.0)
  - Location: Target > General > Version
- [ ] Build number incrementato
  - Location: Target > General > Build
  - Deve essere incrementale per ogni upload

### Signing & Capabilities

- [ ] Automatic signing abilitato in Xcode
- [ ] Team selezionato correttamente
- [ ] Nessun errore di signing visualizzato
- [ ] Capabilities necessarie abilitate (se richieste dalla tua app)

### Configurazione API e Backend

- [ ] URL API di produzione configurato
  - Location: `src/services/NostradamusService.js` o file `.env`
- [ ] Chiavi API di produzione configurate (se applicabile)
- [ ] Timeout e configurazioni di rete verificate
- [ ] Endpoint backend testati e funzionanti

---

## 🎨 Fase 3: Asset e Risorse

### Icone App

- [ ] Icona 1024x1024 px per App Store presente
- [ ] Tutte le dimensioni icone iOS generate e aggiunte
  - iPhone: 60x60, 40x40, 29x29 (@2x, @3x)
  - iPad: 76x76, 40x40, 29x29 (@1x, @2x)
- [ ] Icone in formato PNG senza trasparenza
- [ ] Icone visibili su sfondi chiari e scuri
- [ ] Nessun warning sulle icone mancanti in Xcode

### Splash Screen

- [ ] Launch Screen configurato in `LaunchScreen.storyboard`
- [ ] Logo/testo ben posizionato e visibile
- [ ] Auto Layout configurato per supportare tutti i dispositivi
- [ ] Testato su iPhone SE, iPhone 14 Pro Max, iPad
- [ ] Supporto dark mode implementato (se desiderato)

### Risorse Multimediali

- [ ] Tutte le immagini necessarie aggiunte ad Assets.xcassets
- [ ] Immagini ottimizzate per dimensioni e performance
- [ ] Font personalizzati aggiunti e configurati (se applicabile)
- [ ] Localizzazione risorse completata (se multilingua)

---

## 🧪 Fase 4: Testing Pre-Compilazione

### Test Locali

- [ ] App avviata con successo su simulatore iOS
  ```bash
  npm run ios
  ```
- [ ] App testata su iPhone simulator (diverse dimensioni)
- [ ] App testata su iPad simulator
- [ ] Navigazione tra schermate funzionante
- [ ] Integrazione API backend testata
- [ ] Comportamento offline verificato
- [ ] Gestione errori testata

### Test su Dispositivo Fisico

- [ ] App installata su iPhone fisico
- [ ] App installata su iPad fisico (se supportato)
- [ ] Performance accettabili su dispositivi reali
- [ ] Autorizzazioni richieste funzionanti (se applicabile)
- [ ] Certificato di sviluppo autorizzato sul dispositivo

### Test Funzionali

- [ ] Login/autenticazione funzionante (se applicabile)
- [ ] Tutte le funzionalità principali testate
- [ ] Generazione predizioni funzionante
- [ ] Visualizzazione dati corretta
- [ ] Gestione stati di caricamento OK
- [ ] Gestione errori di rete OK

### Qualità del Codice

- [ ] Linting eseguito senza errori critici
  ```bash
  npm run lint
  ```
- [ ] Nessun console.log o codice di debug lasciato
- [ ] Build in modalità Release testata
- [ ] Memory leaks verificati (con Instruments se possibile)

---

## 🔨 Fase 5: Build e Archive

### Preparazione Build

- [ ] Modalità Release selezionata nello schema Xcode
  - Product > Scheme > Edit Scheme > Archive > Build Configuration: Release
- [ ] Pulizia build precedenti
  ```bash
  cd ios
  rm -rf build
  cd ..
  ```
- [ ] Reset cache Metro Bundler
  ```bash
  npm start -- --reset-cache
  ```

### Creazione Archive

- [ ] Target impostato su "Any iOS Device (arm64)"
- [ ] Archive creato con successo
  - Product > Archive
  - Nessun errore o warning critico
- [ ] Archive visibile nell'Organizer di Xcode
- [ ] Dimensione dell'archive ragionevole (tipicamente < 100 MB)

### Validazione Archive

- [ ] Archive validato prima della distribuzione
  - Organizer > Validate App
- [ ] Nessun errore di validazione
- [ ] Warning risolti o documentati

---

## 📤 Fase 6: Distribuzione

### Per TestFlight

- [ ] App registrata in App Store Connect
  - Nome app, Bundle ID, SKU configurati
- [ ] Screenshot e metadata preparati (se prima submission)
- [ ] Privacy policy URL configurato (se richiesto)
- [ ] Export Compliance configurata
- [ ] Archive distribuito ad App Store Connect
  - Organizer > Distribute App > App Store Connect
- [ ] Upload completato con successo
- [ ] Build apparso in App Store Connect (può richiedere 5-30 minuti)
- [ ] Build processato senza errori
- [ ] Note di rilascio aggiunte in TestFlight
- [ ] Tester interni/esterni invitati

### Per Ad Hoc Distribution

- [ ] Dispositivi registrati in Apple Developer Portal
- [ ] Provisioning profile ad-hoc generato
- [ ] IPA esportato con metodo "Ad Hoc"
- [ ] File `ExportOptions.plist` configurato correttamente
- [ ] IPA testato su dispositivi target

### Per Distribuzione Diretta (Development)

- [ ] IPA esportato con metodo "Development"
- [ ] IPA installato su dispositivo di test
- [ ] App avviata con successo su dispositivo
- [ ] Funzionalità verificate su dispositivo fisico

---

## 📝 Fase 7: Post-Distribuzione

### Monitoraggio TestFlight

- [ ] Email di invito ricevuta dai tester
- [ ] Tester confermato accesso all'app
- [ ] Crash logs monitorati in App Store Connect
- [ ] Feedback tester raccolto e documentato

### Bug Tracking e Correzioni

- [ ] Sistema di bug tracking attivo
- [ ] Bug critici identificati e prioritizzati
- [ ] Hotfix preparati se necessario
- [ ] Nuova build preparata con fix (se richiesto)

### Metriche e Analytics

- [ ] Sistema di analytics configurato (se applicabile)
- [ ] Metriche di utilizzo monitorate
- [ ] Performance app monitorate
- [ ] Crash rate accettabile (< 1%)

---

## 🔐 Fase 8: Sicurezza e Compliance

### Sicurezza

- [ ] Nessuna API key o secret committata nel codice
- [ ] Certificati e provisioning profile non inclusi nel repository
- [ ] Connessioni API usano HTTPS
- [ ] Input utente validato e sanitizzato
- [ ] Dati sensibili memorizzati in Keychain (se applicabile)

### Privacy e Compliance

- [ ] Privacy policy presente e aggiornata
- [ ] Permessi iOS richiesti con descrizioni chiare
  - Location, Camera, Photos, etc.
- [ ] GDPR compliance verificato (se applicabile in UE)
- [ ] Terms of Service aggiornati
- [ ] Data collection disclosure accurata

### App Store Guidelines

- [ ] App segue le [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [ ] Nessun contenuto proibito o inappropriato
- [ ] Funzionalità complete e funzionanti
- [ ] Metadata accurati e non fuorvianti
- [ ] Screenshot rappresentativi dell'app

---

## 📚 Documentazione

### Documentazione Tecnica

- [ ] README aggiornato con istruzioni di build
- [ ] Changelog aggiornato con nuove features
- [ ] Documentazione API aggiornata
- [ ] Commenti nel codice dove necessario

### Documentazione Utente

- [ ] Guida utente disponibile (se necessaria)
- [ ] FAQ preparate
- [ ] Supporto tecnico configurato
- [ ] Release notes chiare per gli utenti

---

## 🚀 Checklist Finale Pre-Release

Prima di premere "Submit for Review":

- [ ] **Tutti i test passati** ✓
- [ ] **App testata su dispositivi reali** ✓
- [ ] **Screenshot App Store aggiornati** ✓
- [ ] **Descrizione App Store completa** ✓
- [ ] **Keywords ottimizzate** ✓
- [ ] **Rating età appropriato** ✓
- [ ] **Privacy policy link valido** ✓
- [ ] **Supporto URL funzionante** ✓
- [ ] **Beta testing completato** ✓
- [ ] **Feedback beta incorporato** ✓
- [ ] **Team informato del rilascio** ✓
- [ ] **Piano di marketing pronto** ✓
- [ ] **Supporto clienti preparato** ✓

---

## 🆘 Troubleshooting Rapido

### Se l'archive fallisce:

1. Pulisci build: `Product > Clean Build Folder` (Cmd + Shift + K)
2. Chiudi Xcode
3. Elimina DerivedData: `rm -rf ~/Library/Developer/Xcode/DerivedData/*`
4. Riapri Xcode e riprova

### Se pod install fallisce:

```bash
cd ios
pod cache clean --all
rm -rf Pods Podfile.lock
pod install
cd ..
```

### Se la validazione fallisce:

1. Leggi attentamente il messaggio di errore
2. Verifica certificati e provisioning profile
3. Controlla Export Compliance
4. Verifica Info.plist per chiavi mancanti

---

## 📞 Supporto

- [iOS Build Guide Completa](IOS_BUILD_GUIDE.md)
- [Quick Start Guide](IOS_QUICK_START.md)
- [Assets Configuration Guide](IOS_ASSETS_GUIDE.md)
- [GitHub Issues](https://github.com/federicoronzi/Nostradamus-/issues)

---

**Ultima modifica**: Dicembre 2024
**Versione**: 1.0.0

**Note**: Questa checklist è pensata per essere stampata e usata come riferimento durante il processo di build e deploy.
