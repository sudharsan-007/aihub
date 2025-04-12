FROM jupyter/minimal-notebook:latest

# Copy the startup script
COPY startup.py /home/jovyan/.ipython/profile_default/startup/00-setup.py

# Expose the container port
EXPOSE 8888

# Set environment variables
ENV JUPYTER_ENABLE_LAB=yes

# Run with the right permissions
USER root
RUN chmod +x /home/jovyan/.ipython/profile_default/startup/00-setup.py
USER jovyan

# The container already has an entrypoint 