import flask
import mysql.connector

app = flask.Flask(__name__,template_folder='templates', # Todos os arquivos  HTML 
            static_folder='static',                     # Todos os arquivos JS e CSS
            static_url_path='')                         # URL para acessar a pasta static, '' significa acessar pelo dominio direto.


banco_de_dados = mysql.connector.connect(
    host="cadastro-teste.mysql.uhserver.com",
    user="alunos_impacta",
    password="Impacta@10",
    database="cadastro_teste"
)
cursor = banco_de_dados.cursor()

@app.route('/',methods=['GET'])
def home():
    return flask.render_template('home.html')


@app.route('/salvar',methods=['POST'])
def salvar_dados():
    info = flask.request.form.to_dict()

    rg = info['rg']
    p_nome = info['primeiro_nome']
    u_nome = info['ultimo_nome']
    telefone = info['telefone']
    email = info['email']
    comentarios = info['comentarios']

    
    sql_insert = f'INSERT INTO formulario1(email,rg,comentarios, primeiro_nome,telefone,ultimo_nome)VALUES("{email}","{rg}","{comentarios}","{p_nome}",{telefone},"{u_nome}")'
    cursor.execute(sql_insert)
    banco_de_dados.commit()

    return flask.render_template('home.html')


@app.route('/consulta',methods=['POST'])
def consultar_dados():
    info = flask.request.form.to_dict()
    rg_consulta = info['rg_consulta']

    sql_select = f'SELECT * FROM formulario1 where rg = "{rg_consulta}"'
    cursor.execute(sql_select)
    resultado = cursor.fetchall()

    print(resultado)


    return flask.render_template('home.html')

if __name__ == "__main__":
     # localhost = 127.0.0.1

     # porta 80: HTTP
     # porta 443: HTTPS

     # Acesso pelo PC
     app.run(host="localhost", port=9999)

     # Acesso pela INTRANET
     # app.run(host="192.168.0.245", port=9999)

     # Acesso externo
     # Redirecionar a porta 9999 ou qualquer outra porta do seu roteador 
     # app.run(host="0.0.0.0", port=9999) # porém há algumas liberaçoes do antivirus e roteador