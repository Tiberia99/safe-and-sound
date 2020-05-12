#Much thanks to the Flask documentation
#https://flask.palletsprojects.com/en/1.1.x/api/#flask.Request.remote_addr

from flask import Flask, request

app = Flask(__name__)

@app.route('/')
def index():
    return 'Your IP Address is ' + request.remote_addr