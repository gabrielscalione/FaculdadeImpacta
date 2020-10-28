import sys
import os
import numpy as np
from cryptography.fernet import Fernet
from datetime import timedelta
import time
from flask import Flask, render_template, request,send_from_directory, render_template_string, request, jsonify, url_for, session, abort, redirect
from flask_socketio import SocketIO, emit, disconnect
from flask_login import login_required,logout_user,LoginManager, login_user, current_user, UserMixin

######################################## Config Flask ############################################
PASSWORD_KEY = 'QKKKQKBGQAKdQ77_uQ77zQnQ7J77QuQhKCgBKrEKCFK=' # Key para cripirografar senhas armazenadas no banco de dados
app = Flask(__name__,static_url_path='', static_folder='static',template_folder='templates')
app.permanent_session_lifetime = timedelta(seconds=1800)
app.config['SECRET_KEY'] = PASSWORD_KEY # Senha de criptografia
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0 # No cache
login = LoginManager(app)
login.login_view = '/' # Redireciona o decorator @login_required para a pagina inicial
cipher_suite = Fernet(PASSWORD_KEY.encode())
######################################## Config Flask ############################################

banco = [{
    'conta':'kevin',
    'senha':cipher_suite.encrypt('1234'.encode()).decode(),
    'ativo': 1
},{
    'conta':'camilla',
    'senha':cipher_suite.encrypt('1234'.encode()).decode(),
    'ativo': 1
}]

######################################## Rotas de login ##########################################
@login.user_loader
def user_loader(id):
    return User(id)
class User(UserMixin):
    def __init__(self, username):
        self.id = username

@app.route("/", methods=['GET','POST'])
def login_page():

    if request.method == 'GET':

        if current_user.is_authenticated:
            return render_template("home.html"), 200
        else:
            return render_template("login.html"), 200

    elif request.method == 'POST':
    
        conta = str(request.form['user'])
        senha = str(request.form['pass'])

        if conta == '' or senha == '':
            return render_template("login.html",status='Preencha os campos de autenticacao'), 400

        for idx,i in enumerate(banco):
            if i['conta'] == conta:
                idx_banco = idx
                break
            else:
                idx_banco = -1

        pagina = ''
        st = ''

        if idx_banco != -1:
            
            if banco[idx_banco]['ativo'] == 1:
                if cipher_suite.decrypt(banco[idx_banco]['senha'].encode()).decode() == senha:
                    # - admin_flag
                    login_user(User(conta))
                    pagina = 'home.html'
                    st = ''
   
                else:
                    pagina = 'login.html'
                    st = 'Senha incorreta'
            else:
                pagina = 'login.html'
                st = 'Sua conta nao esta ativa'
        else:
            pagina = 'login.html'
            st = 'Sua conta nao esta cadastrada'
            
        if st == '':
            return render_template(pagina), 200
        else:
            return render_template(pagina,status = st), 403

@app.route("/logout", methods=['GET'])
@login_required
def logout():
    logout_user()
    return redirect(url_for('login_page'))
######################################## Rotas de login ##########################################

if __name__ == "__main__":
    app.run(host='0.0.0.0',ssl_context='adhoc',port=5001)