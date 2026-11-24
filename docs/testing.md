# Pursuit Testing & Quality Assurance Guide

## 1. Testing Philosophy & Architecture

Pursuit maintains a test suite ensuring regression resistance across:
1. **Candidate Profile & Plan Extraction (`test_answers.py`)**: Tests resume ingestion, encrypted credential sealing/unsealing, and YAML import mechanics.
2. **LLM Scoring & Decision Routing (`test_scoring.py`, `test_scoring_round.py`)**: Verifies batching, token limits, retry strategies, and score computation across `jev-1.14`.
3. **ATS Plugin Drivers & Web Form Parsing (`test_plugins.py`, `test_liveness.py`)**: Tests 17+ ATS vendors (Workday, Greenhouse, Lever, Ashby, BambooHR) with mocked network layers.
4. **Error Handling & Masking (`test_errors.py`)**: Confirms API tokens and sensitive credentials are never written to stdout or logs.
5. **Session Economics & Spend (`test_spend.py`)**: Tests token usage calculation, cache savings, and real-time cost estimation.

---

## 2. Test Execution

### 2.1 Running the Full Test Suite
```bash
python -m pytest
```

### 2.2 Verbose Execution with Timings
```bash
python -m pytest -v --durations=10
```

### 2.3 Running Specific Subsystem Tests
Run core scoring and credential security tests:
```bash
python -m pytest tests/test_answers.py tests/test_scoring.py tests/test_errors.py -v
```

Run ATS plugin and liveness validation:
```bash
python -m pytest tests/test_plugins.py tests/test_liveness.py -v
```

Run browser integration tests (requires real browser MCP server):
```bash
python -m pytest -m browser
```

---

## 3. Mocking & Local Test Fixtures

- **Local Workday Server (`tests/sites/workday_local.py`)**: Provides a complete local HTTP fixture simulating Workday's multi-step job application, sign-in, account creation, and honeypot detection without hitting external networks.
- **HTTP Transport Mocking (`tests/fakes.py`)**: Custom `httpx.MockTransport` interceptors simulate latency, HTTP 429 rate limits, 503 service outages, and token quota exhaustion.
- **Memory Store Fixtures (`tests/conftest.py`)**: Temporary SQLite and DuckDB directories generated per test isolation, guaranteeing zero state leakage.
