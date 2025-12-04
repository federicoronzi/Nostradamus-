"""
Esempio Base - Nostradamus
===========================

Questo esempio mostra come utilizzare il framework Nostradamus per
creare un semplice modello di previsione.

Nota: Questo è un esempio di struttura. Le funzionalità saranno 
implementate nelle prossime versioni.
"""

import sys
import os

# Add src directory to path for imports
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../src')))

import nostradamus


def main():
    """Esempio base di utilizzo di Nostradamus."""
    
    print(f"Nostradamus v{nostradamus.__version__}")
    print(f"Author: {nostradamus.__author__}")
    print(f"License: {nostradamus.__license__}")
    print("\n" + "="*50)
    
    print("\nBenvenuto in Nostradamus!")
    print("Questo è un esempio di base.")
    print("\nLe funzionalità di previsione saranno implementate")
    print("nelle prossime versioni del progetto.")
    
    # Esempio di struttura (da implementare):
    # from nostradamus import Predictor
    # 
    # # Carica dati
    # data = load_sample_data()
    # 
    # # Crea predittore
    # predictor = Predictor(model='auto')
    # 
    # # Addestra
    # predictor.fit(data)
    # 
    # # Prevedi
    # predictions = predictor.predict(periods=30)
    # 
    # # Visualizza
    # predictor.plot_predictions()


if __name__ == "__main__":
    main()
