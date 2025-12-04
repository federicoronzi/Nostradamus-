"""
Tests for the Nostradamus package.
"""
import pytest
import sys
import os

# Add src directory to path for imports
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../src')))


def test_package_import():
    """Test that the package can be imported."""
    import nostradamus
    assert nostradamus.__version__ == '0.1.0'
    assert nostradamus.__author__ == 'Federico Ronzi'
    assert nostradamus.__license__ == 'MIT'


def test_package_metadata():
    """Test package metadata is correct."""
    import nostradamus
    assert hasattr(nostradamus, '__version__')
    assert hasattr(nostradamus, '__author__')
    assert hasattr(nostradamus, '__license__')
