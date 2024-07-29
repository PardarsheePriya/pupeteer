# Use the official Node.js image.
FROM node:18

# Install dependencies required for Puppeteer and curl
RUN apt-get update && \
    apt-get install -y \
    libnss3 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libcups2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libasound2 \
    libpangocairo-1.0-0 \
    libcairo2 \
    libpango-1.0-0 \
    libgdk-pixbuf2.0-0 \
    libgtk-3-0 \
    libgbm1 \
    libpangoft2-1.0-0 \
    libnss3-tools \
    libxtst6 \
    libxshmfence1 \
    xauth \
    x11-apps \
    curl # Ensure curl is installed

# Create and set the working directory inside the container.
WORKDIR /app

# Copy package.json and package-lock.json to the container.
COPY package*.json ./

# Install the dependencies.
RUN npm install

# Copy the rest of the application files to the container.
COPY . .

# Health check to verify the server is running.
HEALTHCHECK --interval=30s --timeout=10s --retries=3 CMD curl -f http://localhost:8000/health || exit 1

# Copy the start script and set it as the entry point
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Command to run the start script.
CMD ["/app/start.sh"]