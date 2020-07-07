#sample command for signup
#curl -d '{"email":"value1@gmail.com", "password":"value2", "name":"value1","role":"supervisor"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/signup
#curl -d '{"timestamp":"12345","stepcount":"200","duration":"1","employeeID":"1234","type":"productivity","asleep":"20","active":"40"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pushdata
#curl -d '{"type":"person","employeeID":"1234"}' -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pulldata
#curl -d '{"type":"collective"} -H "Content-Type: application/json" -X POST http://localhost:5000/api/v1/pulldata
#1594133266
import os
import json
import uuid
from flask import Flask, request
from flask_cors import CORS
from pymongo import MongoClient
import sys
import random
app = Flask(__name__)
CORS(app)
client = MongoClient(
    os.environ['DB_PORT_27017_TCP_ADDR'],
    27017)
db = client.employees

@app.route('/api/v1/signup', methods=['POST'])
def signup():
    data = request.get_json()
    if db.employees.count_documents({'email': data['email']}):
        print(db.employees.count_documents({'email': data['email']}), file=sys.stderr)
        return {"message":"User exists! Please Log In"}, 201
    item_doc = {
        'name': data['name'],
        'email': data['email'],
	'password': data['password'],
	'role': data['role'],
    'employeeID': data['employeeID']
    }
    db.employees.insert_one(item_doc)
    return {"message":"Success!"}, 201

@app.route('/api/v1/login', methods=['POST'])
def login():
    data = request.get_json()
    if db.employees.count_documents({'email': data['email'], 'password': data['password']}):
        key = uuid.uuid4().hex
        items = db.employees.find_one({'email': data['email'], 'password': data['password']})
        return {"message":"Logged In!", "key":key, "role": items['role'], "employeeID": items['employeeID']}, 201
    else:
        return {"message":"Wrong username or password!"}, 403

@app.route('/api/v1/fatigue', methods=['POST'])
def fatigue():
    data = request.get_json()
    arr = []
    sum_arr=[0,0,0]
    _items = db.fatigue.find({'employeeID':data['employeeID']})
    for item in _items:
        arr.append(item['alpha'])
        sum_arr[0]+=float(item['alpha'])
        sum_arr[1]+=float(item['beta'])
        sum_arr[2]+=float(item['gamma'])
    print(arr,file=sys.stderr)
    print(sum_arr,file=sys.stderr)
    return {'message':'success', "data":arr, "sum":sum_arr}, 201

@app.route('/api/v1/pollution', methods=['POST'])
def pollution():
    data = request.get_json()
    arr = []
    _items = db.pollution.find({'employeeID':data['employeeID']})
    for item in _items:
        arr.append(item['pollution'])
    val = random.choices(arr)
    return {'message':'success', 'data':val[0]}, 201

@app.route('/api/v1/stepcount', methods=['POST'])
def stepcount():
    data = request.get_json()
    _items = db.productivity.find({'employeeID':data['employeeID']})
    steps = 0
    for item in _items:
        steps += int(item['stepcount'])
    return {'message':'success', 'data':steps}, 201

@app.route('/api/v1/workercount', methods=['GET'])
def workercount():
    arr = []
    _items = db.productivity.find({"status":"active"})
    count = 0
    for item in _items:
        timestamp = int(item['timestamp'])
        count = db.productivity.count_documents({'status':"active","timestamp":{"$gte":str(timestamp), "$lte": str(timestamp+3600)}})
        arr.append(count)
        print(arr,file=sys.stderr)
        print(timestamp+3600,file=sys.stderr)
        if db.productivity.count_documents({"status":"active", "timestamp":{"$gt":str(timestamp+3600)}}):
            _items = db.productivity.find({"status":"active", "timestamp":{"$gt":str(timestamp+3600)}})
        else:
            break
    return {'message':'success','data':arr}, 200

@app.route('/api/v1/pushdata', methods=['POST'])
def pushdata():
    data = request.get_json()
    print(data, file=sys.stderr)
    if data['type'] == "productivity":
        db.productivity.insert_one({'timestamp':data['timestamp'],'duration':data['duration'],'employeeID': data['employeeID'],
        'asleep': data['asleep'],'active': data['active'],'stepcount': data['stepcount'], 'status': data['status']})
        return {"message":"Success"}, 201
    elif data['type'] == "pollution":
        db.pollution.insert_one({'employeeID': data['employeeID'], 'pollution': data['pollution'] })
        return {"message":"Success"}, 201
    elif data['type'] == "fatigue":
        db.fatigue.insert_one({'employeeID':data['employeeID'], 'alpha':data['alpha'], 'beta':data['beta'], 'gamma': data['gamma']})
        return {"message":"Success"}, 201
    return {"message":"Failed"}, 403

@app.route('/api/v1/pulldata', methods=['POST'])
def pulldata():
    data = request.get_json()
    ord_arr=[]
    sumdur_item = 0
    sumact_item = 0
    sumasl_item = 0
    sumcount_item = 0
    if data['type'] == "collective":
        sum_list = dict()
        _items = db.productivity.find()
        #items = [item for item in _items]
        for item in _items:
            print(item, file=sys.stderr)
            sum_list[item['employeeID']] = []
            _peritems = db.productivity.find({'employeeID': item['employeeID']})
            for peritem in _peritems:
                sumdur_item += float(peritem['duration'])
                sumact_item += float(peritem['active'])
                sumasl_item += float(peritem['asleep'])
                sumcount_item += float(peritem['stepcount'])
            sum_list[item['employeeID']].append(sumcount_item/25000 + sumact_item/60*sumdur_item)
            sum_list = {k: v for k, v in sorted(sum_list.items(), key=lambda item: item[1])}
            ord_arr=[item for item in sum_list.keys()]
            ord_arr.reverse()
        return {'message':'success','sorted':ord_arr}, 201

    elif data['type'] == "person":
        sum_list = []
        _items = db.productivity.find({'employeeID': data['employeeID']})
        #items = [item for item in _items]
        for item in _items:
            sumdur_item = float(item['duration'])
            sumact_item = float(item['active'])
            sumasl_item = float(item['asleep'])
            sumcount_item = float(item['stepcount'])
            print(item, file=sys.stderr)
            sum_list.append(sumcount_item/25000 + sumact_item/60*sumdur_item) #{'stepcount':sumcount_item,'active':sumact_item, 'asleep': sumasl_item, 'employeeID': data['employeeID']}
        return {'message':'success', 'data':sum_list}, 201
    return 201

if __name__ == "__main__":
    app.run(host='0.0.0.0', debug=True)
