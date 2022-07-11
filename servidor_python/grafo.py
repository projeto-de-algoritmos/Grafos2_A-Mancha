import networkx as nx
#from pyrebase import pyrebase
from random import randint
#import matplotlib.pyplot as plt

class Grafo():
    def __init__(self):
        self.grafo = nx.Graph()
    def adicionaNos(self):
        self.grafo.add_node("zeroZero", pos=(0,0))          # zeroZero | zeroUm | zeroDois
        self.grafo.add_node("zeroUm", pos=(0,4))            # umZero   | umUm   | umDois
        self.grafo.add_node("zeroDois", pos=(0,8))          # doisZero | doisUm | doisDois
        self.grafo.add_node("umZero", pos=(4,0))            
        self.grafo.add_node("umUm", pos=(4,4))              
        self.grafo.add_node("umDois", pos=(4,8))            
        self.grafo.add_node("doisZero", pos=(8,0))          
        self.grafo.add_node("doisUm", pos=(8,4))            
        self.grafo.add_node("doisDois", pos=(8,8))      
    def adicionaArestas(self):
        self.grafo.add_edge("zeroZero", "zeroUm", weight = randint(1, 33))
        self.grafo.add_edge("zeroZero", "umZero", weight = randint(1, 33))
        self.grafo.add_edge("zeroUm", "zeroDois", weight = randint(1, 33))
        self.grafo.add_edge("zeroUm", "umUm", weight = randint(1, 33))
        self.grafo.add_edge("zeroDois", "umDois", weight = randint(1, 33))
        self.grafo.add_edge("umZero", "umUm", weight = randint(1, 33))
        self.grafo.add_edge("umZero", "doisZero", weight = randint(1, 33))
        self.grafo.add_edge("umUm", "umDois", weight = randint(1, 33))
        self.grafo.add_edge("umUm", "doisUm", weight = randint(1, 33))
        self.grafo.add_edge("umDois", "doisDois", weight = randint(1, 33))
        self.grafo.add_edge("doisZero", "doisUm", weight = randint(1, 33))
        self.grafo.add_edge("doisUm", "doisDois", weight = randint(1, 33))
    def calcula(self):
        posicoes = ["zeroZero", "zeroUm", "zeroDois", "umZero", "umUm", "umDois", "doisZero", "doisUm", "doisDois"]
        valores = [(randint(0, 8)), (randint(0, 8))]
        while valores[0] == valores[1]:
            valores = [(randint(0, 8)), (randint(0, 8))]
        valores = [(posicoes[valores[0]]), posicoes[(valores[1])]]
        print(valores)
        print(nx.dijkstra_path(self.grafo, source=valores[0], target=valores[1]))
        print(nx.dijkstra_path_length(self.grafo, source=valores[0], target=valores[1]))
        labels = nx.get_edge_attributes(self.grafo, 'weight')
        return valores, nx.dijkstra_path(self.grafo, source=valores[0], target=valores[1]), nx.dijkstra_path_length(self.grafo, source=valores[0], target=valores[1]), list(labels.values())
    '''def mostra(self):
        pos = nx.get_node_attributes(self.grafo , 'pos')
        labels = nx.get_edge_attributes(self.grafo, 'weight')
        print(list(labels.values()))

        nx.draw_networkx_edge_labels(self.grafo, pos, edge_labels=labels)
        nx.draw(self.grafo, pos, with_labels = True)
        plt.show()'''


