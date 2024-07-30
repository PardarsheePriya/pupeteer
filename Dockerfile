FROM ghcr.io/puppeteer/puppeteer:latest

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Switch to root to install dependencies
USER root

# Install Node.js dependencies
RUN npm install

# Set correct permissions for the app directory
RUN chown -R pptruser:pptruser /app

# Copy application code
COPY . .

# Switch to non-root user
USER pptruser

# Expose port for the server
EXPOSE 8000

# Start the server (this is optional; you can also run it manually)
CMD ["node", "server.js"]
