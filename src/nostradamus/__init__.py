"""
Nostradamus - A Prediction and Forecasting Framework
=====================================================

Nostradamus is a Python library for time series forecasting and predictive analytics.
It provides a simple and intuitive API for building, training, and deploying
prediction models.

Main Components:
- Predictor: Main class for creating and managing prediction models
- Data: Data loading and preprocessing utilities
- Models: Various forecasting algorithms (ARIMA, Prophet, LSTM, etc.)
- Visualization: Plotting and dashboard utilities

Example:
    >>> from nostradamus import Predictor
    >>> predictor = Predictor(model='auto')
    >>> predictor.fit(data)
    >>> predictions = predictor.predict(periods=30)

For more information, visit: https://github.com/federicoronzi/Nostradamus-
"""

__version__ = '0.1.0'
__author__ = 'Federico Ronzi'
__license__ = 'MIT'

# Import main classes for convenient access
# from .predictor import Predictor
# from .data import load_data, load_sample_data
# from .models import ARIMAModel, ProphetModel

__all__ = [
    '__version__',
    '__author__',
    '__license__',
    # 'Predictor',
    # 'load_data',
    # 'load_sample_data',
]
