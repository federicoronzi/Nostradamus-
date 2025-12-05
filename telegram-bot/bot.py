"""
Nostradamus Telegram Bot
========================

Bot Telegram per interagire con il sistema di previsione Nostradamus.
Fornisce un'interfaccia conversazionale per generare predizioni e ottenere informazioni.

Autore: Federico Ronzi
Licenza: MIT
"""

import os
import sys
import logging
from datetime import datetime
from typing import Dict, List
from telegram import Update, InlineKeyboardButton, InlineKeyboardMarkup
from telegram.ext import (
    Application,
    CommandHandler,
    CallbackQueryHandler,
    MessageHandler,
    filters,
    ContextTypes,
)

# Aggiungi il path al modulo nostradamus
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../src')))

import nostradamus

# Configurazione logging
logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    level=logging.INFO
)
logger = logging.getLogger(__name__)


class NostradamusBot:
    """Classe principale per il bot Telegram di Nostradamus."""
    
    def __init__(self, token: str):
        """
        Inizializza il bot.
        
        Args:
            token: Token del bot Telegram fornito da BotFather
        """
        self.token = token
        self.application = None
        
    async def start_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
        """
        Handler per il comando /start.
        Mostra il messaggio di benvenuto e le opzioni disponibili.
        """
        user = update.effective_user
        welcome_message = (
            f"🔮 Benvenuto {user.mention_html()}!\n\n"
            f"Sono il bot di *Nostradamus*, il sistema di previsione "
            f"e analisi predittiva.\n\n"
            f"*Versione:* {nostradamus.__version__}\n"
            f"*Autore:* {nostradamus.__author__}\n\n"
            f"Usa /help per vedere tutti i comandi disponibili."
        )
        
        keyboard = [
            [
                InlineKeyboardButton("📊 Genera Predizione", callback_data='predict'),
                InlineKeyboardButton("ℹ️ Info", callback_data='info'),
            ],
            [
                InlineKeyboardButton("❓ Aiuto", callback_data='help'),
            ],
        ]
        reply_markup = InlineKeyboardMarkup(keyboard)
        
        await update.message.reply_html(
            welcome_message,
            reply_markup=reply_markup
        )
    
    async def help_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
        """Handler per il comando /help."""
        help_text = (
            "🔮 *Comandi Disponibili:*\n\n"
            "/start - Avvia il bot e mostra il menu principale\n"
            "/help - Mostra questo messaggio di aiuto\n"
            "/info - Informazioni sul progetto Nostradamus\n"
            "/predict <periodi> - Genera una predizione\n"
            "   Esempio: /predict 30\n"
            "/models - Lista dei modelli disponibili\n"
            "/about - Informazioni sul bot\n\n"
            "*Come usare il bot:*\n"
            "1. Usa /predict seguito dal numero di periodi\n"
            "2. Il bot genererà una predizione\n"
            "3. Riceverai i risultati con statistiche\n\n"
            "Per maggiori informazioni: /about"
        )
        await update.message.reply_text(help_text, parse_mode='Markdown')
    
    async def info_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
        """Handler per il comando /info."""
        info_text = (
            f"📊 *Nostradamus - Sistema di Previsione*\n\n"
            f"*Versione:* {nostradamus.__version__}\n"
            f"*Autore:* {nostradamus.__author__}\n"
            f"*Licenza:* {nostradamus.__license__}\n\n"
            f"*Descrizione:*\n"
            f"Nostradamus è un framework di previsione e analisi predittiva "
            f"che utilizza tecniche avanzate di machine learning per generare "
            f"predizioni accurate basate su dati storici.\n\n"
            f"*Caratteristiche principali:*\n"
            f"• Supporto per diversi algoritmi (ARIMA, Prophet, LSTM)\n"
            f"• Preprocessing automatico dei dati\n"
            f"• Valutazione delle performance\n"
            f"• Export dei risultati in vari formati\n\n"
            f"Repository: https://github.com/federicoronzi/Nostradamus-"
        )
        await update.message.reply_text(info_text, parse_mode='Markdown')
    
    async def predict_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
        """
        Handler per il comando /predict.
        Genera una predizione per il numero di periodi specificato.
        """
        # Estrai il numero di periodi dagli argomenti
        try:
            if not context.args or len(context.args) == 0:
                await update.message.reply_text(
                    "⚠️ Specifica il numero di periodi.\n"
                    "Esempio: /predict 30"
                )
                return
            
            periods = int(context.args[0])
            
            if periods <= 0 or periods > 365:
                await update.message.reply_text(
                    "⚠️ Il numero di periodi deve essere tra 1 e 365."
                )
                return
            
            # Invia messaggio di attesa
            processing_message = await update.message.reply_text(
                f"⏳ Generazione predizione per {periods} periodi...\n"
                f"Attendere prego..."
            )
            
            # Genera la predizione (mock per dimostrazione)
            prediction_result = self._generate_mock_prediction(periods)
            
            # Formatta e invia i risultati
            result_text = self._format_prediction_result(prediction_result)
            
            await processing_message.edit_text(result_text, parse_mode='Markdown')
            
        except ValueError:
            await update.message.reply_text(
                "⚠️ Errore: inserisci un numero valido.\n"
                "Esempio: /predict 30"
            )
        except Exception as e:
            logger.error(f"Error in predict_command: {e}")
            await update.message.reply_text(
                "❌ Si è verificato un errore durante la generazione della predizione."
            )
    
    async def models_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
        """Handler per il comando /models."""
        models_text = (
            "🤖 *Modelli di Previsione Disponibili:*\n\n"
            "*1. Auto*\n"
            "Selezione automatica del modello migliore\n"
            "Analizza i dati e sceglie l'algoritmo ottimale\n\n"
            "*2. ARIMA*\n"
            "AutoRegressive Integrated Moving Average\n"
            "Ideale per serie temporali stazionarie\n\n"
            "*3. Prophet*\n"
            "Modello sviluppato da Facebook\n"
            "Ottimo per serie con stagionalità\n\n"
            "*4. LSTM*\n"
            "Long Short-Term Memory (Deep Learning)\n"
            "Per pattern complessi e non lineari\n\n"
            "Usa /predict per generare predizioni!"
        )
        await update.message.reply_text(models_text, parse_mode='Markdown')
    
    async def about_command(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
        """Handler per il comando /about."""
        about_text = (
            "ℹ️ *Nostradamus Telegram Bot*\n\n"
            "Questo bot fornisce un'interfaccia conversazionale per "
            "interagire con il sistema di previsione Nostradamus.\n\n"
            "*Funzionalità:*\n"
            "• Generazione di predizioni personalizzate\n"
            "• Visualizzazione di statistiche\n"
            "• Informazioni sui modelli disponibili\n"
            "• Integrazione con il backend Nostradamus\n\n"
            "*Tecnologie:*\n"
            "• Python 3.8+\n"
            "• python-telegram-bot library\n"
            "• Nostradamus framework\n\n"
            "*Sviluppato da:* Federico Ronzi\n"
            "*Licenza:* MIT\n\n"
            "Per supporto: /help"
        )
        await update.message.reply_text(about_text, parse_mode='Markdown')
    
    async def button_callback(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
        """Handler per i callback dei bottoni inline."""
        query = update.callback_query
        await query.answer()
        
        if query.data == 'predict':
            await query.edit_message_text(
                "📊 *Genera Predizione*\n\n"
                "Usa il comando /predict seguito dal numero di periodi.\n\n"
                "Esempio: /predict 30\n\n"
                "Questo genererà una predizione per i prossimi 30 periodi.",
                parse_mode='Markdown'
            )
        elif query.data == 'info':
            await self.info_command(update, context)
        elif query.data == 'help':
            await self.help_command(update, context)
    
    async def handle_text(self, update: Update, context: ContextTypes.DEFAULT_TYPE) -> None:
        """Handler per messaggi di testo generici."""
        text = update.message.text.lower()
        
        if 'predizione' in text or 'previsione' in text:
            await update.message.reply_text(
                "Per generare una predizione usa:\n/predict <numero_periodi>\n\n"
                "Esempio: /predict 30"
            )
        elif 'aiuto' in text or 'help' in text:
            await self.help_command(update, context)
        else:
            await update.message.reply_text(
                "Non ho capito il comando. Usa /help per vedere i comandi disponibili."
            )
    
    def _generate_mock_prediction(self, periods: int) -> Dict:
        """
        Genera una predizione mock per dimostrazione.
        In produzione, questo chiamerebbe il vero backend di Nostradamus.
        
        Args:
            periods: Numero di periodi da predire
            
        Returns:
            Dizionario con i risultati della predizione
        """
        import random
        
        # Genera valori mock usando list comprehension per migliori performance
        base = 100
        predictions = [
            base + (i * 0.5) + ((random.random() - 0.5) * 10)
            for i in range(periods)
        ]
        
        # Calcola statistiche
        mean = sum(predictions) / len(predictions)
        min_val = min(predictions)
        max_val = max(predictions)
        
        return {
            'model': 'auto',
            'periods': periods,
            'predictions': predictions,
            'statistics': {
                'mean': mean,
                'min': min_val,
                'max': max_val,
            },
            'timestamp': datetime.now().isoformat(),
        }
    
    def _format_prediction_result(self, result: Dict) -> str:
        """
        Formatta i risultati della predizione per Telegram.
        
        Args:
            result: Dizionario con i risultati
            
        Returns:
            Stringa formattata in Markdown
        """
        predictions = result['predictions']
        stats = result['statistics']
        
        # Crea un campione dei primi e ultimi valori
        sample_size = min(5, len(predictions))
        first_values = predictions[:sample_size]
        last_values = predictions[-sample_size:] if len(predictions) > sample_size else []
        
        text = (
            f"✅ *Predizione Completata*\n\n"
            f"*Modello:* {result['model']}\n"
            f"*Periodi:* {result['periods']}\n"
            f"*Timestamp:* {result['timestamp'][:19]}\n\n"
            f"*📊 Statistiche:*\n"
            f"• Media: `{stats['mean']:.2f}`\n"
            f"• Minimo: `{stats['min']:.2f}`\n"
            f"• Massimo: `{stats['max']:.2f}`\n\n"
            f"*📈 Primi {sample_size} valori:*\n"
        )
        
        for i, val in enumerate(first_values, 1):
            text += f"T+{i}: `{val:.2f}`\n"
        
        if last_values:
            text += f"\n*📈 Ultimi {sample_size} valori:*\n"
            start_idx = len(predictions) - sample_size + 1
            for i, val in enumerate(last_values, start_idx):
                text += f"T+{i}: `{val:.2f}`\n"
        
        text += "\n_Per vedere tutti i valori, integra con l'API REST._"
        
        return text
    
    def run(self):
        """Avvia il bot."""
        # Crea l'applicazione
        self.application = Application.builder().token(self.token).build()
        
        # Registra gli handler
        self.application.add_handler(CommandHandler("start", self.start_command))
        self.application.add_handler(CommandHandler("help", self.help_command))
        self.application.add_handler(CommandHandler("info", self.info_command))
        self.application.add_handler(CommandHandler("predict", self.predict_command))
        self.application.add_handler(CommandHandler("models", self.models_command))
        self.application.add_handler(CommandHandler("about", self.about_command))
        self.application.add_handler(CallbackQueryHandler(self.button_callback))
        self.application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, self.handle_text))
        
        # Avvia il bot
        logger.info("Bot avviato!")
        self.application.run_polling(allowed_updates=Update.ALL_TYPES)


def main():
    """Funzione principale per avviare il bot."""
    # Leggi il token dalle variabili d'ambiente
    token = os.getenv('TELEGRAM_BOT_TOKEN')
    
    if not token:
        logger.error(
            "ERRORE: TELEGRAM_BOT_TOKEN non trovato!\n"
            "Configura la variabile d'ambiente con il token del tuo bot.\n"
            "Esempio: export TELEGRAM_BOT_TOKEN='your-token-here'"
        )
        sys.exit(1)
    
    # Crea e avvia il bot
    bot = NostradamusBot(token)
    
    try:
        bot.run()
    except KeyboardInterrupt:
        logger.info("Bot fermato dall'utente.")
    except Exception as e:
        logger.error(f"Errore nell'esecuzione del bot: {e}")
        sys.exit(1)


if __name__ == '__main__':
    main()
