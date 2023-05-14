from flask import Flask
from flask_jwt_extended import JWTManager
from app.controllers.auth_controller import auth_blueprint


def create_app():
    app = Flask(__name__)
    
    # Set JWT secret key
    app.config['JWT_SECRET_KEY'] = 'super-secret-key'
    jwt = JWTManager(app)

    # Register the blueprint
    app.register_blueprint(auth_blueprint)

    return app


if __name__ == '__main__':
    app = create_app()
    app.run(debug=True)
