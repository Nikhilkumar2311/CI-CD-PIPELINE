# CI/CD Flow

1. Developer pushes code
2. CI runs tests
3. Docker image is built
4. Image is pushed to Docker Hub
5. EC2 pulls image
6. Health check validates deployment
7. Traffic switches safely
