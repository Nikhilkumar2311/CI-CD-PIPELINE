# EC2 Setup

- Instance type: t2.micro
- OS: Ubuntu 22.04 LTS
- Docker installed and enabled
- User added to docker group

Ports:
- 22: SSH
- 3000: Application traffic

EC2 only runs containers.
All builds happen in CI.