# Documentazione iOS - Indice

Benvenuto nella documentazione completa per lo sviluppo, build e distribuzione dell'app iOS Nostradamus.

## 📚 Guide Disponibili

### 1. [Quick Start Guide](IOS_QUICK_START.md)
**Per chi ha fretta**

Una guida rapida di 5 minuti per:
- Setup iniziale veloce
- Esecuzione su simulatore
- Esecuzione su dispositivo fisico
- Generazione rapida IPA

**Ideale per**: Sviluppatori esperti che vogliono iniziare subito.

---

### 2. [Guida Completa alla Build iOS](IOS_BUILD_GUIDE.md)
**La guida definitiva**

Documentazione completa e dettagliata che copre:
- Prerequisiti e configurazione ambiente
- Installazione dipendenze
- Configurazione Xcode
- Build per sviluppo e produzione
- Generazione IPA
- Distribuzione TestFlight e App Store
- Installazione su dispositivi fisici
- Risoluzione problemi comuni
- Best practices per sicurezza

**Ideale per**: Chiunque voglia capire l'intero processo in dettaglio.

---

### 3. [Guida Configurazione Asset](IOS_ASSETS_GUIDE.md)
**Design e personalizzazione**

Come configurare e personalizzare:
- Icone dell'app (tutte le dimensioni)
- Splash screen (Launch Screen)
- Supporto Dark Mode
- Asset dinamici e localizzazione
- Tool e risorse per il design

**Ideale per**: Designer e sviluppatori che devono personalizzare l'aspetto dell'app.

---

### 4. [macOS Setup Guide](MACOS_SETUP.md)
**Setup completo su macOS**

Guida dettagliata per completare il setup iOS:
- Installazione automatizzata con script
- Setup manuale passo-passo
- Configurazione code signing
- Build e test su simulator e device
- Generazione IPA per distribuzione
- Troubleshooting completo

**Ideale per**: Completare il setup iniziale del progetto iOS su macOS.

---

### 5. [Validation Checklist](IOS_VALIDATION_CHECKLIST.md)
**Verifica completa del setup**

Checklist dettagliata per validare:
- Installazione prerequisiti
- Setup CocoaPods
- Configurazione code signing
- Build su simulator e device
- Generazione IPA
- Documentazione

**Ideale per**: Verificare che tutto sia stato configurato correttamente.

---

### 6. [Checklist Deployment](IOS_DEPLOYMENT_CHECKLIST.md)
**Lista di controllo completa**

Una checklist passo-passo per:
- Verifica ambiente
- Configurazione progetto
- Testing pre-compilazione
- Build e archive
- Distribuzione
- Post-distribuzione
- Sicurezza e compliance

**Ideale per**: Assicurarsi di non dimenticare nulla prima del rilascio.

---

## 🔧 Script e Tool

### [setup-ios.sh](../ios/setup-ios.sh)
Script automatizzato per setup completo iOS su macOS:

```bash
cd ios
./setup-ios.sh
```

Esegue:
- Verifica prerequisiti (Xcode, Node.js, CocoaPods)
- Installazione CocoaPods se necessario
- Esecuzione `pod install`
- Creazione workspace
- Lista simulatori disponibili

---

### [build-ios.sh](../ios/build-ios.sh)
Script per build e test dell'app:

```bash
cd ios
./build-ios.sh                              # Debug build per simulator
./build-ios.sh --release                     # Release build
./build-ios.sh --simulator "iPhone 14 Pro"  # Simulator specifico
./build-ios.sh --device                      # Build per dispositivo
```

---

### [generate-ipa.sh](../ios/generate-ipa.sh)
Script per generazione IPA per distribuzione:

```bash
cd ios
./generate-ipa.sh --development   # Per testing
./generate-ipa.sh --ad-hoc       # Per dispositivi registrati
./generate-ipa.sh --app-store    # Per App Store/TestFlight
./generate-ipa.sh --enterprise   # Per distribuzione enterprise
```

---

### [check-environment.sh](../check-environment.sh)
Script bash per verificare automaticamente che tutti i prerequisiti siano installati:

```bash
./check-environment.sh
```

Verifica:
- macOS e versione
- Xcode e Command Line Tools
- Node.js e npm
- CocoaPods
- Configurazione progetto

---

### [ExportOptions.plist](../ios/ExportOptions.plist)
Template per l'export di IPA con xcodebuild:

```bash
xcodebuild -exportArchive \
  -archivePath ./build/NostradamusMobile.xcarchive \
  -exportPath ./build \
  -exportOptionsPlist ExportOptions.plist
```

Supporta:
- App Store distribution
- Ad Hoc distribution
- Development distribution
- Enterprise distribution

---

## 🗺️ Percorsi di Apprendimento

### Per Principianti
Se è la tua prima app iOS:

