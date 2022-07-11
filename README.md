Tema:
 - Grafos2

# A Mancha

## Alunos
|Matrícula | Aluno |
| -- | -- |
| 19/0125829 |  Ian Costa  |
| 19/0129221 |  Murilo Souto|

## Sobre 
Jogo desenvolvido para android e para web. A cada rodada, um grafo 3x3 é formado. Cada nó se conecta aos nós ao seu lado, acima e abaixo. Cada aresta tem um valor gerado aleatoriamente. O objetivo é sair do ponto inicial (nó verde) para o ponto final (nó vermelho) utilizando as arestas de menores valores.

## Screenshots

<table>
    <tr>
        <td>Tela inicial</td><td>Jogo</td><td>Resultado</td>
    </tr>
    <tr>
        <td><img src="/print1.jpeg" width="200"></td><td><img src="/print2.jpeg" width="200"></td><td><img src="/print3.jpeg" width="200"></td>
    </tr>
</table>


## Instalação 
**Linguagem**: Dart, Python<br>
**Framework**: Flutter, Flask<br>
#### Método 1:
Acesse: https://a-mancha.web.app/
#### Método 2:
Faça o download do apk disponibilizado.
#### Método 3:
Tenha o python e o flutter baixado em sua máquina. 

Você precisará do python e do Flutter instalado.

##### Abra o terminal
 
- Baixe o projeto
> $ git clone https://github.com/projeto-de-algoritmos/Grafos2_A-Mancha
- Entre no diretório do projeto
> $ cd Grafos2_A-Mancha
- Acesse o diretório que contém o código do servidor
> $ cd servidor_python
- Baixe as bibliotecas necessárias
> $ pip3 install requeriments.txt
- Suba o servidor
> $ gunicorn "app:criarApp()"
- Volte para o diretório do projeto
> $ cd ..
- Acesse o diretório que contém o código do jogo
> $ cd mancha-flutter
- Rode o jogo
> $ flutter run

## Uso 
Após acessar o apk/site, escolha um nome de usuário e clique no botão jogar. Você começa no nó verde (não é necessário clicar nele) e termina no nó vermelho (ao final é necessário clicar nele). É necessário escolher o caminho que possui o menor valor ao total, para chegar na próxima rodada. <br>
Dica: Para jogar pense como funciona o algoritmo de dijsktra

