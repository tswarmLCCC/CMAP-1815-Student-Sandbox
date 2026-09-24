FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install PostgreSQL 16 server, contrib, and client from official PostgreSQL apt repository
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends \
        lsb-release \
        curl \
        ca-certificates \
        gnupg \
    && echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-16 \
        postgresql-contrib-16 \
        postgresql-client-16 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
