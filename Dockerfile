FROM --platform=$BUILDPLATFORM debian:stable-slim

ARG TARGETPLATFORM
ARG BUILDPLATFORM

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy setup script
COPY setup.sh .

# Download and extract the appropriate binary based on architecture
RUN chmod +x setup.sh && ./setup.sh

# Expose ports
# Port 20000 - Main node port
# Port 10500 - gRPC port
EXPOSE 20000 10500

# Run the node with the specified parameters
CMD ["./rubixgoplatform", "run", "-s", "-testNet", "-defaultSetup", "-p", "node0", "-n", "0", "-grpcPort", "10500", "-addr", "0.0.0.0", "-grpcAddr", "0.0.0.0"]

