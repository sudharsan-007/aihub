FROM jupyter/scipy-notebook:latest

# Copy the startup script
COPY startup.py /home/jovyan/.ipython/profile_default/startup/00-setup.py

# Set environment variables
ENV JUPYTER_ENABLE_LAB=yes
ENV NB_UID=1000
ENV NB_GID=100

# Install additional dependencies
USER root
RUN pip install requests

# Run with the right permissions
RUN chmod +x /home/jovyan/.ipython/profile_default/startup/00-setup.py

# Ensure we're running as jovyan user for security
USER jovyan

# The entry point is handled by the Railway's custom start command 