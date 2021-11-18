#!/bin/bash

cd /scripts/Utilities-and-Operations-Scripts/
git pull origin master

cd db_utils

echo '* DB Cleanup START * '

python3 cleanup_db_tables.py --config cleanup_db_tables.json

echo '* DB Cleanup DONE *'

