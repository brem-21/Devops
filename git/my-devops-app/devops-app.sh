#!/bin/bash
# Deployment script for DevOps app

echo "Starting deployment..."

# Navigate to web directory
cd /var/www/html

# Pull latest changes
echo "Pulling latest changes from GitHub..."
sudo git pull origin main

# Set permissions
echo "Setting permissions..."
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# Restart Nginx
echo "Restarting Nginx..."
sudo systemctl restart nginx

echo "Deployment complete!"
echo "Visit http://$(curl -s ifconfig.me) to see changes"