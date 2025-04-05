#!/bin/bash
set -e

echo "📦 Running DB migrations..."
python manage.py migrate --noinput

echo "🎯 Collecting static files..."
python manage.py collectstatic --noinput

echo "🎨 Building Tailwind CSS..."
#npm run build

echo "🚀 Starting Gunicorn..."
exec gunicorn rwebley_newsite.wsgi:application \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --timeout 120
  
"$@"