1. Leggi la [Guida Completa alla Build iOS](IOS_BUILD_GUIDE.md) - Sezione Prerequisiti
2. Esegui [check-environment.sh](../check-environment.sh)
3. Segui la [macOS Setup Guide](MACOS_SETUP.md) per il setup completo
4. Usa la [Validation Checklist](IOS_VALIDATION_CHECKLIST.md) per verificare
5. Personalizza con la [Guida Asset](IOS_ASSETS_GUIDE.md)
6. Prima del rilascio, usa la [Checklist Deployment](IOS_DEPLOYMENT_CHECKLIST.md)

### Per Sviluppatori Esperti
Se hai già esperienza con React Native e iOS:

1. [Quick Start Guide](IOS_QUICK_START.md) - Per iniziare rapidamente
2. [macOS Setup Guide](MACOS_SETUP.md) - Per setup automatizzato
3. [Guida Completa](IOS_BUILD_GUIDE.md) - Sezioni specifiche quando necessario
4. [Checklist Deployment](IOS_DEPLOYMENT_CHECKLIST.md) - Prima del rilascio

### Per Designer
Se ti occupi principalmente di UI/UX:

1. [Guida Asset](IOS_ASSETS_GUIDE.md) - Configurazione completa
2. [Guida Completa](IOS_BUILD_GUIDE.md) - Sezione "Personalizzazione Asset"
3. [Quick Start](IOS_QUICK_START.md) - Per testare le modifiche

---

## 📱 Workflow Consigliati

### Sviluppo Quotidiano

```bash
# Avvia l'app su simulatore
npm run ios

# O su dispositivo specifico
npm run ios -- --simulator="iPhone 14 Pro"
```

**Documentazione**: [Quick Start Guide](IOS_QUICK_START.md)

---

### Prima Build Produzione

1. ✅ Verifica ambiente: `./check-environment.sh`
2. ✅ Controlla [Checklist Deployment](IOS_DEPLOYMENT_CHECKLIST.md) - Fase 1-3
3. ✅ Esegui test completi
4. ✅ Crea archive in Xcode
5. ✅ Distribuisci su TestFlight

**Documentazione**: 
- [Guida Completa](IOS_BUILD_GUIDE.md) - Sezione "Generazione IPA"
- [Checklist Deployment](IOS_DEPLOYMENT_CHECKLIST.md)

---

### Aggiornamento App Esistente

1. ✅ Incrementa versione e build number
2. ✅ Aggiorna changelog
3. ✅ Testa su dispositivi reali
4. ✅ Crea archive
5. ✅ Carica su App Store Connect
6. ✅ Aggiungi note di rilascio

**Documentazione**: [Guida Completa](IOS_BUILD_GUIDE.md) - Sezione "Distribuzione con TestFlight"

---

### Personalizzazione Visual

1. ✅ Crea icone app (1024x1024)
2. ✅ Genera tutte le dimensioni
3. ✅ Aggiorna in Xcode Assets
4. ✅ Personalizza splash screen
5. ✅ Testa su light/dark mode

**Documentazione**: [Guida Asset](IOS_ASSETS_GUIDE.md)

---

## 🆘 Risoluzione Problemi

### Problema con Build?
→ [Guida Completa](IOS_BUILD_GUIDE.md) - Sezione "Risoluzione Problemi"

### Problema con Pods?
→ [Quick Start](IOS_QUICK_START.md) - Sezione "Risoluzione Problemi Comuni"

### Problema con Asset?
→ [Guida Asset](IOS_ASSETS_GUIDE.md) - Varie sezioni specifiche

### Non sai da dove iniziare?
→ Esegui `./check-environment.sh` per identificare cosa manca

---

## 📞 Supporto e Risorse

### Documentazione di Riferimento

- [React Native iOS Guide](https://reactnative.dev/docs/running-on-device)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)

### Community

- [GitHub Issues](https://github.com/federicoronzi/Nostradamus-/issues)
- [React Native Community](https://reactnative.dev/community/overview)
- [Stack Overflow - React Native](https://stackoverflow.com/questions/tagged/react-native)

### Tool Utili

- [Fastlane](https://fastlane.tools/) - Automazione CI/CD
- [CocoaPods](https://cocoapods.org/) - Dependency manager
- [Appicon.co](https://appicon.co/) - Generatore icone
- [TestFlight](https://developer.apple.com/testflight/) - Beta testing

---

## 🔄 Aggiornamenti Documentazione

Questa documentazione viene aggiornata regolarmente. Assicurati di controllare la versione più recente nel repository.

**Ultima modifica**: Dicembre 2024  
**Versione documentazione**: 1.0.0  
**React Native Version**: 0.72.0  
**Xcode Version**: 14.0+

---

## ✨ Contribuire

Se trovi errori o vuoi migliorare questa documentazione:

1. Apri un [Issue](https://github.com/federicoronzi/Nostradamus-/issues)
2. Proponi modifiche via Pull Request
3. Contatta il team di sviluppo

---

## 📝 Note Finali

- **Usa sempre** il file `.xcworkspace`, mai `.xcodeproj`
- **Testa sempre** su dispositivi reali prima del rilascio
- **Incrementa sempre** il build number per ogni upload
- **Backup sempre** certificati e provisioning profile

**Buon sviluppo!** 🚀
