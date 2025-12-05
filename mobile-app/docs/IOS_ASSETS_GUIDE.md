# Guida alla Configurazione degli Asset iOS

Questa guida spiega come configurare e personalizzare le icone dell'app e lo splash screen per l'app iOS Nostradamus.

## 📱 Icone dell'App

### Posizione dei File

Le icone dell'app sono gestite in:
```
ios/NostradamusMobile/Images.xcassets/AppIcon.appiconset/
```

### Dimensioni Richieste

Per iOS, sono necessarie diverse dimensioni di icone per supportare vari dispositivi e contesti:

#### iPhone

| Dimensione | Risoluzione | File |
|------------|-------------|------|
| 20pt @2x | 40x40 px | Icon-App-20x20@2x.png |
| 20pt @3x | 60x60 px | Icon-App-20x20@3x.png |
| 29pt @2x | 58x58 px | Icon-App-29x29@2x.png |
| 29pt @3x | 87x87 px | Icon-App-29x29@3x.png |
| 40pt @2x | 80x80 px | Icon-App-40x40@2x.png |
| 40pt @3x | 120x120 px | Icon-App-40x40@3x.png |
| 60pt @2x | 120x120 px | Icon-App-60x60@2x.png |
| 60pt @3x | 180x180 px | Icon-App-60x60@3x.png |

#### iPad

| Dimensione | Risoluzione | File |
|------------|-------------|------|
| 20pt @1x | 20x20 px | Icon-App-20x20@1x.png |
| 20pt @2x | 40x40 px | Icon-App-20x20@2x.png |
| 29pt @1x | 29x29 px | Icon-App-29x29@1x.png |
| 29pt @2x | 58x58 px | Icon-App-29x29@2x.png |
| 40pt @1x | 40x40 px | Icon-App-40x40@1x.png |
| 40pt @2x | 80x80 px | Icon-App-40x40@2x.png |
| 76pt @1x | 76x76 px | Icon-App-76x76@1x.png |
| 76pt @2x | 152x152 px | Icon-App-76x76@2x.png |
| 83.5pt @2x | 167x167 px | Icon-App-83.5x83.5@2x.png |

#### App Store

| Dimensione | Risoluzione | File |
|------------|-------------|------|
| 1024pt @1x | 1024x1024 px | Icon-App-1024x1024@1x.png |

### Come Generare le Icone

#### Metodo 1: Tool Online (Più Semplice)

