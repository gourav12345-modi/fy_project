from functools import wraps
from flask import request, jsonify
import flask as Flask
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.models.user import User

def auth_middleware(func):
    @jwt_required()
    @wraps(func)

    def decorated_function(*args, **kwargs):
        current_user_id = get_jwt_identity()
        user = User.find_by_id(id=current_user_id)
        print(user, current_user_id)
        if not user:
            return jsonify({'message': 'User not found'}), 404
        request.user = user 
        return func(*args, **kwargs)
     

    return decorated_function
