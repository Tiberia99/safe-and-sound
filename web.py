#Much thanks to the Flask documentation
#https://flask.palletsprojects.com/en/1.1.x/quickstart/#a-minimal-application
#https://flask.palletsprojects.com/en/1.1.x/api/#flask.Request.remote_addr

from flask import Flask, request

app = Flask(__name__)

#In-memory Dictionary to store data.  Keys are string names of objects, values are ints of votes.
#NOTE: Datastore is NOT persisted between restarts.
datastore = {'example' : 0}

#I thought it would be helpful to show the available API calls on the home page.
#Route list code referenced from https://stackoverflow.com/a/50026157
@app.route('/')
def index():
    routes = []
    for rule in app.url_map.iter_rules():
        routes.append('%s' % rule)
    return 'Welcome visitor from ' + request.remote_addr + ' <br> Available APIs: ' + str(routes)

#List all objects
@app.route("/list")
def list():
    return ', '.join(datastore.keys())
    
#Get the vote count for particular object.  Return error if it doesn't exist.
@app.route("/getvote")
def getvote():
    key = request.args.get("key")
    if (key == "" or key == None):
        return "Missing argument 'key'", 400
    else:
        try:
            return str(datastore[key]) #Flask needs to return String, not Int
        except:
            return "Object '" + key + "' not found", 404

    
#Create a new object.  Ignore if already exists - Do Not over-write existing.
@app.route("/create", methods=['POST'])
def create():
    key = request.args.get("key")
    if (key == "" or key == None):
        return "Missing argument 'key'", 400 #Bad request
    elif key in datastore:
        return "", 200 # Do nothing, return sucess
    else:
        datastore[key] = 0 #Set vote count to zero by default
        return "", 201 #Created

#Delete an object if it exists
@app.route("/delete", methods=['DELETE'] )
def delete():
    key = request.args.get("key")
    if (key == "" or key == None):
        return "Missing argument 'key'", 400
    else:
        try:
            del datastore[key]
            return "", 204 #No content to return
        except:
            return "Object '" + key + "' not found", 404
    
#Increment the vote count for particular object and return the new count.  
#Return error if it doesn't exist.
@app.route("/upvote", methods=['PUT'])
def upvote():
    key = request.args.get("key")
    if (key == "" or key == None):
        return "Missing argument 'key'", 400
    else:
        try:
            datastore[key] = datastore[key] + 1 #Does not handle Max_Int overflows
            return str(datastore[key])
        except:
            return "Object '" + key + "' not found", 404
        
#Decrement the vote count for particular object and return the new count.
#Return error if it doesn't exist.
#Allow negative numbers
@app.route("/downvote", methods=['PUT'])
def downvote():
    key = request.args.get("key")
    if (key == "" or key == None):
        return "Missing argument 'key'", 400
    else:
        try:
            datastore[key] = datastore[key] - 1
            return str(datastore[key]) #Flask needs to return String, not Int
        except:
            return "Object '" + key + "' not found", 404
            