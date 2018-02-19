from flask import Flask, request
app = Flask(__name__)
import osquery

@app.route("/")
def prod():
    name = request.values.get('username')
    instance = osquery.SpawnInstance()
    instance.open()
    result = instance.client.query("select username, description from users where username='"+name+"'")
    status = result.status
    results = result.response

    output = str(status)+"<br>"
    output += "<table border='1'>"
    output += "<tr><td>username</td><td>description</td></tr>"
    for user in results:
        output += "<tr><td>"+user['username']+"</td><td>"+user['description']+"</td></tr>"
    output += "</table>"

    return str(output)

@app.route("/dev")
def dev():
    q = request.values.get('q')
    instance = osquery.SpawnInstance()
    instance.open()
    result = instance.client.query(q)

    output = str(result.status)+"<br>\r\n"
    for row in result.response:
        output += str(row)+"<br>\r\n"

    return str(output)

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=35275, debug=False)
