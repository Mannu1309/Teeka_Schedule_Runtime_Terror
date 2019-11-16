from flask import Flask
from flask_cors import CORS, cross_origin
from flask import request, jsonify
import random
import os
#FOR DATABASE OPERATION
import database as db

app=Flask("__main__")
cors=CORS(app)

# ------------- FETCH THE DETAILS OF EXISTING USER ------------ #
@app.route('/fetch_details',methods=['POST'])
@cross_origin(allow_headers=['Content-Type','Authorization'])
def fetch_user_details():
    global user_data
    user_data = None
    try:
        data=request.get_json()
        name = data['name']
        gender = data['gender']
        dob = data['dob']
        age = data['age']
        nationality = data['nationality']
        city = data['city']
        state = data['state']
        profession = data['profession']
        income = data['income']
        response = saveDetails(data, name, gender, age, nationality, city, state, income, profession, dob)
        return jsonify({"resonse":response})
    except Exception as err:
        return jsonify({"error": str(err)})

@app.route('/getParentData',methods=['POST'])
@cross_origin(allow_headers=['Content-Type','Authorization'])
def getP():
    try:
        response = get_details()
        return jsonify({"resonse":response})
    except Exception as err:
        return jsonify({"error": str(err)})

#---------------------------------------RUN SQL QUERY FOR FETCHING DETAILS FROM ANY TABLE---------------------------------#
def get_details():
    conn=db.db()
    sql="SELECT * FROM parents;"
    cur = conn.exec(sql)
    data = cur.fetchall()
    return data

#---------------------------------------RUN SQL QUERY FOR FETCHING DETAILS FROM ANY TABLE---------------------------------#
def saveDetails(data, name, gender, age, nationality, city, state, income, profession, dob):
    conn=db.db()
    sql="INSERT INTO parents(name, age, gender, nationality, city, state, dob, income, profession) values('"+name+"','"+age+"','"+gender+"','"+nationality+"','"+city+"','"+state+"','"+dob+"','"+income+"','"+profession+"');"
    cur = conn.exec(sql)
    return "success"
    
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
    
