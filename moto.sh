#!/usr/bin/env bash

MODE=${MODE:-dump}

source venv/bin/activate
python -m moto $MODE
