# Rubix Node Docker Setup

Docker setup for running a Rubix node with multi-architecture support (ARM64 and AMD64).

## Features

- Multi-architecture support (linux/amd64 and linux/arm64)
- Persistent data storage using Docker volumes
- Exposes ports 20000 (main node) and 10500 (gRPC)
- Automatic restart on failure

## Quick Start

### Using Docker Compose (Recommended)

```bash
# Build and start the node
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the node
docker-compose down

# Stop and remove volumes (WARNING: deletes all node data)
docker-compose down -v
```

### Using Docker CLI

```bash
# Build the image
docker build --platform linux/amd64 -t rubix-node .
# or for ARM64
docker build --platform linux/arm64 -t rubix-node .

# Run the container
docker run -d \
  --name rubix-node0 \
  -p 20000:20000 \
  -p 10500:10500 \
  -v rubix-data:/app/DATA \
  rubix-node

# View logs
docker logs -f rubix-node0

# Stop the container
docker stop rubix-node0
```

## Building Multi-Architecture Images

To build and push multi-architecture images to a registry:

```bash
# Create and use a new builder
docker buildx create --name multiarch --use

# Build for multiple platforms
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t your-registry/rubix-node:latest \
  --push .
```

## Ports

- **20000**: Main Rubix node port
- **10500**: gRPC port

## Data Persistence

Node data is stored in a Docker volume named `rubix-data` to prevent data loss. To backup or inspect the data:

```bash
# Inspect volume
docker volume inspect rubix-data

# Backup volume
docker run --rm -v rubix-data:/data -v $(pwd):/backup ubuntu tar czf /backup/rubix-backup.tar.gz -C /data .

# Restore volume
docker run --rm -v rubix-data:/data -v $(pwd):/backup ubuntu tar xzf /backup/rubix-backup.tar.gz -C /data
```

## Configuration

The node runs with the following parameters:
- `-s`: Start server
- `-testNet`: Connect to test network
- `-defaultSetup`: Use default setup
- `-p node0`: Peer name
- `-n 0`: Node number
- `-grpcPort 10500`: gRPC port

To modify these parameters, edit the `CMD` line in the [Dockerfile](Dockerfile).

## Troubleshooting

### View container logs
```bash
docker-compose logs -f rubix-node
```

### Enter the container
```bash
docker exec -it rubix-node0 /bin/bash
```

### Check node version
```bash
docker exec rubix-node0 ./rubixgoplatform -v
```

### Rebuild after changes
```bash
docker-compose up -d --build
```
