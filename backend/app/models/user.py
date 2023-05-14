from app import db
from passlib.hash import bcrypt


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
    def verify_password(password, hashed_password):
        return bcrypt.verify(password, hashed_password)
