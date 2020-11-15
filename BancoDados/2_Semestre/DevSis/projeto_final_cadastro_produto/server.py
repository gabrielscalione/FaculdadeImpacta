import flask
import mysql.connector

# Para instalar o flask digite no terminal do seu Sistema Operacional: pip install flask

app = flask.Flask(__name__, template_folder='templates', # Todos os arquivos HTML
                            static_folder='static',      # Todos os arquivos JS e CSS
                            static_url_path='')          # URL para acessar a pasta static, '' significa acessar pelo domínio direto

banco_de_dados = mysql.connector.connect(
    host="bd-grupo-08.mysql.uhserver.com",
    user="impacta_grupo08",
    password="ASDh427gh!46g[]",
    database="bd_grupo_08"
)
cursor = banco_de_dados.cursor()

@app.route('/',methods=['GET'])
def home(): 
    return flask.render_template('home.html')

@app.route('/cadastrar',methods=['POST'])
def salvar_dados():
    info = flask.request.form.to_dict()

    descricao = info['descricao']
    estoque_minimo = info['estoque_minimo']
    estoque_maximo = info['estoque_maximo']
    qtde = info['qtde']
    valor_unitario = info['valor_unitario']
    data_entrada = info['data_entrada']

    if ((descricao == "") | (estoque_minimo == "") | (estoque_maximo == "") | (qtde == "") | (valor_unitario == "") | (data_entrada == "")):
        return flask.render_template('home.html',status="Preencha todos os campos")
    
    sql_select = f'SELECT * FROM tbl_Produto WHERE descricao = "{descricao}"' 
    cursor.execute(sql_select)
    resultado = cursor.fetchall()
    if len(resultado) != 0:
        return flask.render_template('home.html',status=f"descricao: {descricao} já cadastrado")
    else:
        sql_insert = f'INSERT INTO tbl_Produto (descricao,estoque_minimo,estoque_maximo, qtde, valor_unitario, data_entrada) VALUES ("{descricao}","{estoque_minimo}","{estoque_maximo}","{qtde}",{valor_unitario},"{data_entrada}")'
        cursor.execute(sql_insert)
        banco_de_dados.commit()

    return flask.render_template('home.html',status=f"Produto: {descricao} cadastrado com sucesso!")

@app.route('/consultar_produto',methods=['POST'])
def consultar_produto():
    
    info = flask.request.form.to_dict()
    produto_consulta = info['produto_consulta']

    if produto_consulta == '':
        return flask.render_template('home.html',status="Preencha todos os campos")

    if produto_consulta == '*':
        sql_select = f'SELECT idProduto,descricao,estoque_minimo,estoque_maximo, qtde, valor_unitario, data_entrada FROM tbl_Produto' 
    else:
        sql_select = f'SELECT idProduto,descricao,estoque_minimo,estoque_maximo, qtde, valor_unitario, data_entrada FROM tbl_Produto WHERE descricao = "{produto_consulta}"' 
    cursor.execute(sql_select)
    resultado = cursor.fetchall()

    if len(resultado) == 0:
        if produto_consulta == '*':
            return flask.render_template('home.html',status=f'Nenhum produto cadastrado!')
        else:
            return flask.render_template('home.html',status=f'Produto: {produto_consulta} não encontrado')


    campos = ['idProduto','descricao','estoque_minimo','estoque_maximo','qtde','valor_unitario','data_entrada']
    resultado_final = []
    for i in resultado:
        resultado_final.append(list(zip(campos,i)))

    return flask.render_template('home.html',resultado=resultado_final)

@app.route('/consultar_idProduto',methods=['POST'])
def consultar_idProduto():
    
    info = flask.request.form.to_dict()
    consultar_idProduto = info['consultar_idProduto']

    if consultar_idProduto == '':
        return flask.render_template('home.html',status="Preencha todos os campos")

    sql_select = f'SELECT idProduto,descricao,estoque_minimo,estoque_maximo, qtde, valor_unitario, data_entrada FROM tbl_Produto WHERE idProduto = "{consultar_idProduto}"' 
    cursor.execute(sql_select)
    resultado = cursor.fetchall()

    if len(resultado) == 0:
        return flask.render_template('home.html',status=f'Código do Produto: {consultar_idProduto} não encontrado')


    campos = ['idProduto','descricao','estoque_minimo','estoque_maximo','qtde','valor_unitario','data_entrada']
    resultado_final = []
    for i in resultado:
        resultado_final.append(list(zip(campos,i)))

    return flask.render_template('home.html',resultado=resultado_final)

@app.route('/alterar_dados',methods=['POST'])
def alterar_dados():
    info = flask.request.form.to_dict()

    descricao = info['descricao']
    estoque_minimo = info['estoque_minimo']
    estoque_maximo = info['estoque_maximo']
    qtde = info['qtde']
    valor_unitario = info['valor_unitario']
    data_entrada = info['data_entrada']

    if (descricao == ""):
        return flask.render_template('home.html',status="Preencha todos os campos")
    
    sql_select = f'SELECT * FROM tbl_Produto WHERE descricao = "{descricao}"' 
    cursor.execute(sql_select)
    resultado = cursor.fetchall()

    if len(resultado) == 0:
        return flask.render_template('home.html',status="Produto não cadastrado!")
    else:
        
        # Não altera se tiver vazio
        campos = ['descricao','estoque_minimo','estoque_maximo','qtde','valor_unitario','data_entrada']
        dados = [descricao,estoque_minimo,estoque_maximo,qtde,valor_unitario,data_entrada]

        sql_update = 'UPDATE tbl_Produto SET '
        for idx,valor in enumerate(dados):
            if valor != '':
                if campos[idx] == 'qtde':
                    sql_update = sql_update + f'{campos[idx]} = {valor},'
                else:
                    sql_update = sql_update + f'{campos[idx]} = "{valor}",'

        sql_update = sql_update[:-1]        
        sql_update = sql_update + f' WHERE descricao = "{descricao}"'
 
        cursor.execute(sql_update)
        banco_de_dados.commit()
        return flask.render_template('home.html',status=f"Produto: {descricao} alterado com sucesso")

@app.route('/deletar',methods=['POST'])
def deletar_dados():
    info = flask.request.form.to_dict()
    descricao = info['descricao_del']

    if descricao == '':
        return flask.render_template('home.html',status="Preencha todos os campos")
    
    if descricao == '*':
        sql_delete = f'DELETE FROM tbl_Produto'
        cursor.execute(sql_delete)
        banco_de_dados.commit()
        return flask.render_template('home.html',status=f"Todos os Produtos foram deletados com sucesso")

    sql_select = f'SELECT * FROM tbl_Produto WHERE descricao = "{descricao}"' 
    cursor.execute(sql_select)
    resultado = cursor.fetchall()

    if len(resultado) == 0:
        return flask.render_template('home.html',status=f"Produto: {descricao} não cadastrado")
    else:
        sql_delete = f'DELETE FROM tbl_Produto WHERE Produto = "{descricao}"'
        cursor.execute(sql_delete)
        banco_de_dados.commit()
        return flask.render_template('home.html',status=f"Produto: {descricao} deletado sucesso")

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
    

    



