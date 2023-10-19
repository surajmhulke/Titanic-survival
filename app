from flask import Flask, render_template, request
import pickle 
app = Flask(__name__)
model = pickle.load(open('titanic_model.pkl','rb')) #read mode
@app.route("/")
def home():
    return render_template('index.html')
@app.route("/predict", methods=['GET','POST'])
def predict():
    if request.method == 'POST':
        #access the data from form
        ## Age
        Survived = int(request.form["Survived"])
        Pclass = int(request.form["Pclass"])
        Gender = int(request.form["Gender"])
        Age = int(request.form["Age"])
        SibSp = int(request.form["SibSp"])
        Parch = int(request.form["Parch"])
        Fare = int(request.form["Fare"])
        Embarked = int(request.form["Embarked"])
        #get prediction
        input_cols = [['Survived', 'Pclass', 'Gender', 'Age', 'SibSp', 'Parch', 'Fare',
       'Embarked']]
        prediction = model.predict(input_cols)
        output = round(prediction[0], 2)
        return render_template("index.html", prediction_text='Your predicted surive is {}'.format(output))
if __name__ == "__main__":
    app.run(debug=True)