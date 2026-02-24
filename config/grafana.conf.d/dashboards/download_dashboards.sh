#!/bin/bash
# Download/update Grafana dashboards from grafana.com
# Usage: bash download_dashboards.sh

DASHBOARDS_DIR="$(dirname "$0")/dashboardList"
mkdir -p "$DASHBOARDS_DIR"

# Dashboard IDs and local filenames
declare -A DASHBOARDS=(
    ["ca1-14282.json"]="14282"   # cAdvisor
    ["ne1-1860.json"]="1860"     # Node Exporter Full
    ["pg1-9628.json"]="9628"     # PostgreSQL Database
)

for filename in "${!DASHBOARDS[@]}"; do
    id="${DASHBOARDS[$filename]}"
    echo "Downloading dashboard $id -> $filename"
    curl -s \
        "https://grafana.com/api/dashboards/${id}/revisions/latest/download" \
        -o "$DASHBOARDS_DIR/$filename"
done

echo "Done. Downloaded ${#DASHBOARDS[@]} dashboards."
echo ""
echo "Note: pg2-diego.json is a custom dashboard, not downloaded."
