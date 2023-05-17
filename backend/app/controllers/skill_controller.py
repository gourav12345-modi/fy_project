from flask import Blueprint, jsonify, request
from flask_jwt_extended import create_access_token
from app.models.user import User

skill_blueprint = Blueprint('skill', __name__)


@skill_blueprint.route('/getskills', methods=['GET'])
def get_skill():
    word = request.args.get('word')
    
    # Perform your logic to fetch skills based on the provided word
    # Replace this example with your actual implementation
    skills = [
        'Java',
        'JavaScript',
        'Python',
        'Ruby',
        'Swift',
        'C++',
        'C#',
        'HTML',
        'CSS',
        'React',
        'Angular',
        'Vue.js',
        'Node.js',
        'Express.js',
        'MongoDB',
        'MySQL',
        'PostgreSQL',
        'Docker',
        'Kubernetes',
        'AWS',
        'Azure',
        'GCP'   
    ]

    
    matching_skills = [skill for skill in skills if skill.lower().startswith(word.lower())]
    
    return jsonify({'skills': matching_skills})

