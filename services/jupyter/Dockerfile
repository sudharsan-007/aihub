FROM jupyter/minimal-notebook:latest

# Copy the startup script
COPY startup.py /home/jovyan/.ipython/profile_default/startup/00-setup.py
COPY entrypoint.sh /entrypoint.sh

# Set environment variables
ENV JUPYTER_ENABLE_LAB=yes

# Run with the right permissions
USER root
RUN chmod +x /home/jovyan/.ipython/profile_default/startup/00-setup.py
RUN chmod +x /entrypoint.sh
USER jovyan

# Use our custom entrypoint script
ENTRYPOINT ["/entrypoint.sh"] 