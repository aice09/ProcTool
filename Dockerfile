# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y \
    ca-certificates \
    curl \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Copy necessary files into the container
COPY . .

# Build arguments for metadata
ARG IMAGE_CREATED
ARG IMAGE_REVISION

# Set metadata labels
LABEL org.opencontainers.image.created=$IMAGE_CREATED
LABEL org.opencontainers.image.revision=$IMAGE_REVISION
LABEL org.opencontainers.image.source="https://github.com/aice09/ProcTool"
LABEL org.opencontainers.image.title="ProcTool"
LABEL org.opencontainers.image.url="https://github.com/aice09/ProcTool"
LABEL org.opencontainers.image.version="master"

# Build the Docker image
RUN --mount=type=cache,target=/tmp/cache \
    docker buildx build \
    --cache-from type=gha \
    --cache-to type=gha,mode=max \
    --iidfile /tmp/docker-actions-toolkit-Tq0TqY/iidfile \
    --tag ghcr.io/aice09/proctool:master \
    --push .

# Example of how to set build arguments during the build process
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF

# Example of setting environment variables
ENV ENVIRONMENT=production

# Example of setting up health checks
# HEALTHCHECK --interval=5m --timeout=3s \
#   CMD curl -f http://localhost/ || exit 1

# Example of defining volumes
# VOLUME /data

# Clean up unnecessary files if needed
# RUN rm -rf /tmp/*

# Set the default command to run when the container starts
# CMD [""]

# Provide instructions for using the Dockerfile
