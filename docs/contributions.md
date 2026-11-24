# Contributing to Pursuit

Thank you for your interest in contributing to Pursuit! We welcome bug reports, documentation enhancements, new ATS plugin drivers, and feature suggestions.

---

## 1. Code of Conduct & Contribution Standards

- **Quality:** Ensure all code adheres to project formatting (`ruff check` and `ruff format`).
- **Tests:** Any bug fix or new ATS plugin must be accompanied by comprehensive tests in `tests/`.
- **Security:** Never submit credentials, private API keys, or real personal information in issues, test cases, or pull requests.
- **Attribution:** Pursuit honors open-source licensing. Upstream attributions to AIHawk (by feder-cr and contributors) and data contributors (Headcount Labs, OpenStreetMap, Overture Maps, FDE Times) must remain intact.

---

## 2. Development Workflow

1. **Fork or Branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Install Development Dependencies:**
   ```bash
   pip install -e ".[dev]"
   ```

3. **Verify Code Style:**
   ```bash
   ruff check .
   ```

4. **Run Unit & Integration Tests:**
   ```bash
   python -m pytest -v
   ```

5. **Commit Message Guidelines:**
   Use clear, concise imperative commit messages (e.g., `feat(plugins): add support for Greenhouse custom questions`, `fix(scoring): handle empty context split safely`).

6. **Submit a Pull Request:**
   Open a PR against the `main` branch with a description of changes and test verification results.
