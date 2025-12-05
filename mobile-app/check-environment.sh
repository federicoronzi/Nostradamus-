#!/bin/bash

# Script per verificare l'ambiente di sviluppo iOS
# per il progetto Nostradamus Mobile

echo "=========================================="
echo "  Verifica Ambiente iOS Build"
echo "  Nostradamus Mobile App"
echo "=========================================="
echo ""

# Colori per output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

check_passed=0
check_failed=0
warnings=0

# Funzione per stampare successo
print_success() {
    echo -e "${GREEN}✓${NC} $1"
    ((check_passed++))
}

# Funzione per stampare errore
print_error() {
    echo -e "${RED}✗${NC} $1"
    ((check_failed++))
}

# Funzione per stampare warning
print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((warnings++))
}

# Verifica macOS
echo "📍 Sistema Operativo:"
if [[ "$OSTYPE" == "darwin"* ]]; then
    macos_version=$(sw_vers -productVersion)
    print_success "macOS $macos_version"
else
    print_error "Questo script deve essere eseguito su macOS"
fi
echo ""

# Verifica Xcode
echo "📍 Xcode:"
if command -v xcodebuild &> /dev/null; then
    xcode_version=$(xcodebuild -version | head -1)
    print_success "$xcode_version"
    
    # Verifica versione minima (14.0)
    xcode_major=$(xcodebuild -version | head -1 | sed 's/Xcode //' | cut -d. -f1)
    if [ "$xcode_major" -lt 14 ]; then
        print_warning "Si consiglia Xcode 14.0 o superiore"
    fi
else
    print_error "Xcode non installato. Scaricalo dal Mac App Store."
fi
echo ""

# Verifica Command Line Tools
echo "📍 Command Line Tools:"
if xcode-select -p &> /dev/null; then
    xcode_path=$(xcode-select -p)
    print_success "Installato in: $xcode_path"
else
    print_error "Command Line Tools non installato. Esegui: xcode-select --install"
fi
echo ""

# Verifica Node.js
echo "📍 Node.js:"
if command -v node &> /dev/null; then
    node_version=$(node --version)
    print_success "Node.js $node_version"
    
    # Verifica versione minima (v16.0)
    node_major=$(node --version | sed 's/v//' | cut -d. -f1)
    if [ "$node_major" -lt 16 ]; then
        print_error "Node.js 16.0 o superiore richiesto. Versione attuale: $node_version"
    fi
else
    print_error "Node.js non installato. Scaricalo da https://nodejs.org"
fi
echo ""

# Verifica npm
echo "📍 npm:"
if command -v npm &> /dev/null; then
    npm_version=$(npm --version)
    print_success "npm $npm_version"
else
    print_error "npm non installato (dovrebbe essere incluso con Node.js)"
fi
echo ""

# Verifica CocoaPods
echo "📍 CocoaPods:"
if command -v pod &> /dev/null; then
    pod_version=$(pod --version)
    print_success "CocoaPods $pod_version"
else
    print_error "CocoaPods non installato. Esegui: sudo gem install cocoapods"
fi
echo ""

# Verifica Git
echo "📍 Git:"
if command -v git &> /dev/null; then
    git_version=$(git --version)
    print_success "$git_version"
else
    print_error "Git non installato"
fi
echo ""

# Verifica dipendenze del progetto
echo "📍 Dipendenze del Progetto:"
if [ -f "package.json" ]; then
    print_success "package.json trovato"
    
    if [ -d "node_modules" ]; then
        print_success "node_modules presente"
    else
        print_warning "node_modules non presente. Esegui: npm install"
    fi
else
    print_error "package.json non trovato. Sei nella directory corretta?"
fi
echo ""

# Verifica configurazione iOS
echo "📍 Configurazione iOS:"
if [ -d "ios" ]; then
    print_success "Directory ios/ presente"
    
    if [ -f "ios/Podfile" ]; then
        print_success "Podfile presente"
    else
        print_error "Podfile non trovato"
    fi
    
    if [ -d "ios/Pods" ]; then
        print_success "Pods installati"
    else
        print_warning "Pods non installati. Esegui: cd ios && pod install"
    fi
    
    if [ -f "ios/NostradamusMobile.xcworkspace" ]; then
        print_success "Workspace Xcode presente"
    else
        print_warning "Workspace Xcode non trovato. Esegui: cd ios && pod install"
    fi
else
    print_error "Directory ios/ non trovata"
fi
echo ""

# Verifica simulatori iOS
echo "📍 Simulatori iOS:"
if command -v xcrun &> /dev/null; then
    sim_count=$(xcrun simctl list devices available | grep -c "iPhone")
    if [ "$sim_count" -gt 0 ]; then
        print_success "$sim_count simulatori iPhone disponibili"
    else
        print_warning "Nessun simulatore iPhone disponibile"
    fi
else
    print_error "xcrun non disponibile"
fi
echo ""

# Riepilogo
echo "=========================================="
echo "  Riepilogo"
echo "=========================================="
echo -e "${GREEN}Verifiche superate:${NC} $check_passed"
if [ "$warnings" -gt 0 ]; then
    echo -e "${YELLOW}Avvisi:${NC} $warnings"
fi
if [ "$check_failed" -gt 0 ]; then
    echo -e "${RED}Verifiche fallite:${NC} $check_failed"
fi
echo ""

if [ "$check_failed" -eq 0 ]; then
    echo -e "${GREEN}✓ L'ambiente è configurato correttamente!${NC}"
    echo ""
    echo "Prossimi passi:"
    echo "1. Installa le dipendenze: npm install"
    echo "2. Installa i Pods: cd ios && pod install && cd .."
    echo "3. Avvia l'app: npm run ios"
    exit 0
else
    echo -e "${RED}✗ Risolvi gli errori prima di procedere.${NC}"
    echo ""
    echo "Consulta la documentazione: docs/IOS_BUILD_GUIDE.md"
    exit 1
fi
