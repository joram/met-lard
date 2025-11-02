# Build stage
FROM rust:latest as builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y \
    pkg-config \
    libssl-dev \
    ca-certificates \
    cmake \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Copy workspace files for dependency resolution
COPY Cargo.toml Cargo.lock ./
COPY egress/Cargo.toml ./egress/
COPY util/Cargo.toml ./util/
COPY rove_connector/Cargo.toml ./rove_connector/
COPY ingestion/Cargo.toml ./ingestion/
COPY integration_tests/Cargo.toml ./integration_tests/

# Copy source code (copy all workspace members for cargo workspace resolution)
COPY egress ./egress
COPY util ./util
COPY rove_connector ./rove_connector
COPY ingestion ./ingestion
COPY integration_tests ./integration_tests

# Build the binary
WORKDIR /app
RUN cargo build --release --bin lard_egress

# Runtime stage
FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the binary from builder
COPY --from=builder /app/target/release/lard_egress /usr/local/bin/lard_egress

CMD ["lard_egress"]

