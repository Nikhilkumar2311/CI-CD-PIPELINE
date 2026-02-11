# 🚀 CI/CD Pipeline Automation

## 📌 Project Overview

This project demonstrates the design and implementation of a **production-style CI/CD pipeline** using **GitHub Actions**, **Docker**, and **AWS EC2**.

The goal of this repository is to showcase:

- Automated code validation
- Containerized application delivery
- Infrastructure-aware deployments
- Real-world CI/CD problem solving

---

<img width="2074" height="5021" alt="Image" src="https://github.com/user-attachments/assets/9dc0f9e5-712d-4a70-b834-05de88f32cda" />

---

## 🛠 Tech Stack

- **CI/CD:** GitHub Actions
- **Containerization:** Docker
- **Cloud Platform:** AWS EC2
- **Runtime:** Node.js 18
- **OS:** Ubuntu (GitHub-hosted runners & EC2)

---

## ⚙️ CI/CD Workflow

The pipeline is triggered automatically on:

- Every push to the `main` branch
- Every pull request

### Current Pipeline Stages

1. Checkout repository code
2. Set up runtime environment
3. Install dependencies
4. Run automated tests

---

## 🧪 Testing Strategy

- Tests are designed to be **CI-friendly**
- All test commands terminate explicitly using exit codes
- Long-running processes are intentionally excluded from CI steps

This ensures reliable and predictable pipeline execution.

---

## 🐳Containerization

- Application is fully containerized using Docker
- Production-optimized Dockerfile with minimal base image
- Docker image builds are validated inside CI
- Ensures environment consistency across development and CI

---

## 📝Image Registry & Versioning

- Docker images are built and pushed automatically via CI
- Images are published to Docker Hub
- Each build is tagged using both `latest` and commit SHA
- Enables traceability, rollback, and reproducible deployments

---

## 🔁Automated Deployment

- Docker images are deployed automatically to AWS EC2
- CI connects securely via SSH
- EC2 pulls versioned images from Docker Hub
- Containers are replaced on each deployment
- No manual server intervention required

---

## ❤️‍🩹 Health Checks (Current)

- Application exposes a `/health` endpoint
- Used to validate container readiness post-deployment
- Enables future rollback and zero-downtime strategies

---

## 🔄 Rollback Strategy (Planned)

- Automatic rollback on failed health checks is planned
- Will be implemented using versioned Docker image tags
- Previous stable image will be restored on failure

---

## 📊 Monitoring & Observability

<img width="3343" height="1516" alt="Image" src="https://github.com/user-attachments/assets/a1c895d9-c0a1-4875-a90e-8615fc77f171" />

This project includes a full monitoring and logging stack:

### Metrics

- **Prometheus** scrapes application metrics
- Alert rules can be defined for availability and performance

### Logs

- **Promtail** collects Docker container logs
- **Loki** stores and indexes logs centrally

### Visualization

- **Grafana** dashboards for:
  - Application metrics
  - Container health
  - Centralized logs

Monitoring is deployed alongside the application using Docker Compose.

---

## 🏗 Infrastructure as Code (Terraform)

The project uses **Terraform** to provision and manage AWS infrastructure in a reproducible and version-controlled manner.

### Provisioned Resources

- Custom **VPC** with defined CIDR range
- **Public Subnet** with Internet Gateway and routing
- **Security Groups** with explicit inbound/outbound rules
- **EC2 instance** running Ubuntu
- **Elastic IP** for stable public access
- Automated **Docker installation** using EC2 user-data

All infrastructure is defined declaratively and can be recreated consistently using Terraform.

Infrastructure changes are applied manually to maintain safety and prevent accidental production impact.

> Terraform state is currently managed locally and can be migrated to a remote backend (S3 + DynamoDB) as the project scales.

---

## 🧩 Infrastructure Design Decisions

- Terraform is used only for **infrastructure provisioning**, not application deployment
- Application deployment is handled via CI/CD to maintain separation of concerns
- Terraform is executed manually instead of auto-applied in CI to avoid unintended infrastructure changes
- Elastic IP is used to ensure stable deployment targets for CI/CD pipelines

## 🧠 Engineering Considerations

### CI Job Termination

A key consideration in this project is ensuring that CI steps:

- Complete execution automatically
- Exit with clear success or failure status codes

Long-running services are separated from CI validation steps to prevent pipeline hangs.

---

## 🔐 Security Practices

- Secrets are managed using **GitHub Secrets**
- No credentials or sensitive values are committed to the repository
- Environment variables are documented using example files only

---

## 🎯 Why This Project

This project focuses on **clarity, reliability, and real-world engineering decisions**, not just implementation.

It demonstrates:

- CI/CD automation for containerized applications
- Infrastructure provisioning using Terraform
- Safe separation between application delivery and infrastructure management
- Monitoring, observability, and production-aware deployment patterns
