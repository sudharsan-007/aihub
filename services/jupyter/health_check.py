#!/usr/bin/env python3
"""
Health check server for Jupyter service in Railway.
This runs alongside Jupyter and provides a reliable health check endpoint.
"""

import http.server
import socketserver
import os
import threading
import time
import json
import requests

PORT = int(os.environ.get('HEALTH_PORT', 8889))
JUPYTER_PORT = int(os.environ.get('PORT', 8888))

class HealthHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/api/status':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.end_headers()
            
            response = {
                'status': 'ok',
                'timestamp': time.time()
            }
            
            self.wfile.write(json.dumps(response).encode())
        else:
            self.send_response(404)
            self.end_headers()
            self.wfile.write(b'Not found')
    
    def log_message(self, format, *args):
        # Suppress logging
        return

def start_health_server():
    with socketserver.TCPServer(("", PORT), HealthHandler) as httpd:
        print(f"Health check server started at port {PORT}")
        httpd.serve_forever()

if __name__ == "__main__":
    # Start the health server in a separate thread
    thread = threading.Thread(target=start_health_server, daemon=True)
    thread.start()
    
    print("Health check server running in background") 