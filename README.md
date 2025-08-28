# Natural Selection 3.3b9 HLDS Server (Docker)

This repo contains a ready-to-run Docker setup for hosting a **Natural Selection v3.3b9 (ENSL)** server.

## Usage

1. **Clone this repo:**
   ```bash
   git clone https://github.com/guillermobr/ns-server-docker
   cd ns-server-docker
   ```

2. **Start the setup (downloads NS mod once):**
   ```bash
   docker compose up ns-setup
   ```

3. **Start the server:**
   ```bash
   docker compose up -d ns-server
   ```

4. **Join your server:**
   ```
   connect <your-ip>:27015
   ```

## Requirements

- Docker
- Docker Compose

## Configuration

Edit the configuration files as needed before starting the server.
