FROM php:8.3-cli

# pdo_mysql: database access. intl: Unicode-aware text handling.
# (mbstring and json ship with the official image.)
RUN apt-get update \
    && apt-get install -y --no-install-recommends git unzip libicu-dev \
    && docker-php-ext-install pdo_mysql intl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# The container runs as the host user (see compose.yaml), so Composer
# needs a writable home that is not /root.
ENV COMPOSER_HOME=/tmp/composer

WORKDIR /app
