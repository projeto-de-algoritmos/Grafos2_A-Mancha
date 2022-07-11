from flask import Flask, render_template, request
import grafo as grafoModulo
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from flask_cors import CORS

print("=================================ATUALIZANDO====================================")

cred = credentials.Certificate("a-mancha-fc1e5f504751.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

app = Flask(__name__)
app.secret_key = "PROJETO DE ALGORITMOS"
CORS(app)

def criarApp():
    @app.route('/favicon.ico')
    def favicon():
        return render_template("favicon.html")

    @app.route('/<string:usuario>', methods=["POST"])
    def principal(usuario):
        docs = db.collection("usuarios").where("nome", "==", usuario).get()
        if(len(docs) == 0):
            db.collection("usuarios").document(usuario).set({"nome": usuario})
        grafo = grafoModulo.Grafo()
        grafo.adicionaNos()
        grafo.adicionaArestas()
        inicial, caminho, pontuacao, labels = grafo.calcula()
        db.collection("usuarios").document(usuario).set({"inicial": inicial, "caminho": caminho, "pontuacao": pontuacao, "label" : labels})
        grafo.mostra()
        return render_template("principal.html", usuario = usuario)
    return app
