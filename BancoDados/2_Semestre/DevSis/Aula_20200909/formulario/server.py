from flask import Flask, render_template, request, redirect, url_for
import json

# pip install flask

app = Flask(__name__,static_url_path='', static_folder='static',template_folder='templates')

@app.route('/', methods=['GET'])
def index():
    return render_template('formulario.html')

@app.route('/qq_coisa', methods=['POST'])
def teste():
    # print(json.dumps(request.form.to_dict(), indent=4))

    primeiro_nome = request.form['primeiro_nome']
    ultimo_nome = request.form['ultimo_nome']
    telefone = request.form['telefone']
    print(type(telefone))

    # Subir no sql server
    primeiro_nome = primeiro_nome.upper()
    print(primeiro_nome)

    # print(request.form.to_dict())
    return redirect(url_for('index'))

@app.route('/login', methods=['POST'])
def teste2():
    print(json.dumps(request.form.to_dict(), indent=4))
    return redirect(url_for('index'))

@app.route('/sei_la', methods=['POST'])
def teste3():
    print(json.dumps(request.form.to_dict(), indent=4))
    return redirect(url_for('index'))

@app.route('/teste', methods=['POST'])
def teste4():
    #print(request.form)
    print(json.dumps(request.form.to_dict(), indent=4))
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run()