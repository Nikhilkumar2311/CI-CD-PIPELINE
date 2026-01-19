# Deployment Architecture

GitHub → GitHub Actions → Docker Hub → EC2

- CI builds immutable Docker images
- Images are versioned using commit SHA
- EC2 pulls images, never builds them
- Deployment uses blue-green style switching
