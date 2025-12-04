"""
Setup script for Nostradamus package.
"""
from setuptools import setup, find_packages
import os

# Read the contents of README file
this_directory = os.path.abspath(os.path.dirname(__file__))
with open(os.path.join(this_directory, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

# Read requirements
with open(os.path.join(this_directory, 'requirements.txt'), encoding='utf-8') as f:
    requirements = [line.strip() for line in f if line.strip() and not line.startswith('#')]

setup(
    name='nostradamus',
    version='0.1.0',
    author='Federico Ronzi',
    author_email='',
    description='A prediction and forecasting framework using machine learning',
    long_description=long_description,
    long_description_content_type='text/markdown',
    url='https://github.com/federicoronzi/Nostradamus-',
    project_urls={
        'Bug Tracker': 'https://github.com/federicoronzi/Nostradamus-/issues',
        'Documentation': 'https://github.com/federicoronzi/Nostradamus-',
        'Source Code': 'https://github.com/federicoronzi/Nostradamus-',
    },
    package_dir={'': 'src'},
    packages=find_packages(where='src'),
    classifiers=[
        'Development Status :: 3 - Alpha',
        'Intended Audience :: Developers',
        'Intended Audience :: Science/Research',
        'Topic :: Scientific/Engineering :: Artificial Intelligence',
        'License :: OSI Approved :: MIT License',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',
        'Programming Language :: Python :: 3.11',
    ],
    python_requires='>=3.8',
    install_requires=requirements,
    extras_require={
        'dev': [
            'pytest>=7.0.0',
            'pytest-cov>=3.0.0',
            'black>=22.0.0',
            'flake8>=4.0.0',
            'mypy>=0.950',
        ],
        'docs': [
            'sphinx>=4.4.0',
            'sphinx-rtd-theme>=1.0.0',
        ],
    },
    keywords='forecasting prediction time-series machine-learning data-science',
    include_package_data=True,
    zip_safe=False,
)
