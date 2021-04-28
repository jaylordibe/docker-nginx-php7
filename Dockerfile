FROM ubuntu:latest

# Copy setup script
COPY setup.sh /setup.sh
COPY start.sh /start.sh

# Setup container
RUN cd / && \
    chmod +x setup.sh && \
    chmod +x start.sh && \
    ./setup.sh && \
    rm -rf /setup.sh

COPY conf/nginx/sites-enabled/default /etc/nginx/sites-enabled/default
COPY conf/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Start php-nginx
ENTRYPOINT ["/start.sh"]
