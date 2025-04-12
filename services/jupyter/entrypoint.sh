#!/bin/bash
exec start-notebook.sh --ip=0.0.0.0 --port=${PORT:-8888} --no-browser --allow-root --NotebookApp.token=${JUPYTER_TOKEN:-''} 