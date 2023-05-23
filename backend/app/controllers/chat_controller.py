from app import socketio

@socketio.on('message')
def handle_message(message):
    print('Received message: ' + message)
    socketio.send(message, broadcast=True)