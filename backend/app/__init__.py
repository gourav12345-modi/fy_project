from flask import Flask
from datetime import timedelta
from flask_jwt_extended import JWTManager
from .controllers.auth_controller import auth_blueprint
from .controllers.skill_controller import skill_blueprint
from .controllers.profile_controller import profile_bp

def create_app():
    app = Flask(__name__)
    # Set JWT secret key
    app.config['JWT_SECRET_KEY'] = 'super-secret-key'
    app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(hours=360)
    jwt = JWTManager(app)

    # Register the blueprint
    app.register_blueprint(auth_blueprint)
    app.register_blueprint(skill_blueprint)
    app.register_blueprint(profile_bp)

    return app

app = create_app()
socketio = SocketIO(app, cors_allowed_origins='*')