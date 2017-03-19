from flask import Flask
from flask import request
app = Flask(__name__)

@app.route("/")
@app.route("/get")
def hello():
    return "Hello World!"

@app.route('/post',methods = ['POST', 'GET'])
def result():
   if request.method == 'POST':
      return "POST"
      # result = request.form
      # return render_template("result.html",result = result)

if __name__ == "__main__":
    # app.run()
    app.run(host='0.0.0.0',port=5000,debug=True)
    
    
# access on http://192.168..:5000    