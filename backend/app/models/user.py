from app.database import db
from passlib.hash import bcrypt
from bson import ObjectId

class User:
    def __init__(self, name,email, password):
        self.name = name
        self.email = email
        self.password = bcrypt.hash(password)
        self.skills = []
        self.bio=""
    def save(self):
        db.users_collection.insert_one({
            'name': self.name,
            'email': self.email,
            'password': self.password
        })

    @staticmethod
    def find_by_email(email):
        return db.users_collection.find_one({'email': email})

    @staticmethod
    def find_by_id(id):
        return db.users_collection.find_one({'_id': ObjectId(id)})

    @staticmethod
    def update_one(query, update):
        db.users_collection.update_one(query, update)

    @staticmethod
    def verify_password(password, hashed_password):
        return bcrypt.verify(password, hashed_password)
