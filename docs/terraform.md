# 🏗 Infrastructure as Code with Terraform

## 📌 Overview
This project uses **Terraform** to provision and manage AWS infrastructure in a **reproducible, version-controlled, and production-aware** manner.

Terraform is responsible **only for infrastructure provisioning**.  
Application build, containerization, and deployment are handled separately via CI/CD.

---

## 🎯 Goals of Using Terraform
- Eliminate manual AWS Console configuration
- Ensure infrastructure consistency across recreations
- Enable safe and repeatable provisioning
- Treat infrastructure as versioned code
- Reduce configuration drift

---

## 🧱 Provisioned Infrastructure

Terraform provisions the following AWS resources:

### Networking
- Custom **VPC** with defined CIDR range
- **Public Subnet** in a specific availability zone
- **Internet Gateway** for outbound internet access
- **Route Table** with public routing
- Explicit **Route Table Association**

### Compute
- **EC2 instance** running Ubuntu
- Instance launched inside the custom VPC
- Instance attached to the public subnet
- Automated bootstrapping using EC2 user-data

### Security
- **Security Group** with explicit inbound rules for:
  - SSH (22)
  - Application port (3000)
  - Monitoring services (Grafana, Prometheus, Loki)
- Unrestricted outbound traffic (egress)

### Networking Stability
- **Elastic IP** associated with the EC2 instance
- Ensures a stable public IP across instance recreation
- Prevents CI/CD pipeline breakage due to IP changes

---

## 🐳 Server Bootstrapping (User Data)

EC2 instances are automatically configured at first boot using **user-data**.

### Automated setup includes:
- OS package updates
- Docker installation
- Docker service enablement
- Non-root Docker access for the `ubuntu` user

This ensures:
- No manual SSH setup
- Immutable, self-configuring servers
- Faster and safer instance replacement

---