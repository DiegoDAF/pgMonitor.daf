# pgMonitor.daf

```
  _____          _                        __  __             _ _             _
 |  __ \        | |                      |  \/  |           (_) |           (_)
 | |__) |__  ___| |_ __ _ _ __ ___  ___  | \  / | ___  _ __  _| |_ ___  _ __ _ _ __   __ _
 |  ___/ _ \/ __| __/ _` | '__/ _ \/ __| | |\/| |/ _ \| '_ \| | __/ _ \| '__| | '_ \ / _` |
 | |  | (_) \__ \ || (_| | | |  __/\__ \ | |  | | (_) | | | | | || (_) | |  | | | | | (_| |
 |_|   \___/|___/\__\__, |_|  \___||___/ |_|  |_|\___/|_| |_|_|\__\___/|_|  |_|_| |_|\__, |
                     __/ |                                                            __/ |
                    |___/                                                            |___/
```

An all-inclusive monitoring tool for PostgreSQL.

## Features

- Runnable in Docker
- Keep it simple
- Uses pgscv instead of postgres_exporter

## Stack

- Prometheus
- Grafana
- pgscv (PostgreSQL metrics collector)
- node_exporter
- cadvisor

## Project Structure

```
pgMonitor.daf/
├── pgmonitor.daf.yaml           # Docker compose principal (includes)
├── runme.sh                     # Script para levantar el stack
├── network.d/
│   └── localprom.yaml           # Red bridge para comunicacion interna
├── volumes.d/
│   ├── prometheus-vol.yaml      # Volumen externo prometheus-data
│   └── grafana-vol.yaml         # Volumen externo grafana-data
├── config/
│   ├── prometheus.yaml          # Config de Prometheus (scrape targets)
│   └── grafana.conf.d/          # Configs de Grafana (datasources, dashboards)
├── services.d/
│   ├── prometheus.yaml          # Servicio Prometheus
│   ├── grafana.yaml             # Servicio Grafana
│   ├── node_exporter.yaml       # Metricas del host
│   ├── cadvisor.yaml            # Metricas de containers
│   └── pgscv-*.yaml             # Metricas de PostgreSQL (pgscv)
└── secrets/
    └── *.conn                   # Connection strings (gitignored)
```

## Step by Step

1. Create docker volumes:
```bash
docker volume create --driver local --opt type=none --opt device=/path/to/prometheus-data --opt o=bind prometheus-data
docker volume create --driver local --opt type=none --opt device=/path/to/grafana-data --opt o=bind grafana-data
```

2. Configure your PostgreSQL connections in `secrets/*.conn`

3. Start the stack:
```bash
bash runme.sh
```

4. Access:
   - Prometheus: http://localhost:9090
   - Grafana: http://localhost:3000 
