import sqlite3

conn = sqlite3.connect("galeria.db")

cursor= conn.cursor()

def criar_tabela():
    sql = """
        CREATE TABLE albuns(titulo text, artista text, data_lancamento text,
        data_publicacao text, midia text)
    """

    cursor.execute(sql)

    conn.commit()

def grava_album():
    sql = "INSERT INTO albuns VALUES('Glow','Andy Hunter','24/07/2012','Xplore Records','MP3')"

    cursor.execute(sql)

    conn.commit()

def grava_muitos():
    albuns = [('Exodus','Andy Hunter','08/08/2020', 'Sparrow Records','CD'),
              ('Until We Have Faces','Red','01/01/2020', 'Essential Records','DVD')]

    cursor.executemany("INSERT INTO albuns VALUES(?,?,?,?,?)", albuns)

    conn.commit()


def atualiza():
    sql = """
        UPDATE albuns SET artista = 'John Doe'
        WHERE artista = 'Andy Hunter'
    """

    cursor.execute(sql)

    conn.commit()


def excluir():
    sql = """
        DELETE FROM albuns
        WHERE artista = 'John Doe'
    """

    cursor.execute(sql)
    conn.commit()


def listar():
    sql = """
        SELECT rowid, * FROM albuns ORDER BY artista
    """

    cursor.execute(sql)

    for row in cursor.fetchall():
        print(row)
