from flask import Flask
from flask_cors import CORS, cross_origin
from flask import request, jsonify
import random
import os
#FOR DATABASE OPERATION
import database as db

app=Flask("__main__")
cors=CORS(app)
global data, columns


# Request 
#     "sid"   -> student_id for which the data is to be fetched
#     "table_number"  -> table_number for table from which the data is to be fetched
#     table_number 1 = "aadhar"
#     table_number 2 = "collegeid"
#     table_number 3 = "gradecard"
#     table_number 4 = "pan"
#     table_number 5 = "photo"
#     table_number 6 = "provider_user_info"
#     table_number 7 = "registration_check"
#     table_number 8 = "resume"
#     table_number 9 = "student_academic_details"
#     table_number 10 = "student_info"
#     table_number 11 = "tenthmarksheet"
#     table_number 12 = "twelfthmarksheet"

table = {}
table["1"] = "aadhar"
table["2"] = "collegeid"
table["3"] = "gradecard"
table["4"] = "pan"
table["5"] = "photo"
table["6"] = "provider_user_info"
table["7"] = "registration_check"
table["8"] = "resume"
table["9"] = "student_academic_details"
table["10"] = "student_info"
table["11"] = "tenthmarksheet"
table["12"] = "twelfthmarksheet"
table["13"] = "github_data"
table["14"] = "linkedin_data"


# ------------- FETCH THE DETAILS OF EXISTING USER ------------ #
@app.route('/fetch_details',methods=['POST'])
@cross_origin(allow_headers=['Content-Type','Authorization'])
def fetch_user_details():
    global user_data
    user_data = None
    try:
        data=request.get_json()
        id = data['sid']
        table_number = data['table_number']
        user_data = get_details(id, table_number)
        columns = get_column_names(id, table_number)
        dict = {}
        for c, u in zip(columns,user_data):
            dict[c]=u
        return jsonify(dict)
    except Exception as err:
        return jsonify({"error": str(err)})

#---------------------------------------RUN SQL QUERY FOR FETCHING DETAILS FROM ANY TABLE---------------------------------#
def get_details(id, table_number):
    conn=db.db()
    sql="SELECT * FROM "+table[table_number]+" WHERE student_id = '"+str(id)+"';"
    cur = conn.exec(sql)
    data = cur.fetchall()
    l = []
    for d in data:
        for i in d:
            l.append(i)
    return l

def get_column_names(id, table_number):
    conn=db.db()
    sql = "describe "+table[table_number]+";"
    cur = conn.exec(sql)
    columns = cur.fetchall()
    l = []
    for c in columns:
        l.append(c[0])
    # print(l)
    return l

# ------------- FETCH THE DETAILS OF EXISTING USER ------------ #
@app.route('/fetch_all',methods=['POST'])
@cross_origin(allow_headers=['Content-Type','Authorization'])
def fetch_all():
    global table_data
    table_data = None
    try:
        data=request.get_json()
        table_number = data['table_number']
        table_data = get_all_data(table_number)
        columns = get_column_names(id, table_number)
        alldata = []
        for t in table_data:
            abc = None
            dict = {}
            for c, u in zip(columns,t):
                
                abc = c
                dict[c]=u
            alldata.append(dict)
        return jsonify(alldata)
    except Exception as err:
        return jsonify({"error": str(err)})
    
#---------------------------------------RUN SQL QUERY FOR FETCHING DETAILS FROM ANY TABLE---------------------------------#
def get_all_data(table_number):
    conn=db.db()
    sql="SELECT * FROM "+table[table_number]+";"
    cur = conn.exec(sql)
    data = cur.fetchall()
    
    return data
    
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
    
