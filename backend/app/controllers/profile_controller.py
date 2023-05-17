from flask import Blueprint, request, jsonify
from app.middlewares.auth_middleware import auth_middleware
from app.models.user import User

profile_bp = Blueprint('profile', __name__)


@profile_bp.route('/profile', methods=['PUT'])
@auth_middleware
def update_profile():
    user = request.user

    # Get the profile data from the request body
    profile_data = request.get_json()
    if not profile_data:
        return jsonify({'message': 'No profile data provided'}), 400

    # Update the user profile
    new_skills = profile_data.get('skills', [])
    new_bio = profile_data.get('bio', '')

    # Save the updated user profile
    User.update_one({'_id': user.get('_id')}, {'$set': {'skills': new_skills, 'bio': new_bio}})

    return jsonify({'message': 'Profile updated successfully'})

@profile_bp.route('/profile', methods=['GET'])
@auth_middleware
def get_profile():
    user = request.user
    return jsonify({
        'name': user['name'],
        'email': user['email'],
        'skills': user.get('skills', []),
        'bio': user.get('bio', '')
    })

@profile_bp.route('/profile', methods=['DELETE'])
@auth_middleware
def delete_profile():
    user = request.user

    # Delete the user
    user.delete()

    return jsonify({'message': 'Profile deleted successfully'})

