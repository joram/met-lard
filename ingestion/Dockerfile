# Build stage
FROM rust:1.82-slim as builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    ca-certificates \
    librdkafka-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy workspace files
COPY Cargo.toml Cargo.lock ./
COPY ingestion/Cargo.toml ./ingestion/
COPY util/Cargo.toml ./util/
COPY rove_connector/Cargo.toml ./rove_connector/

# Copy source code
COPY ingestion ./ingestion
COPY util ./util
COPY rove_connector ./rove_connector

# Build the binary
WORKDIR /app
RUN cargo build --release --bin lard_ingestion

# Runtime stage
FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    librdkafka1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the binary from builder
COPY --from=builder /app/target/release/lard_ingestion /usr/local/bin/lard_ingestion

CMD ["lard_ingestion"]

