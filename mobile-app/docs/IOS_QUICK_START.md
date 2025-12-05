# Quick Start - iOS Build

Guida rapida per compilare e testare l'app Nostradamus su iOS.

## ⚡ Setup Veloce (5 minuti)

### 1. Prerequisiti

Assicurati di avere:
- ✅ macOS 12.0+
- ✅ Xcode 14.0+ (dal Mac App Store)
- ✅ Node.js 16.0+
- ✅ CocoaPods installato

### 2. Installazione

```bash
# Clona il repository
git clone https://github.com/federicoronzi/Nostradamus-.git
cd Nostradamus-/mobile-app

# Verifica l'ambiente (opzionale)
./check-environment.sh

# Installa dipendenze JavaScript
npm install

# Installa dipendenze iOS native
cd ios
pod install
cd ..
```

### 3. Esecuzione su Simulatore

```bash
# Avvia l'app su simulatore iOS
npm run ios
```

Oppure specifica un simulatore:

```bash
npm run ios -- --simulator="iPhone 14 Pro"
```

### 4. Esecuzione su Dispositivo Fisico

1. Collega il tuo iPhone/iPad via USB
2. Apri Xcode:
   ```bash
   open ios/NostradamusMobile.xcworkspace
   ```
3. Seleziona il tuo dispositivo dalla barra superiore
4. In **Signing & Capabilities**, seleziona il tuo Team
5. Clicca sul pulsante Play (▶️)
6. Sul dispositivo, vai a **Impostazioni > Generali > Gestione Dispositivo** e autorizza il certificato

## 📦 Generazione IPA per TestFlight

### Metodo Rapido (Xcode)

1. Apri il workspace:
   ```bash
   open ios/NostradamusMobile.xcworkspace
   ```

2. Seleziona **Any iOS Device (arm64)** come target

3. Vai a **Product > Archive**

4. Una volta completato, clicca **Distribute App**

5. Scegli **App Store Connect** per TestFlight

6. Segui la procedura guidata

### Metodo Command Line

```bash
cd ios

# Crea archive
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

**Nota**: Modifica `ExportOptions.plist` con il tuo Team ID prima di eseguire.

## 🔧 Risoluzione Problemi Comuni

### Errore: "Unable to install Pods"

```bash
cd ios
pod cache clean --all
rm -rf Pods Podfile.lock
pod install
cd ..
```

### Errore: "Command PhaseScriptExecution failed"

```bash
# Reset cache di Metro
npm start -- --reset-cache
```

### Errore: "Signing requires a development team"

1. Apri Xcode
2. Seleziona il progetto > Target > Signing & Capabilities
3. Abilita "Automatically manage signing"
4. Seleziona un Team (crea un Apple ID gratuito se necessario)

### Build lenta

```bash
# Pulisci la build cache
rm -rf ~/Library/Developer/Xcode/DerivedData/*
cd ios
rm -rf build
cd ..
```

## 📚 Documentazione Completa

Per istruzioni dettagliate su:
- Configurazione avanzata
- Distribuzione TestFlight
- Personalizzazione icone e splash screen
- Risoluzione problemi avanzati

Consulta la **[Guida Completa alla Build iOS](IOS_BUILD_GUIDE.md)**.

## 🆘 Supporto

Problemi? Apri un [Issue su GitHub](https://github.com/federicoronzi/Nostradamus-/issues).

---

**Tip**: Usa sempre il file `.xcworkspace`, mai il `.xcodeproj`!
