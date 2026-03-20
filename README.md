# grafana-iframe-react

> React sample app for embedding **Grafana dashboards** via iframe with **JWT authentication** — demonstrates Grafana's JWT embed token flow.

[![TypeScript](https://img.shields.io/badge/TypeScript-4.x-3178C6?logo=typescript&logoColor=white)](https://typescriptlang.org)
[![React](https://img.shields.io/badge/React-18-61DAFB?logo=react&logoColor=white)](https://reactjs.org)
[![Grafana](https://img.shields.io/badge/Grafana-JWT_Embed-F46800?logo=grafana&logoColor=white)](https://grafana.com)
[![Docker](https://img.shields.io/badge/Docker-ready-2496ED?logo=docker&logoColor=white)](https://docker.com)

## Overview

This project demonstrates how to embed a Grafana dashboard inside a React application using Grafana's **JWT embedded token** feature. The JWT proxy handles authentication so that users see dashboards without needing a separate Grafana login.

## Architecture

```
React App (this repo)
    └─► iframe src: Grafana URL + JWT token
              └─► Grafana verifies JWT via jwks.json
                      └─► Renders dashboard
```

## Prerequisites

- Node.js 16+
- Yarn
- Grafana with JWT auth enabled
- [jwt-proxy](https://github.com/grafana/grafana/tree/main/devenv/docker/blocks/auth/jwt_proxy) running

## Getting Started

```bash
git clone https://github.com/misoboy/grafana-iframe-react.git
cd grafana-iframe-react

yarn install
yarn start
```

### Docker

```bash
docker build -t grafana-iframe-react .
docker run -p 3000:3000 grafana-iframe-react
```

## Grafana Configuration

Add to `grafana.ini`:

```ini
[auth.jwt]
enabled = true
enable_login_token = true
header_name = X-Forwarded-Access-Token
username_claim = login
email_claim = email
jwk_set_file = devenv/docker/blocks/auth/oauth/jwks.json
cache_ttl = 60m
expected_claims = {"iss": "http://env.grafana.local:8087/auth/realms/grafana", "azp": "grafana-oauth"}
auto_sign_up = true
url_login = true

[security]
allow_embedding = true
```

## Setup Steps

1. Clone Grafana: `git clone https://github.com/grafana/grafana.git`
2. Start jwt-proxy devenv: `make devenv sources="auth/jwt_proxy"`
3. Configure Grafana as above
4. Start this React app and open `http://localhost:3000`

## License

MIT
