from app import db
from passlib.hash import bcrypt


class User:
    def __init__(self, username, password):
        self.username = username
        self.password = bcrypt.hash(password)

    def save(self):
        db.users_collection.insert_one({
            'username': self.username,
            'password': self.password
        })

    @staticmethod
    def find_by_username(username):
        return db.users_collection.find_one({'username': username})

    @staticmethod
    def verify_password(password, hashed_password):
        return bcrypt.verify(password, hashed_password)
