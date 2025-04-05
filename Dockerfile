# Base image
FROM python:3.11-slim

# Set env vars
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set workdir
WORKDIR /app

# Install system deps (includes curl + build tools + postgres libs)
RUN apt-get update && apt-get install -y \
    build-essential libpq-dev curl gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install npm deps
COPY package*.json ./
#RUN npm install

# Copy project files
COPY . .

# Build Tailwind CSS
#RUN npm run build

# Copy entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Run the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]