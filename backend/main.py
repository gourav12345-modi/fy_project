from flask import Flask
from app import socketio, app  # noqa
import os

PORT = os.environ.get('PORT') or 5000

if __name__ == '__main__':
    app.config['DEBUG'] = os.environ.get('ENV') == 'development'
    # app.run(host='0.0.0.0', port=int(PORT), debug=True)
    socketio.run(app)
