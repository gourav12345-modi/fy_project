from flask import Blueprint, jsonify, request,make_response
from flask_jwt_extended import create_access_token
# from flask_jwt_extended import jwt_required,get_raw_jwt_token, get_jwt_identity
from flask_jwt_extended import jwt_required, unset_jwt_cookies,  get_jwt_identity
from app.models.user import User

auth_blueprint = Blueprint('auth', __name__)


@auth_blueprint.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    name = data['name']
    email = data['email']
    password = data['password']

    # Check if the username already exists
    if User.find_by_email(email):
        return jsonify({'message': 'Username already exists'}), 400

    # Create a new user and save it
    user = User(name,email, password)
    user.save()

    return jsonify({'message': 'User registered successfully'}), 201


@auth_blueprint.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data['email']
    password = data['password']

    # Check if the username exists
    user = User.find_by_email(email)
    if not user:
        return jsonify({'message': 'Invalid username or password'}), 401

    # Verify the password
    if not User.verify_password(password, user['password']):
        return jsonify({'message': 'Invalid username or password'}), 401

    # Generate access token
    # print(user['_id'])
    access_token = create_access_token(identity=str(user['_id']))

    return jsonify({'message': 'Login successful', 'access_token': access_token}), 200




# @auth_blueprint.route('/profile', methods=['PUT'])
# @jwt_required()
# def update_profile():
#     current_user = get_jwt_identity()
#     user = User.find_by_email(email=current_user)

#     if not user:
#         return jsonify({'message': 'User not found'}), 404

#     data = request.get_json()
#     name = data.get('name')
#     email = data.get('email')

#        # Update the user's name if provided
#     if name:
#         user.name = name

#     # Update the user's email if provided and not already taken
#     if email and email != user.email:
#         if User.query.filter_by(email=email).first():
#             return jsonify({'message': 'Email already exists'}), 400
#         user.email = email

#     # Save the updated user
#     user.save()

#     return jsonify({'message': 'Profile updated successfully'}), 200

# @auth_blueprint.route('/me', methods=['GET'])
# @jwt_required()
# def get_profile():
#     current_user = get_jwt_identity()
#     user = User.find_by_email(current_user)

#     if not user:
#         return jsonify({'message': 'User not found'}), 404

#     profile = {
#         'name': user['name'],
#         'email': user['email'],
#         # 'skills': user['skills'],
#         # 'bio': user['bio']
#     }

#     return jsonify(profile), 200
# # logout


@auth_blueprint.route('/logout', methods=['POST'])
@jwt_required()
def logout():
    user = User.find_by_id(get_jwt_identity())

    if not user:
        return jsonify({'message': 'User not found'}), 404

    # Clear the access token cookie
    response = make_response(jsonify({'message': 'Logout successful'}), 200)
    unset_jwt_cookies(response)

    return response





# @auth_blueprint.route('/delete', methods=['DELETE'])
# @jwt_required()
# def delete_user():
#     current_user = get_jwt_identity()
#     user = User.find_by_email(current_user)

#     if not user:
#         return jsonify({'message': 'User not found'}), 404

#      # Delete the user
#     user_instance = User(user['name'], user['email'], user['password'])
#     user_instance.delete()

#     return jsonify({'message': 'User deleted successfully'}), 200

# Regenerate response
# get profile

# update profile

# delete profile

