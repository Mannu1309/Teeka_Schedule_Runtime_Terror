from flask import Flask
from flask_cors import CORS, cross_origin
from flask import jsonify,request
from google.cloud import firestore
import os

app = Flask(__name__)
cors = CORS(app)

db = firestore.Client()

@app.route('/addparent/', methods=['POST'])
@cross_origin(allow_headers=['Content-Type', 'Authorization'])
def save_startup():
    # Project ID is determined by the GOOGLE_APPLICATION_CREDENTIALS environment variable
    try:
        data = request.get_json()
        
        name=data['Parent_name']
        gender = data['Gender']
        state = data['State']
        city = data['City']

        dob=data['DOB']
        profession=data['Profession']
        tot_dilv=data['Total_Dil']
        doc_ref=db.collection(u'parent').document()
        parent_id=doc_ref.id
        doc_ref.set({
            u'Name':name.lower(),
            u'DOB':dob,
            u'State':state.lower(),
            u'City':city.lower(),
            u'Profession':profession.lower(),
            u'Gender':gender.lower(),
            u'Total_Dil':tot_dilv          
        },merge=True)

        return jsonify({"status":"details added for parent {}".format(name)})
    except KeyError as err:
        return jsonify({"error":str(err)})        
    except Exception as err:
        return jsonify({"error":str(err)})

@app.route('/getparent/', methods=['GET'])
@cross_origin(allow_headers=['Content-Type', 'Authorization'])
def get_startup():
    # Project ID is determined by the GOOGLE_APPLICATION_CREDENTIALS environment variable
    try:
        docs = db.collection(u'parent').stream()
        parentList=[]

        for doc in docs:
            #print(u'{} => {}'.format(doc.id, doc.to_dict()))
            sdict=doc.to_dict()
            sdict['sid']=doc.id
            parentList.append(sdict)


        return jsonify({"parents":parentList})
    except KeyError as err:
        return jsonify({"error":str(err)})        
    except Exception as err:
        return jsonify({"error":str(err)})
if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0',port=int(os.environ.get('PORT', 8080)))