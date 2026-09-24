#!/bin/bash
set -e

echo "======================================================================"
echo "  CMAP 1815: Resetting Database to Clean Starter State..."
echo "======================================================================"

echo ">>> Ensuring PostgreSQL 16 service is running..."
sudo service postgresql start

echo ">>> Waiting for PostgreSQL service to accept connections..."
for i in {1..15}; do
    if sudo -u postgres pg_isready -q; then
        break
    fi
    sleep 1
done

echo ">>> Dropping existing tables and rebuilding schema..."
if [ -f "datasets/setup_chap1.sql" ]; then
    psql -d cmap1815 -f datasets/setup_chap1.sql
    echo ""
    echo "✅ SUCCESS! Database has been reset to clean starter state."
    echo "   All clean tables (locations, employees, products, orders, order_lines) are ready."
    echo "   Your .sql query files in the units/ folders were NOT touched."
else
    echo "❌ Error: datasets/setup_chap1.sql not found!"
    exit 1
fi
