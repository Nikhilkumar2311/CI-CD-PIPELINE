# System Architecture

This project demonstrates an end-to-end CI/CD pipeline with monitoring and logging using modern DevOps tooling.

## Components

### Application

- **Node.js HTTP server**
- Exposes:
  - `/` → application response
  - `/health` → health check endpoint
- Runs inside a Docker container

### Monitoring Stack

- **Prometheus**
  - Scrapes application metrics
  - Evaluates alert rules
- **Grafana**
  - Visualizes metrics and logs
  - Uses provisioning for datasources and dashboards
- **Loki**
  - Centralized log storage
- **Promtail**
  - Ships Docker container logs to Loki

### CI/CD

- **GitHub Actions**
  - Build & test on every push
  - Build Docker image
  - Push image to registry
  - Deploy to server (EC2)

## Architecture Flow

1. User hits Node.js app
2. App exposes metrics & logs
3. Prometheus scrapes metrics
4. Promtail ships logs to Loki
5. Grafana visualizes metrics + logs
6. Alerts trigger via Prometheus rules

## Key Design Decisions

- Docker-first setup for portability
- Infrastructure as Code mindset
- Monitoring baked into application lifecycle
