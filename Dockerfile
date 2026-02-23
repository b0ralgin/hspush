# Multi-stage build for hspush server

# Dependencies stage (cache stack deps)
FROM haskell:9.10 AS deps

WORKDIR /app

# Install system dependencies required to build native deps (HsOpenSSL, proto-lens, snappy)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libssl-dev \
    pkg-config \
    protobuf-compiler \
    libsnappy-dev \
    && rm -rf /var/lib/apt/lists/*

# Cache dependency layers (only manifests)
COPY stack.yaml stack.yaml
COPY stack.yaml.lock stack.yaml.lock
COPY package.yaml package.yaml
COPY hspush.cabal hspush.cabal

# Build dependencies only (cached unless manifests change)
RUN stack build --only-dependencies

# Build stage
FROM deps AS builder

# Copy source
COPY . .

# Build server executable
RUN stack build --copy-bins && \
    ls -la /root/.local/bin

# Runtime stage (bullseye provides libssl1.1)
FROM debian:bullseye-slim

# Install runtime deps (openssl, ghc-linked libs, snappy)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    libssl1.1 \
    libtinfo6 \
    libgmp10 \
    zlib1g \
    libsnappy1v5 \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m appuser
USER appuser

WORKDIR /app

# Copy executable from builder
COPY --from=builder /root/.local/bin/hspush-server /usr/local/bin/hspush-server

# Default envs; override at runtime
ENV HSPUSH_SQLITE_DB=/app/file.db \
    HSPUSH_GOOGLE_SECRETS_FILE=/app/google_secrets.json \
    HSPUSH_GOOGLE_ID=project-id \
    HSPUSH_GRPC_PORT=50051

# Expose gRPC port
EXPOSE 50051

# Healthcheck: check TCP port opens
HEALTHCHECK CMD /bin/sh -c "nc -z localhost ${HSPUSH_GRPC_PORT} || exit 1"

# Entrypoint
CMD ["/usr/local/bin/hspush-server"]
