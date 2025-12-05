# Guida alla Compilazione e Distribuzione iOS per Nostradamus Mobile

Questa guida fornisce istruzioni dettagliate per compilare, testare e distribuire l'app mobile Nostradamus su dispositivi iOS.

## 📋 Indice

1. [Prerequisiti](#prerequisiti)
2. [Configurazione Iniziale](#configurazione-iniziale)
3. [Verifica dell'Ambiente](#verifica-dellambiente)
4. [Installazione delle Dipendenze](#installazione-delle-dipendenze)
5. [Configurazione Xcode](#configurazione-xcode)
6. [Build per Sviluppo](#build-per-sviluppo)
7. [Generazione IPA](#generazione-ipa)
8. [Distribuzione con TestFlight](#distribuzione-con-testflight)
9. [Installazione su Dispositivo Fisico](#installazione-su-dispositivo-fisico)
10. [Risoluzione Problemi](#risoluzione-problemi)

---

## 📱 Prerequisiti

### Software Richiesto

- **macOS**: 12.0 (Monterey) o superiore
- **Xcode**: 14.0 o superiore (scaricabile dal Mac App Store)
- **Command Line Tools**: Installabili da Xcode
- **Node.js**: 16.0 o superiore
- **npm**: 8.0 o superiore (installato con Node.js)
- **CocoaPods**: 1.11.0 o superiore
- **Git**: Per clonare il repository

### Account Apple

Per distribuire su dispositivi fisici o TestFlight, è necessario:

- **Apple Developer Account** (gratuito per sviluppo, a pagamento per distribuzione)
- **Certificati di sviluppo/distribuzione** (gestiti automaticamente da Xcode)

---

## 🔧 Configurazione Iniziale

### 1. Clonare il Repository

```bash
git clone https://github.com/federicoronzi/Nostradamus-.git
cd Nostradamus-/mobile-app
```

### 2. Installare CocoaPods

Se non è già installato:

```bash
sudo gem install cocoapods
```

Verifica l'installazione:

```bash
pod --version
```

### 3. Configurazione del Bundle Identifier

Il Bundle Identifier dell'app è configurato come:

```
com.federicoronzi.nostradamus.NostradamusMobile
```

Questo può essere modificato nelle impostazioni del progetto Xcode in **Signing & Capabilities**.

---

## ✅ Verifica dell'Ambiente

### Script di Verifica Automatica

Esegui questo script per verificare che tutti i prerequisiti siano installati:

```bash
#!/bin/bash

echo "=== Verifica Ambiente iOS Build ==="
echo ""

# Verifica macOS
echo "📍 Sistema Operativo:"
sw_vers | head -2

# Verifica Xcode
echo ""
echo "📍 Xcode:"
xcodebuild -version || echo "❌ Xcode non installato"

# Verifica Command Line Tools
echo ""
echo "📍 Command Line Tools:"
xcode-select -p || echo "❌ Command Line Tools non installato"

# Verifica Node.js
echo ""
echo "📍 Node.js:"
node --version || echo "❌ Node.js non installato"

# Verifica npm
echo ""
echo "📍 npm:"
npm --version || echo "❌ npm non installato"

# Verifica CocoaPods
echo ""
echo "📍 CocoaPods:"
pod --version || echo "❌ CocoaPods non installato"

# Verifica Git
echo ""
echo "📍 Git:"
git --version || echo "❌ Git non installato"

echo ""
echo "=== Verifica Completata ==="
```

Salva come `check-environment.sh`, rendilo eseguibile e lancialo:

```bash
chmod +x check-environment.sh
./check-environment.sh
```

---

## 📦 Installazione delle Dipendenze

### 1. Dipendenze JavaScript

```bash
# Dalla directory mobile-app
npm install
```

Questo installerà tutte le dipendenze React Native specificate in `package.json`.

### 2. Dipendenze iOS Native

```bash
cd ios
pod install
cd ..
```

Questo comando:
- Installa tutte le dipendenze native iOS specificate nel Podfile
- Genera il file `NostradamusMobile.xcworkspace`
- Configura le librerie native per React Native

**⚠️ IMPORTANTE**: Dopo aver eseguito `pod install`, usa **sempre** il file `.xcworkspace` per aprire il progetto in Xcode, **NON** il file `.xcodeproj`.

### 3. Aggiornamento delle Dipendenze

Se modifichi le dipendenze nel `package.json`:

```bash
npm install
cd ios
pod install
cd ..
```

Se hai problemi con le dipendenze:

```bash
# Pulisci e reinstalla
rm -rf node_modules
rm package-lock.json
npm install
cd ios
pod deintegrate
pod install
cd ..
```

---

## ⚙️ Configurazione Xcode

### 1. Aprire il Progetto

```bash
cd ios
open NostradamusMobile.xcworkspace
```

**NOTA**: Usa sempre il `.xcworkspace`, non il `.xcodeproj`!

### 2. Configurazione Team e Signing

1. Seleziona il progetto `NostradamusMobile` nel navigator
2. Seleziona il target `NostradamusMobile`
3. Vai alla tab **Signing & Capabilities**
4. Abilita **Automatically manage signing**
5. Seleziona il tuo **Team** dal menu a tendina
   - Se non hai un team, crea un account Apple ID gratuito

### 3. Configurazione del Bundle Identifier

Se necessario, modifica il Bundle Identifier:

1. In **Signing & Capabilities**, trova **Bundle Identifier**
2. Modifica in base alle tue esigenze (es. `com.tuosviluppatore.nostradamus`)
3. Assicurati che sia unico nell'App Store

### 4. Versione e Build Number

1. In **General**, trova **Version** e **Build**
2. **Version**: Versione visibile agli utenti (es. `1.0.0`)
3. **Build**: Numero di build incrementale (es. `1`, `2`, `3`, ...)

---

## 🔨 Build per Sviluppo

### Metodo 1: Tramite React Native CLI (Consigliato per sviluppo)

```bash
# Dalla directory mobile-app
npm run ios
```

Questo comando:
- Avvia Metro Bundler
- Compila l'app
- Installa sul simulatore iOS
- Avvia l'app

Per specificare un simulatore particolare:

```bash
npm run ios -- --simulator="iPhone 14 Pro"
```

Lista dei simulatori disponibili:

```bash
xcrun simctl list devices
```

### Metodo 2: Tramite Xcode

1. Apri `NostradamusMobile.xcworkspace` in Xcode
2. Seleziona uno schema e un dispositivo/simulatore dalla barra superiore
3. Clicca sul pulsante **Play** (▶️) o premi `Cmd + R`

### Build per Dispositivo Fisico

1. Collega il dispositivo iOS via USB
2. Sblocca il dispositivo e autorizza il computer
3. In Xcode, seleziona il tuo dispositivo dalla lista
4. Clicca su **Play** (▶️)
5. Sul dispositivo, vai a **Impostazioni > Generali > Gestione Dispositivo**
6. Autorizza il tuo certificato di sviluppo

---

## 📦 Generazione IPA

### Metodo 1: Archive con Xcode (Consigliato)

#### Passo 1: Configurazione Scheme

1. In Xcode, vai a **Product > Scheme > Edit Scheme**
2. Seleziona **Archive** nel menu a sinistra
3. Imposta **Build Configuration** su **Release**

#### Passo 2: Creare Archive

1. Seleziona **Any iOS Device (arm64)** come destinazione
   - NON selezionare un simulatore specifico
2. Vai a **Product > Archive** (o premi `Cmd + Shift + B`)
3. Attendi il completamento della build
4. L'Organizer di Xcode si aprirà automaticamente

#### Passo 3: Distribuire l'Archive

Nell'Organizer:

**Opzione A: App Store Distribution (TestFlight o App Store)**

1. Seleziona l'archive
2. Clicca **Distribute App**
3. Scegli **App Store Connect**
4. Segui la procedura guidata:
   - Upload per TestFlight
   - Include simboli di debug (consigliato)
   - Automatic signing

**Opzione B: Ad Hoc Distribution (Dispositivi registrati)**

1. Seleziona l'archive
2. Clicca **Distribute App**
3. Scegli **Ad Hoc**
4. Seleziona i dispositivi autorizzati
5. Esporta l'IPA

**Opzione C: Development (Test locale)**

1. Seleziona l'archive
2. Clicca **Distribute App**
3. Scegli **Development**
4. Esporta l'IPA

**Opzione D: Enterprise Distribution (Solo account Enterprise)**

1. Seleziona l'archive
2. Clicca **Distribute App**
3. Scegli **Enterprise**
4. Esporta l'IPA

### Metodo 2: Build da Command Line

```bash
# Dalla directory ios/
xcodebuild -workspace NostradamusMobile.xcworkspace \
  -scheme NostradamusMobile \
  -configuration Release \
  -archivePath ./build/NostradamusMobile.xcarchive \
  archive

# Esporta IPA
xcodebuild -exportArchive \
  -archivePath ./build/NostradamusMobile.xcarchive \
  -exportPath ./build \
  -exportOptionsPlist ExportOptions.plist
```

#### ExportOptions.plist Example

Crea un file `ExportOptions.plist` nella directory `ios/`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>ad-hoc</string>
    <!-- Opzioni: app-store, ad-hoc, development, enterprise -->
    <key>teamID</key>
    <string>YOUR_TEAM_ID</string>
    <key>uploadSymbols</key>
    <true/>
    <key>compileBitcode</key>
    <false/>
</dict>
</plist>
```

---

## 🚀 Distribuzione con TestFlight

TestFlight permette di distribuire l'app a tester beta prima del rilascio nell'App Store.

### Prerequisiti

1. **Apple Developer Program** (€99/anno)
2. App registrata in **App Store Connect**

### Configurazione App Store Connect

1. Vai a [App Store Connect](https://appstoreconnect.apple.com)
2. Clicca su **My Apps**
3. Clicca **+** e seleziona **New App**
4. Compila i dettagli:
   - **Platforms**: iOS
   - **Name**: Nostradamus
   - **Primary Language**: Italiano
   - **Bundle ID**: Seleziona il Bundle ID configurato
   - **SKU**: Identificatore unico (es. `nostradamus-mobile-001`)

### Upload Build

#### Opzione 1: Da Xcode (Consigliato)

1. Crea un Archive (vedi sezione precedente)
2. Nell'Organizer, seleziona **Distribute App**
3. Scegli **App Store Connect**
4. Segui la procedura guidata
5. Attendi il completamento dell'upload

#### Opzione 2: Con Transporter

1. Esporta IPA da Xcode
2. Apri **Transporter** (disponibile nel Mac App Store)
3. Trascina l'IPA nella finestra
4. Clicca **Deliver**

### Configurazione TestFlight

1. In App Store Connect, vai alla tua app
2. Vai alla tab **TestFlight**
3. Seleziona la build appena caricata
4. Aggiungi le note di rilascio
5. Aggiungi i tester:
   - **Tester Interni**: Membri del tuo team (fino a 100)
   - **Tester Esterni**: Utenti via email (fino a 10,000)

### Invitare Tester

1. Vai a **TestFlight > Tester**
2. Clicca **+** per aggiungere tester
3. Inserisci gli indirizzi email
4. I tester riceveranno un invito via email

I tester devono:
1. Installare l'app **TestFlight** dall'App Store
2. Aprire il link di invito ricevuto via email
3. Accettare l'invito
4. Installare l'app Nostradamus

---

## 📲 Installazione su Dispositivo Fisico

### Metodo 1: Via Xcode (Durante Sviluppo)

1. Collega il dispositivo con cavo USB
2. Sblocca il dispositivo
3. Autorizza il computer sul dispositivo
4. In Xcode, seleziona il dispositivo
5. Build and Run (`Cmd + R`)
6. Sul dispositivo, vai a **Impostazioni > Generali > Gestione Dispositivo**
7. Autorizza il certificato di sviluppo

### Metodo 2: Installazione IPA via Xcode Devices

1. Collega il dispositivo
2. In Xcode, vai a **Window > Devices and Simulators**
3. Seleziona il tuo dispositivo
4. Clicca **+** sotto **Installed Apps**
5. Seleziona il file `.ipa`
6. Attendi l'installazione

### Metodo 3: Installazione IPA via Apple Configurator

1. Scarica **Apple Configurator 2** dal Mac App Store
2. Collega il dispositivo
3. Seleziona il dispositivo nell'app
4. Trascina il file `.ipa` sul dispositivo

### Metodo 4: Over-the-Air (OTA) con servizi terzi

Servizi come Diawi, TestApp.io, o AppCenter permettono l'installazione OTA:

1. Carica l'IPA sul servizio
2. Genera un link di installazione
3. Apri il link sul dispositivo iOS
4. Segui le istruzioni di installazione

---

## 🎨 Personalizzazione Asset

### Icone dell'App

Le icone dell'app sono gestite in `ios/NostradamusMobile/Images.xcassets/AppIcon.appiconset/`.

**Dimensioni richieste**:

- iPhone: 60x60 (@2x, @3x), 40x40 (@2x, @3x), 29x29 (@2x, @3x)
- iPad: 76x76 (@1x, @2x), 40x40 (@1x, @2x), 29x29 (@1x, @2x)
- App Store: 1024x1024 (@1x)

**Strumenti per generare icone**:
- [Appicon.co](https://appicon.co/)
- [MakeAppIcon](https://makeappicon.com/)
- Asset Catalog Creator (Mac App)

**Procedura**:

1. Crea un'icona base 1024x1024px
2. Usa uno strumento per generare tutte le dimensioni
3. Trascina le icone in `AppIcon.appiconset` in Xcode
4. Verifica che tutte le dimensioni siano coperte

### Splash Screen (Launch Screen)

Il Launch Screen è definito in `ios/NostradamusMobile/LaunchScreen.storyboard`.

**Modifica in Xcode**:

1. Apri `LaunchScreen.storyboard` in Xcode
2. Usa Interface Builder per personalizzare:
   - Logo dell'app
   - Colore di sfondo
   - Testo (nome app, slogan, etc.)
3. Usa Auto Layout per supportare tutti i dispositivi

**Best Practices**:
- Usa immagini vettoriali (PDF) quando possibile
- Mantieni il design semplice
- Evita testo che richiede localizzazione
- Testa su diverse dimensioni di schermo

---

## 🔧 Risoluzione Problemi

### Errore: "Unable to boot the Simulator"

**Soluzione**:

```bash
# Reset simulatori
xcrun simctl shutdown all
xcrun simctl erase all

# Riavvia Xcode
killall Xcode
```

### Errore: "Command PhaseScriptExecution failed"

**Causa**: Problemi con gli script di build o Metro Bundler.

**Soluzione**:

```bash
# Reset cache
rm -rf ~/Library/Developer/Xcode/DerivedData/*
cd ios
rm -rf build
pod deintegrate
pod install
cd ..
npm start -- --reset-cache
```

### Errore: "Could not find iPhone X simulator"

**Soluzione**:

```bash
# Lista simulatori disponibili
xcrun simctl list devices

# Usa un simulatore esistente
npm run ios -- --simulator="iPhone 14"
```

### Errore: "Signing for ... requires a development team"

**Soluzione**:

1. Apri Xcode
2. Vai in **Signing & Capabilities**
3. Seleziona un Team
4. Se non hai un team, crea un Apple ID gratuito in Xcode

### Errore di Pod Install

**Soluzione**:

```bash
cd ios
pod cache clean --all
rm -rf Pods Podfile.lock
pod install
cd ..
```

### Build lenta o problemi di memoria

**Soluzione**:

1. Chiudi applicazioni non necessarie
2. Aumenta la dimensione della swap (se possibile)
3. Usa build incrementali invece di clean build
4. Considera l'uso di un Mac con più RAM

### Errore: "App installation failed" su dispositivo fisico

**Causa**: Certificati di sviluppo non autorizzati.

**Soluzione**:

1. Sul dispositivo, vai a **Impostazioni > Generali > Gestione Dispositivo**
2. Trova il certificato del tuo team
3. Tocca **Autorizza [Nome Developer]**
4. Conferma l'autorizzazione

### Metro Bundler non si avvia

**Soluzione**:

```bash
# Termina processi esistenti
lsof -ti:8081 | xargs kill -9

# Avvia Metro manualmente
npm start -- --reset-cache
```

### Problemi con react-native link

**NOTA**: Con React Native 0.60+, l'autolinking è abilitato di default. Evita l'uso di `react-native link`.

Se hai problemi:

```bash
cd ios
pod install
cd ..
```

---

## 📝 Checklist Pre-Build

Prima di creare una build per distribuzione:

- [ ] Aggiorna la versione in `ios/NostradamusMobile/Info.plist`
- [ ] Incrementa il build number
- [ ] Verifica che tutte le icone siano presenti
- [ ] Testa su diversi dispositivi/simulatori
- [ ] Verifica la configurazione di signing
- [ ] Aggiorna le note di rilascio
- [ ] Verifica le configurazioni di produzione (API URLs, etc.)
- [ ] Rimuovi console.log e debug code
- [ ] Testa la performance su dispositivi reali
- [ ] Verifica l'integrazione con backend
- [ ] Verifica il comportamento in modalità offline

---

## 📚 Risorse Utili

### Documentazione Ufficiale

- [React Native iOS Guide](https://reactnative.dev/docs/running-on-device)
- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [App Store Connect Help](https://help.apple.com/app-store-connect/)
- [TestFlight Documentation](https://developer.apple.com/testflight/)
- [Xcode Documentation](https://developer.apple.com/documentation/xcode)

### Tool e Utility

- [Fastlane](https://fastlane.tools/) - Automazione build e deploy
- [CocoaPods](https://cocoapods.org/) - Dependency manager
- [React Native Debugger](https://github.com/jhen0409/react-native-debugger)
- [Flipper](https://fbflipper.com/) - Debugging tool

### Community e Supporto

- [React Native Community](https://reactnative.dev/community/overview)
- [Stack Overflow - React Native](https://stackoverflow.com/questions/tagged/react-native)
- [React Native Discord](https://discord.com/invite/react-native)

---

## 🔐 Best Practices per la Sicurezza

1. **Non committare mai**:
   - Certificati `.p12`
   - Provisioning profiles
   - File `.env` con segreti
   - API keys o tokens

2. **Usa variabili d'ambiente** per configurazioni sensibili

3. **Abilita App Transport Security (ATS)** per connessioni HTTPS

4. **Valida input utente** sia lato client che server

5. **Usa Keychain** per memorizzare dati sensibili

6. **Implementa certificate pinning** per API critiche

7. **Offusca il codice** nelle build di produzione

8. **Abilita ProGuard/R8** per ridurre la superficie di attacco

---

## 📞 Supporto

Per problemi o domande:

- Apri un [Issue su GitHub](https://github.com/federicoronzi/Nostradamus-/issues)
- Consulta la [documentazione del progetto](../README.md)
- Contatta il team di sviluppo

---

**Ultima modifica**: Dicembre 2024
**Versione guida**: 1.0.0
