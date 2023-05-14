from flask import Blueprint, jsonify, request
from flask_jwt_extended import create_access_token
from app.models.user import User

auth_blueprint = Blueprint('auth', __name__)


@auth_blueprint.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    username = data['username']
    password = data['password']

    # Check if the username already exists
    if User.find_by_username(username):
        return jsonify({'message': 'Username already exists'}), 400

    # Create a new user and save it
    user = User(username, password)
    user.save()

    return jsonify({'message': 'User registered successfully'}), 201


@auth_blueprint.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    username = data['username']
    password = data['password']

    # Check if the username exists
    user = User.find_by_username(username)
    if not user:
        return jsonify({'message': 'Invalid username or password'}), 401

    # Verify the password
    if not User.verify_password(password, user['password']):
        return jsonify({'message': 'Invalid username or password'}), 401

    # Generate access token
    access_token = create_access_token(identity=username)

    return jsonify({'message': 'Login successful', 'access_token': access_token}), 200
