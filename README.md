# Natural Selection Server Docker

A Docker Compose setup for running a Natural Selection (Half-Life mod) dedicated server.

## Quick Start

```bash
docker-compose up -d
```

Server available on port 27015 (UDP/TCP)

## Configuration

- `config/server.cfg` - Server settings
- `config/mapcycle.txt` - Map rotation
- `config/motd.txt` - Message of the day
- `mods/` - Custom mods (copied during setup)

## Services

- **ns-setup**: Downloads/installs Natural Selection v3.3b9
- **ns-server**: Runs the dedicated server

## Features

- Automatic NS installation with caching
- Metamod configuration
- Custom mod support
- Persistent data storage
