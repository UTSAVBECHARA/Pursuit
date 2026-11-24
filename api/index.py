"""Serverless entrypoint for Pursuit on Vercel and edge platforms."""

from __future__ import annotations

import sys
from pathlib import Path

# Add project root and src/ to sys.path
ROOT_DIR = Path(__file__).resolve().parent.parent
if str(ROOT_DIR) not in sys.path:
    sys.path.insert(0, str(ROOT_DIR))
if str(ROOT_DIR / "src") not in sys.path:
    sys.path.insert(0, str(ROOT_DIR / "src"))

from app.server import app

__all__ = ["app"]
