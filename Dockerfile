# ==============================================================================
# PilotApplyer Production Dockerfile
# ==============================================================================
FROM python:3.12-slim as base

# Prevents Python from writing pyc files and buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH="/app/src:/app" \
    PORT=8000 \
    AIHAWK_DRY_RUN=1

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration and dependency specifications
COPY pyproject.toml README.md LICENSE NOTICE ./

# Copy application source code
COPY src/ ./src/
COPY app/ ./app/
COPY api/ ./api/
COPY pipeline/ ./pipeline/

# Install dependencies and package in editable mode
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -e . && \
    pip install --no-cache-dir "fastapi>=0.115.0" "uvicorn>=0.30.0"

# Create unprivileged user for secure execution
RUN useradd -m -u 1001 appuser && \
    mkdir -p /app/data && \
    chown -R appuser:appuser /app

USER appuser

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/api/health || exit 1

CMD ["sh", "-c", "uvicorn app.server:app --host 0.0.0.0 --port ${PORT:-8000}"]
