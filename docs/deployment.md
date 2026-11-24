# Pursuit Cloud Deployment & Production Guide

## 1. Production Architecture Overview

Pursuit is designed for flexible deployment across containerized environments, cloud platforms, and serverless infrastructure:

1. **Web Service & REST API Layer:** Fast, asynchronous FastAPI interface exposing endpoints for resume matching, job search, application simulation, and system health checks.
2. **Analytical Storage Subsystem:** Embedded DuckDB engine with persistent local volume or cloud-synced Parquet dataset cache.
3. **Autonomous Browser Automation:** Headless Firefox / Playwright execution container managed via Model Context Protocol (`invisible-playwright-mcp`).

---

## 2. Docker Containerization

Pursuit provides a production-grade multi-stage `Dockerfile` and `docker-compose.yml` for automated deployment on Railway, Render, Fly.io, AWS ECS, or any standard OCI container runtime.

### 2.1 Building the Container Image
```bash
docker build -t pursuit:latest .
```

### 2.2 Running with Docker Compose
```bash
docker compose up -d
```

The container starts with:
- Dedicated unprivileged user (`appuser`).
- Health check monitoring via `/api/health`.
- Persistent volume mount for local cache (`/app/data`).

---

## 3. Cloud Deployment Options

### 3.1 Railway / Render (Recommended for Full Agent & Automation)
Render and Railway provide full background worker and headless browser support:
1. Connect your GitHub repository: `https://github.com/UTSAVBECHARA/Pursuit`.
2. Configure **Environment Variables**:
   - `ORCAROUTER_API_KEY`: Your LLM routing API key.
   - `AIHAWK_DRY_RUN`: `1` (Safe trial execution).
   - `PORT`: `8000` (or platform default `$PORT`).
3. Set **Build Command**: `pip install -e .` (or use Dockerfile).
4. Set **Start Command**: `uvicorn app.server:app --host 0.0.0.0 --port $PORT`
5. Configure Health Check Endpoint: `/api/health`.

### 3.2 Vercel / Serverless Deployment (API & Explorer Interface)
For lightweight serverless deployment of the search and matching engine:
- Deploy via Vercel CLI: `npx vercel deploy --prod`
- Vercel automatically routes requests via the Python serverless runtime (`api/index.py`).

---

## 4. Production Environment Checklist

Before deploying live to production, verify:
- [x] `ORCAROUTER_API_KEY` is securely injected via cloud environment secrets (never committed to repository).
- [x] `AIHAWK_DRY_RUN=1` is active for trial/staging deployments to prevent unintended job submissions.
- [x] HTTPS is enforced at the edge/load balancer.
- [x] Ephemeral storage volumes are attached to `/app/data` to cache DuckDB deltas between deployments.
- [x] CORS policies are restricted to authorized frontend origins.
