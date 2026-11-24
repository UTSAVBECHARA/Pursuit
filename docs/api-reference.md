# Pursuit REST API Reference

The Pursuit platform includes an OpenAPI-compliant REST API serving real-time job exploration, candidate-job matching, and dry-run application simulation.

Interactive API Documentation:
- Swagger UI: `/docs`
- ReDoc: `/redoc`

---

## Endpoints

### 1. Health & Status
#### `GET /api/health`
Checks backend service availability, database connectivity, and engine version.

**Response (200 OK):**
```json
{
  "status": "healthy",
  "version": "1.0.0",
  "platform": "Pursuit",
  "database": "connected",
  "dry_run": true
}
```

---

### 2. Job Discovery & Exploration
#### `GET /api/jobs`
Queries active job opportunities with optional keyword, location, and limit filtering.

**Query Parameters:**
- `query` (string, optional): Search keyword or job title (e.g., `"Python Engineer"`)
- `location` (string, optional): Target city or region (e.g., `"Remote"`, `"London"`)
- `country` (string, optional): Two-letter ISO country code or name (e.g., `"US"`, `"DE"`)
- `limit` (integer, optional, default: `20`): Maximum number of records returned.

**Response (200 OK):**
```json
{
  "total": 1,
  "jobs": [
    {
      "id": "j001",
      "title": "Senior AI Systems Engineer",
      "company": "Anthropic AI",
      "location": "San Francisco, CA (Hybrid)",
      "country": "US",
      "posted_at": "2026-11-20T14:30:00Z",
      "url": "https://jobs.lever.co/anthropic/ai-systems-eng",
      "source": "lever"
    }
  ]
}
```

---

### 3. Intelligent Match & Scoring
#### `POST /api/match`
Evaluates a candidate resume against current job postings using multi-facet semantic decomposition.

**Request Body:**
```json
{
  "resume_text": "Experienced Python Engineer specializing in distributed systems, LLM agents, and cloud automation.",
  "goals": "Staff or Senior backend engineer roles in AI platforms",
  "locations": ["Remote", "New York"]
}
```

**Response (200 OK):**
```json
{
  "candidate_plan": {
    "primary_titles": ["Senior Backend Engineer", "AI Systems Engineer"],
    "key_nodes": [
      {"id": "python", "weight": 1.0},
      {"id": "llm_agents", "weight": 1.2}
    ]
  },
  "matches": [
    {
      "job_id": "j001",
      "title": "Senior AI Systems Engineer",
      "company": "Anthropic AI",
      "score": 4.8,
      "verdict": "High Confidence Match",
      "matched_criteria": ["Python", "AI platforms", "Distributed Systems"]
    }
  ]
}
```

---

### 4. Application Automation Simulation (Dry-Run)
#### `POST /api/apply/simulate`
Simulates autonomous ATS form navigation and verification without submitting live employer data.

**Request Body:**
```json
{
  "job_url": "https://jobs.lever.co/anthropic/ai-systems-eng",
  "resume_id": "cv_001",
  "dry_run": true
}
```

**Response (200 OK):**
```json
{
  "status": "simulation_complete",
  "ats_provider": "lever",
  "fields_identified": 14,
  "fields_synthesized": 14,
  "submission_control_detected": true,
  "submission_executed": false,
  "proof_screenshot": "data/proofs/simulation_lever_j001.png"
}
```
