# Pursuit Setup & Local Configuration Guide

## 1. Prerequisites

- **Operating System:** Windows 10/11, macOS (12+), or Linux (Ubuntu 22.04+ / Debian 12+)
- **Python:** Python 3.11, 3.12, or 3.13 (Python 3.11+ required)
- **Package Manager:** `pip` or `uv`
- **Git:** Git 2.40+
- **Browser Automation (Optional for real job submissions):** Firefox or Playwright browser runtime

---

## 2. Quickstart Installation

### 2.1 Clone the Repository
```bash
git clone https://github.com/UTSAVBECHARA/Pursuit.git
cd Pursuit
```

### 2.2 Configure Virtual Environment
Create and activate an isolated virtual environment:

**Linux / macOS:**
```bash
python3 -m venv .venv
source .venv/bin/activate
```

**Windows (PowerShell):**
```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

### 2.3 Install Dependencies
Install production dependencies:
```bash
pip install -e .
```

To install development and testing dependencies:
```bash
pip install -e ".[dev]"
```

Alternatively, if using `uv`:
```bash
uv sync --all-extras
```

---

## 3. Environment Configuration

Copy the example environment template:
```bash
cp .env.example .env
```

Edit `.env` to configure your API keys and execution options:

| Variable | Description | Default / Example |
|---|---|---|
| `ORCAROUTER_API_KEY` | API key for LLM query & reasoning gateway | `sk-orca-...` |
| `AIHAWK_DRY_RUN` | Set to `1` to run in trial/simulation mode without submitting real forms | `1` |
| `AIHAWK_TRACE` | Set to `1` to write detailed step-by-step browser interaction logs to `data/trace.log` | `0` |
| `AIHAWK_MODEL` | LLM used for multi-step form completion & screenshot reading | `deepseek/deepseek-v4.1-flash` |
| `AIHAWK_QUICK_MODEL` | Fast LLM for resume planning and schema generation | `google/gemini-3.5-flash` |
| `AIHAWK_DECISION_MODEL`| Model scoring job relevance against candidate profiles | `typesafe/jev-1.14` |
| `PORT` | Local or containerized web service port | `8000` |

---

## 4. Running Pursuit Locally

### 4.1 CLI & Interactive Terminal UI
Launch the interactive terminal UI with your resume:
```bash
pursuit path/to/your_resume.pdf
```
Or with Markdown CV:
```bash
pursuit cv.md
```

### 4.2 Interactive Keyboard Navigation
Within the Pursuit TUI:
- **`j` / `k` or `Down` / `Up`:** Navigate through scored job postings.
- **`Space`:** Select/deselect individual postings for application.
- **`a`:** Apply to selected postings.
- **`d`:** Download the latest chunk deltas from the central database.
- **`s`:** Inspect application spend, token counts, and session stats.
- **`e`:** Edit personal answers, email provider, and candidate preferences.
- **`q`:** Quit application cleanly.

### 4.3 Safe Trial / Dry-Run Verification
To test form filling without sending actual applications to employers:
```powershell
$env:AIHAWK_DRY_RUN="1"
pursuit path/to/resume.pdf
```
On Linux / macOS:
```bash
AIHAWK_DRY_RUN=1 pursuit path/to/resume.pdf
```
Pursuit will navigate to the ATS, identify all input fields, generate synthesized answers, verify the submission button, take a confirmation screenshot, and halt safely.
