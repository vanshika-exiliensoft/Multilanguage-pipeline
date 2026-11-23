# Select language and version
ARG LANGUAGE=nodejs
ARG VERSION=22

# Language-specific runtime images
FROM node:${VERSION}-alpine AS nodejs
FROM python:${VERSION}-slim AS python
FROM eclipse-temurin:${VERSION}-jre AS java
FROM php:${VERSION}-cli-alpine AS php

# Composer binary for Php dependencies
FROM composer:2 AS composer-bin

# Select the required runtime
FROM ${LANGUAGE} AS application

WORKDIR /app

# Make Composer available for Php applications
COPY --from=composer-bin /usr/bin/composer /usr/bin/composer

# Copy application source code
COPY . .

# Select dependency installation based on language
ARG LANGUAGE

RUN set -e; \
    if [ "$LANGUAGE" = "nodejs" ]; then \
        npm ci --omit=dev; \
    elif [ "$LANGUAGE" = "python" ]; then \
        if [ -f requirements.txt ]; then \
            pip install --no-cache-dir -r requirements.txt; \
        fi; \
    elif [ "$LANGUAGE" = "php" ]; then \
        if [ -f composer.json ]; then \
            composer install --no-dev --prefer-dist --no-interaction --optimize-autoloader; \
        fi; \
    elif [ "$LANGUAGE" = "java" ]; then \
        echo "Using prebuilt Java application"; \
    else \
        echo "Unsupported language: $LANGUAGE"; \
        exit 1; \
    fi

# Application configuration
ARG START_COMMAND

ENV START_COMMAND="${START_COMMAND}"
ENV PORT=8080

EXPOSE 8080

# Start the selected application
CMD ["sh", "-c", "exec $START_COMMAND"]
