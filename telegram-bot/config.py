"""
Configuration module for Nostradamus Telegram Bot
Handles loading and validation of environment variables
"""

import os
from dataclasses import dataclass
from typing import Optional
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()


@dataclass
class BotConfig:
    """Configuration class for the Telegram bot."""
    
    # Required settings
    telegram_token: str
    
    # Optional API settings
    api_base_url: str = 'http://localhost:5000/api'
    api_timeout: int = 10
    
    # Bot behavior settings
    max_prediction_periods: int = 365
    default_prediction_periods: int = 30
    
    # Logging settings
    log_level: str = 'INFO'
    log_file: Optional[str] = 'bot.log'
    
    @classmethod
    def from_env(cls) -> 'BotConfig':
        """
        Create configuration from environment variables.
        
        Returns:
            BotConfig instance
            
        Raises:
            ValueError: If required environment variables are missing
        """
        telegram_token = os.getenv('TELEGRAM_BOT_TOKEN')
        
        if not telegram_token:
            raise ValueError(
                "TELEGRAM_BOT_TOKEN environment variable is required.\n"
                "Get your token from @BotFather on Telegram."
            )
        
        return cls(
            telegram_token=telegram_token,
            api_base_url=os.getenv('API_BASE_URL', 'http://localhost:5000/api'),
            api_timeout=int(os.getenv('API_TIMEOUT', '10')),
            max_prediction_periods=int(os.getenv('MAX_PREDICTION_PERIODS', '365')),
            default_prediction_periods=int(os.getenv('DEFAULT_PREDICTION_PERIODS', '30')),
            log_level=os.getenv('LOG_LEVEL', 'INFO'),
            log_file=os.getenv('LOG_FILE', 'bot.log'),
        )
    
    def validate(self) -> bool:
        """
        Validate configuration values.
        
        Returns:
            True if configuration is valid
            
        Raises:
            ValueError: If configuration values are invalid
        """
        if not self.telegram_token:
            raise ValueError("Telegram token cannot be empty")
        
        if self.max_prediction_periods <= 0:
            raise ValueError("max_prediction_periods must be positive")
        
        if self.default_prediction_periods <= 0:
            raise ValueError("default_prediction_periods must be positive")
        
        if self.default_prediction_periods > self.max_prediction_periods:
            raise ValueError(
                "default_prediction_periods cannot exceed max_prediction_periods"
            )
        
        return True