1. **Appicon.co** (https://appicon.co/)
   - Carica un'immagine 1024x1024 px
   - Seleziona "iOS"
   - Scarica il pacchetto generato
   - Trascina le icone in Xcode

2. **MakeAppIcon** (https://makeappicon.com/)
   - Simile ad Appicon.co
   - Supporta anche Android

#### Metodo 2: Sketch/Figma/Photoshop

Se hai competenze di design:

1. Crea un'icona base 1024x1024 px
2. Esporta tutte le dimensioni richieste
3. Nomina i file secondo la convenzione iOS
4. Importa in Xcode

#### Metodo 3: Asset Catalog Creator (Mac App)

1. Scarica "Asset Catalog Creator" dal Mac App Store
2. Importa l'icona 1024x1024 px
3. Esporta tutte le dimensioni
4. Importa in Xcode

### Linee Guida per il Design

#### Requisiti Apple

- **Formato**: PNG (senza trasparenza)
- **Colore**: RGB (non CMYK)
- **Risoluzione**: 72 DPI minimo
- **Forma**: Quadrata (i bordi arrotondati vengono applicati automaticamente da iOS)
- **Contenuto**: Nessun testo promozionale, nessun "beta", nessun watermark

#### Best Practices

1. **Semplicità**: Design pulito e riconoscibile anche a piccole dimensioni
2. **Colori Vividi**: Usa colori che si distinguono
3. **Contrasto**: Assicurati che l'icona sia visibile su sfondi chiari e scuri
4. **Coerenza**: Mantieni lo stile coerente con l'identità del brand
5. **Test**: Verifica l'icona su dispositivi reali con diverse dimensioni

### Aggiornare le Icone in Xcode

1. Apri il progetto in Xcode:
   ```bash
   open ios/NostradamusMobile.xcworkspace
   ```

2. Nel navigatore di progetto, vai a:
   ```
   NostradamusMobile > Images.xcassets > AppIcon
   ```

3. Trascina e rilascia le icone nelle slot appropriate

4. Verifica che tutte le dimensioni siano coperte (nessun warning)

5. Build e testa l'app per vedere l'icona aggiornata

---

## 🎨 Splash Screen (Launch Screen)

### Posizione del File

Lo splash screen è definito in:
```
ios/NostradamusMobile/LaunchScreen.storyboard
```

### Modifica dello Splash Screen

#### In Xcode (Interface Builder)

1. Apri il progetto:
   ```bash
   open ios/NostradamusMobile.xcworkspace
   ```

2. Nel navigatore, seleziona `LaunchScreen.storyboard`

3. Usa Interface Builder per modificare:
   - Logo: Aggiungi un UIImageView
   - Testo: Aggiungi un UILabel
   - Colore di sfondo: Modifica il colore del View Controller
   - Layout: Usa Auto Layout per supportare tutti i dispositivi

#### Aggiungere un Logo

1. Aggiungi l'immagine del logo a `Images.xcassets`:
   - Trascina il logo in Assets.xcassets
   - Crea un nuovo Image Set chiamato "splash-logo"

2. In `LaunchScreen.storyboard`:
   - Aggiungi un UIImageView
   - Imposta l'immagine su "splash-logo"
   - Centra l'immagine usando constraints Auto Layout

#### Aggiungere Testo

1. Trascina un UILabel nello storyboard

2. Configura le proprietà:
   - Testo: "Nostradamus" o il nome dell'app
   - Font: Personalizza font e dimensione
   - Colore: Scegli un colore visibile

3. Aggiungi constraints per centrare il label

#### Colore di Sfondo

1. Seleziona il View nello storyboard

2. Nel pannello Attributes Inspector:
   - Trova "Background"
   - Seleziona un colore

### Best Practices per Splash Screen

#### Requisiti Apple

- **Semplicità**: Apple scoraggia splash screen elaborati
- **Velocità**: Deve essere veloce da caricare
- **Coerenza**: Deve apparire come la prima schermata dell'app
- **No branding**: Evita splash screen troppo "brandizzati"

#### Design Consigliato

1. **Minimalista**: Logo centrato su sfondo solido
2. **Colori Brand**: Usa i colori del tuo brand
3. **Leggero**: Usa immagini vettoriali (PDF) quando possibile
4. **Responsive**: Testa su iPhone SE, iPhone 14 Pro Max, iPad

#### Template Comune

```
┌─────────────────────┐
│                     │
│                     │
│        [LOGO]       │
│                     │
│    Nome App         │
│                     │
│                     │
└─────────────────────┘
```

### Gestione Dimensioni Schermo

Usa Auto Layout per supportare:
- iPhone SE (4" - 5.4")
- iPhone standard (6.1")
- iPhone Pro Max (6.7")
- iPad (10.2" - 12.9")

**Constraints Consigliati**:
```
Logo:
- Center X = Superview Center X
- Center Y = Superview Center Y * 0.8
- Width = 120pt
- Height = 120pt (1:1 ratio)

Label:
- Center X = Superview Center X
- Top = Logo Bottom + 20pt
```

---

## 🎭 Dark Mode Support

### Configurare Icone per Dark Mode

1. In `AppIcon.appiconset`, puoi aggiungere varianti dark:
   - Seleziona l'asset set
   - Inspector > Attributes
   - Appearance: "Any, Dark"

2. Trascina icone ottimizzate per dark mode

### Configurare Splash Screen per Dark Mode

1. Apri `LaunchScreen.storyboard`

2. Seleziona il View

3. Inspector > Attributes:
   - Background: "System Background Color"
   - Questo si adatta automaticamente a light/dark mode

4. Per colori personalizzati:
   - Crea un Color Set in Assets.xcassets
   - Definisci varianti "Any Appearance" e "Dark Appearance"
   - Usa questo color set nello storyboard

---

## 🔄 Asset Dinamici (Avanzato)

### Usare PDF Vettoriali

I PDF vettoriali scalano meglio e occupano meno spazio:

1. Salva l'icona/logo come PDF

2. In Xcode, trascina il PDF in Assets.xcassets

3. Inspector > Attributes:
   - Seleziona "Preserve Vector Data"
   - Imposta "Single Scale"

4. iOS genererà automaticamente tutte le dimensioni

### Localizzazione Asset

Per supportare lingue diverse:

1. Seleziona l'asset in Assets.xcassets

2. Inspector > Attributes:
   - Seleziona "Localize"
   - Scegli le lingue

3. Fornisci asset localizzati per ogni lingua

---

## ✅ Checklist Pre-Release

Prima di pubblicare l'app:

- [ ] Tutte le dimensioni di icone sono presenti
- [ ] Icona App Store (1024x1024) è presente
- [ ] Icone sono in formato PNG senza trasparenza
- [ ] Splash screen funziona su tutte le dimensioni di dispositivi
- [ ] Splash screen supporta light/dark mode (se applicabile)
- [ ] Asset non contengono testo che richiede localizzazione
- [ ] Asset rispettano le linee guida Apple
- [ ] Test su dispositivi reali (iPhone e iPad)
- [ ] Nessun warning in Xcode riguardo asset mancanti

---

## 📚 Risorse

### Strumenti

- [Appicon.co](https://appicon.co/) - Generatore icone online
- [MakeAppIcon](https://makeappicon.com/) - Alternativa
- [Sketch](https://www.sketch.com/) - Design professionale
- [Figma](https://www.figma.com/) - Design collaborativo
- Asset Catalog Creator - App Mac

### Documentazione Apple

- [App Icon Guidelines](https://developer.apple.com/design/human-interface-guidelines/app-icons)
- [Launch Screen Guidelines](https://developer.apple.com/design/human-interface-guidelines/launching)
- [Asset Catalog Format](https://developer.apple.com/library/archive/documentation/Xcode/Reference/xcode_ref-Asset_Catalog_Format/)

### Design

- [SF Symbols](https://developer.apple.com/sf-symbols/) - Icone di sistema Apple
- [iOS Design Themes](https://developer.apple.com/design/human-interface-guidelines/design-themes)

---

**Ultima modifica**: Dicembre 2024
