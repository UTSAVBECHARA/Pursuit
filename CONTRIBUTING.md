# Contributing to Pursuit

Pursuit is an autonomous, AI-driven job discovery, multi-facet candidate matching, and automated application platform. The most useful contribution is a plugin for a job site: a Markdown file that instructs the LLM and browser automation on how that site's application form operates. You can write one by following [docs/plugins.md](docs/plugins.md).

For detailed contribution guidelines, code formatting standards, and PR protocols, refer to [docs/contributions.md](docs/contributions.md).

---

## 1. Setup & Environment

Python 3.11 or newer is required.

```bash
git clone https://github.com/UTSAVBECHARA/Pursuit.git
cd Pursuit
python -m venv .venv
# On Windows:
.\.venv\Scripts\Activate.ps1
# On Linux / macOS:
source .venv/bin/activate

pip install -e ".[dev]"
pursuit --help
```

The installation brings in `invisible-playwright-mcp`. Running Pursuit in production requires an OrcaRouter or OpenAI-compatible API key. The unit tests require neither: they use comprehensive fakes (`tests/fakes.py`) and make no external network calls.

Pursuit maintains user workspace state in `~/.aihawk` or `~/.pursuit` (`%USERPROFILE%\.aihawk` on Windows).

---

## 2. Running Tests

```bash
pytest -m "not browser"     # unit tests: no browser, no external network calls
pytest -m browser           # browser integration on a local mock form
```

The browser tests run `invisible-playwright-mcp` and its headless Firefox against a local mock form served from `127.0.0.1` (e.g., `tests/sites/workday_local.py`). On Linux without a graphical display, run under `xvfb-run -a`, as CI does.

---

## 3. Linting & Formatting

```bash
ruff check .
```

Ruff settings are configured in `[tool.ruff]` in `pyproject.toml`.

---

## 4. Continuous Integration Workflows

The primary workflow is `.github/workflows/tests.yml`. It runs on every push and pull request to `main`:
- **unit**, testing across Ubuntu, Windows, and macOS on Python 3.11, 3.12, and 3.13.
- **browser**, running headless browser verification under `xvfb-run`.
- **gate**, verifying quality gates before merging.
