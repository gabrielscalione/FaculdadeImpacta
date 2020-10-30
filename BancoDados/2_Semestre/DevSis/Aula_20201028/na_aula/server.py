import flask
import mysql.connector

# Para instalar o flask digite no terminal do seu Sistema Operacional: pip install flask

app = flask.Flask(__name__, template_folder='templates', # Todos os arquivos HTML
                            static_folder='static',      # Todos os arquivos JS e CSS
                            static_url_path='')          # URL para acessar a pasta static, '' significa acessar pelo domínio direto

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

@app.route('/cadastrar',methods=['POST'])
def salvar_dados():
    info = flask.request.form.to_dict()

    rg = info['rg']
    p_nome = info['primeiro_nome']
    u_nome = info['ultimo_nome']
    telefone = info['telefone']
    email = info['email']
    comentarios = info['comentarios']
 
    sql_insert = f'INSERT INTO formulario1 (email,rg,comentarios, primeiro_nome, telefone, ultimo_nome) VALUES ("{email}","{rg}","{comentarios}","{p_nome}",{telefone},"{u_nome}")'
    cursor.execute(sql_insert)
    banco_de_dados.commit()

    return flask.render_template('home.html')

@app.route('/consultar_rg',methods=['POST'])
def consultar_dados():
    
    info = flask.request.form.to_dict()
    rg_consulta = info['rg_consulta']

    sql_select = f'SELECT * FROM formulario1 WHERE rg = "{rg_consulta}"' 
    cursor.execute(sql_select)
    resultado = cursor.fetchall()
    
    print(resultado)

    return flask.render_template('home.html')

if __name__ == "__main__":
    # localhost = 127.0.0.1
    # Porta 80: HTTP
    # Porta 443: HTTPS

    # Acesso somente pelo seu PC
    app.run(host="localhost",port=9999)

    # Acesso somente pela sua INTRAnet
    # app.run(host="localhost",port=9999)

    # Acesso externo 
    # Liberar antivirus (desativar o firewall)
    # Redirecionar a porta 9999 ou qualquer outra porta do seu roteador para o IP que está rodando o flask
    # app.run(host="0.0.0.0",port=9999)
    

    



