FROM jupyter/minimal-notebook:latest

# Copy the scripts
COPY startup.py /home/jovyan/.ipython/profile_default/startup/00-setup.py
COPY entrypoint.sh /entrypoint.sh
COPY health_check.py /health_check.py

# Set environment variables
ENV JUPYTER_ENABLE_LAB=yes

# Install additional dependencies
USER root
RUN pip install requests

# Run with the right permissions
RUN chmod +x /home/jovyan/.ipython/profile_default/startup/00-setup.py
RUN chmod +x /entrypoint.sh
RUN chmod +x /health_check.py
USER jovyan

# Use our custom entrypoint script
ENTRYPOINT ["/entrypoint.sh"] 