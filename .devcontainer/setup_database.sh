#!/bin/bash
set -e

echo ">>> Configuring Git directory trust..."
git config --global --add safe.directory '*'

echo ">>> Starting PostgreSQL 16 service..."
sudo service postgresql start

echo ">>> Waiting for PostgreSQL service to accept connections..."
for i in {1..30}; do
    if sudo -u postgres pg_isready -q; then
        break
    fi
    sleep 1
done

echo ">>> Initializing database role and sandbox..."
sudo -u postgres psql -tc "SELECT 1 FROM pg_roles WHERE rolname = 'vscode'" | grep -q 1 || sudo -u postgres createuser -s vscode
sudo -u postgres psql -tc "SELECT 1 FROM pg_database WHERE datname = 'cmap1815'" | grep -q 1 || sudo -u postgres createdb -O vscode cmap1815

echo ">>> Seeding starter dataset (setup_chap1.sql)..."
if [ -f "datasets/setup_chap1.sql" ]; then
    psql -d cmap1815 -f datasets/setup_chap1.sql
    echo ">>> Database seeded successfully: locations, employees, products, orders, order_lines."
fi

echo "======================================================================"
echo "  CMAP 1815: Modern SQL Student Sandbox Ready!"
echo "  • Terminal: type 'psql' to open the interactive SQL shell."
echo "  • Visual GUI: click the Database icon on the left sidebar (SQLTools)."
echo "======================================================================"
