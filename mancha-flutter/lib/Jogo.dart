import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nuvem/classes/Resultado.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'classes/Dados.dart';

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  int contador = 0;
  List<String> gabarito = [];
  bool zeroZero = false;
  bool zeroUm = false;
  bool zeroDois = false;
  bool umZero = false;
  bool umUm = false;
  bool umDois = false;
  bool doisZero = false;
  bool doisUm = false;
  bool doisDois = false;
  Color cor = Colors.white;

  void initState(){
    fazTudo();
    super.initState();
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final dados = ModalRoute.of(context)!.settings.arguments as Dados;
    gabarito.contains(dados.caminho[0]) ? 0 : gabarito.add(dados.caminho[0]);
  }

  void fazTudo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? qualcor = prefs.getString("cor");
    switch(qualcor){
      case "Roxo":
        cor = Colors.purpleAccent;
        break;
      case "Amarelo":
        cor = Colors.yellow;
        break;
      case "Azul":
        cor = Colors.lightBlue;
        break;
      case "Ciano":
        cor = Colors.cyan;
        break;
      case "Teal":
        cor = Colors.teal;
        break;
      case "Degade":
        cor = Colors.blueGrey;
        break;
      case "Preto":
        cor = Colors.black87;
        break;
      case "Vermelho":
        cor = Colors.white;
        break;
      default:
        cor = Colors.white;
        break;
    }
    setState(() {
      cor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dados = ModalRoute.of(context)!.settings.arguments as Dados;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: cor == Colors.blueGrey ? const LinearGradient(
                colors: [
                  //Color(0XFFf82d48),
                  //Color(0XFFff1c36), //Color(0XFFff445d)
                  Colors.cyanAccent,
                  Colors.lightBlue,
                ],
                end: Alignment.bottomLeft,
                begin: Alignment.center
            ) :
            LinearGradient(
                colors: [
                  //Color(0XFFf82d48),
                  //Color(0XFFff1c36), //Color(0XFFff445d)
                  cor,
                  cor,
                ],
                end: Alignment.bottomLeft,
                begin: Alignment.center
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(child: Text("Rodada: ${dados.rodada}", style: const TextStyle(fontSize: 20),),),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/3) - 40,
                            height: (MediaQuery.of(context).size.width/3) - 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: dados.inicioFim[0] == "zeroZero" ? Colors.green : zeroZero == true ? Colors.yellow : dados.inicioFim[1]  == "zeroZero" ? Colors.red : Colors.blue
                              ),
                              child: const Text(""),
                              onPressed: () async{
                                contador = contador + 1;
                                gabarito.contains("zeroZero") ? showAlertDialog1(context) : gabarito.add("zeroZero");
                                if(gabarito[contador] == dados.caminho[dados.caminho.length - 1]){
                                  dados.rodada = dados.rodada + 1;
                                  Navigator.pushNamed(context, "/ProximoJogo", arguments: Resultado(dados.pontuacao, dados.rodada, dados.usuario, dados.placar + dados.pontuacao));
                                }
                                if(dados.caminho[contador] != "zeroZero"){
                                  await FirebaseFirestore.instance.collection("recordes").doc().set({"usuario": dados.usuario, "placar": dados.placar});
                                  await colocaMoedas(dados.placar);
                                  showAlertDialog1(context);
                                }else{
                                  setState(() {

                                    zeroZero = true;
                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          Text("${dados.label[1]}")
                        ],
                      ),
                      Column(
                        children: [
                          Text("${dados.label[0]}"),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/3) - 40,
                            height: (MediaQuery.of(context).size.width/3) - 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: dados.inicioFim[0] == "zeroUm" ? Colors.green : zeroUm == true ? Colors.yellow : dados.inicioFim[1]  == "zeroUm" ? Colors.red : Colors.blue
                              ),
                              child: const Text(""),
                              onPressed: () async{
                                contador = contador + 1;
                                gabarito.contains("zeroUm") ? showAlertDialog1(context) : gabarito.add("zeroUm");
                                if(gabarito[contador] == dados.caminho[dados.caminho.length - 1]){
                                  Navigator.pushNamed(context, "/ProximoJogo", arguments: Resultado(dados.pontuacao, ++dados.rodada, dados.usuario, dados.placar + dados.pontuacao));
                                }
                                if(dados.caminho[contador] != "zeroUm"){
                                  await FirebaseFirestore.instance.collection("recordes").doc().set({"usuario": dados.usuario, "placar": dados.placar});
                                  colocaMoedas(dados.placar);
                                  showAlertDialog1(context);
                                }else{
                                  setState(() {
                                    zeroUm = true;

                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          Text("${dados.label[3]}")
                        ],
                      ),
                      Column(
                        children: [
                          Text("${dados.label[2]}"),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/3) - 40,
                            height: (MediaQuery.of(context).size.width/3) - 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: dados.inicioFim[0] == "zeroDois" ? Colors.green : zeroDois == true ? Colors.yellow : dados.inicioFim[1]  == "zeroDois" ? Colors.red : Colors.blue
                              ),
                              child: const Text(""),
                              onPressed: () async{
                                contador = contador + 1;
                                gabarito.contains("zeroDois") ? showAlertDialog1(context) : gabarito.add("zeroDois");
                                if(gabarito[contador] == dados.caminho[dados.caminho.length - 1]){
                                  Navigator.pushNamed(context, "/ProximoJogo", arguments: Resultado(dados.pontuacao, ++dados.rodada, dados.usuario, dados.placar + dados.pontuacao));
                                }
                                if(dados.caminho[contador] != "zeroDois"){
                                  await FirebaseFirestore.instance.collection("recordes").doc().set({"usuario": dados.usuario, "placar": dados.placar});
                                  await colocaMoedas(dados.placar);
                                  showAlertDialog1(context);
                                }else{
                                  setState(() {
                                    zeroDois = true;

                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          Text("${dados.label[4]}")
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/3) - 40,
                            height: (MediaQuery.of(context).size.width/3) - 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: dados.inicioFim[0] == "umZero" ? Colors.green : umZero == true ? Colors.yellow : dados.inicioFim[1]  == "umZero" ? Colors.red : Colors.blue
                              ),
                              child: const Text(""),
                              onPressed: () async{
                                contador = contador + 1;
                                gabarito.contains("umZero") ? showAlertDialog1(context) : gabarito.add("umZero");
                                if(gabarito[contador] == dados.caminho[dados.caminho.length - 1]){
                                  Navigator.pushNamed(context, "/ProximoJogo", arguments: Resultado(dados.pontuacao, ++dados.rodada, dados.usuario, dados.placar + dados.pontuacao));
                                }
                                if(dados.caminho[contador] != "umZero"){
                                  await FirebaseFirestore.instance.collection("recordes").doc().set({"usuario": dados.usuario, "placar": dados.placar});
                                  await colocaMoedas(dados.placar);
                                  showAlertDialog1(context);
                                }else{
                                  setState(() {
                                    umZero = true;

                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          Text("${dados.label[6]}")
                        ],
                      ),
                      Column(
                        children: [
                          Text("${dados.label[5]}"),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/3) - 40,
                            height: (MediaQuery.of(context).size.width/3) - 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: dados.inicioFim[0] == "umUm" ? Colors.green : umUm == true ? Colors.yellow : dados.inicioFim[1]  == "umUm" ? Colors.red : Colors.blue
                              ),
                              child: const Text(""),
                              onPressed: () async{
                                contador = contador + 1;
                                gabarito.contains("umUm") ? showAlertDialog1(context) : gabarito.add("umUm");
                                if(gabarito[contador] == dados.caminho[dados.caminho.length - 1]){
                                  Navigator.pushNamed(context, "/ProximoJogo", arguments: Resultado(dados.pontuacao, ++dados.rodada, dados.usuario, dados.placar + dados.pontuacao));
                                }
                                if(dados.caminho[contador] != "umUm"){
                                  await FirebaseFirestore.instance.collection("recordes").doc().set({"usuario": dados.usuario, "placar": dados.placar});
                                  await colocaMoedas(dados.placar);
                                  showAlertDialog1(context);
                                }else{
                                  setState(() {
                                    umUm = true;

                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          Text("${dados.label[8]}")
                        ],
                      ),
                      Column(
                        children: [
                          Text("${dados.label[7]}"),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/3) - 40,
                            height: (MediaQuery.of(context).size.width/3) - 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: dados.inicioFim[0] == "umDois" ? Colors.green : umDois == true ? Colors.yellow : dados.inicioFim[1]  == "umDois" ? Colors.red : Colors.blue
                              ),
                              child: const Text(""),
                              onPressed: () async{
                                contador = contador + 1;
                                gabarito.contains("umDois") ? showAlertDialog1(context) : gabarito.add("umDois");
                                if(gabarito[contador] == dados.caminho[dados.caminho.length - 1]){
                                  Navigator.pushNamed(context, "/ProximoJogo", arguments: Resultado(dados.pontuacao, ++dados.rodada, dados.usuario, dados.placar + dados.pontuacao));
                                }
                                if(dados.caminho[contador] != "umDois"){
                                  await FirebaseFirestore.instance.collection("recordes").doc().set({"usuario": dados.usuario, "placar": dados.placar});
                                  await colocaMoedas(dados.placar);
                                  showAlertDialog1(context);
                                }else{
                                  setState(() {
                                    umDois = true;

                                  });
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          Text("${dados.label[9]}")
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/3) - 40,
                            height: (MediaQuery.of(context).size.width/3) - 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: dados.inicioFim[0] == "doisZero" ? Colors.green : doisZero == true ? Colors.yellow : dados.inicioFim[1]  == "doisZero" ? Colors.red : Colors.blue
                              ),
                              child: const Text(""),
                              onPressed: () async{
                                contador = contador + 1;
                                gabarito.contains("doisZero") ? showAlertDialog1(context) : gabarito.add("doisZero");
                                if(gabarito[contador] == dados.caminho[dados.caminho.length - 1]){
                                  Navigator.pushNamed(context, "/ProximoJogo", arguments: Resultado(dados.pontuacao, ++dados.rodada, dados.usuario, dados.placar + dados.pontuacao));
                                }
                                if(dados.caminho[contador] != "doisZero"){
                                  await FirebaseFirestore.instance.collection("recordes").doc().set({"usuario": dados.usuario, "placar": dados.placar});
                                  await colocaMoedas(dados.placar);
                                  showAlertDialog1(context);
                                }else{
                                  setState(() {
                                    doisZero = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("${dados.label[10]}"),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/3) - 40,
                            height: (MediaQuery.of(context).size.width/3) - 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: dados.inicioFim[0] == "doisUm" ? Colors.green : doisUm == true ? Colors.yellow : dados.inicioFim[1]  == "doisUm" ? Colors.red : Colors.blue
                              ),
                              child: const Text(""),
                              onPressed: () async{
                                contador = contador + 1;
                                gabarito.contains("doisUm") ? showAlertDialog1(context) : gabarito.add("doisUm");
                                if(gabarito[contador] == dados.caminho[dados.caminho.length - 1]){
                                  Navigator.pushNamed(context, "/ProximoJogo", arguments: Resultado(dados.pontuacao, ++dados.rodada, dados.usuario, dados.placar + dados.pontuacao));
                                }
                                if(dados.caminho[contador] != "doisUm"){
                                  await FirebaseFirestore.instance.collection("recordes").doc().set({"usuario": dados.usuario, "placar": dados.placar});
                                  await colocaMoedas(dados.placar);
                                  showAlertDialog1(context);
                                }else{
                                  setState(() {
                                    doisUm = true;

                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("${dados.label[11]}"),
                          const SizedBox(
                            width: 30,
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width/3) - 40,
                            height: (MediaQuery.of(context).size.width/3) - 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: dados.inicioFim[0] == "doisDois" ? Colors.green : doisDois == true ? Colors.yellow : dados.inicioFim[1]  == "doisDois" ? Colors.red : Colors.blue
                              ),
                              child: const Text(""),
                              onPressed: () async{
                                contador = contador + 1;
                                gabarito.contains("doisDois") ? showAlertDialog1(context) : gabarito.add("doisDois");
                                if(gabarito[contador] == dados.caminho[dados.caminho.length - 1]){
                                  Navigator.pushNamed(context, "/ProximoJogo", arguments: Resultado(dados.pontuacao, ++dados.rodada, dados.usuario, dados.placar + dados.pontuacao));
                                }
                                if(dados.caminho[contador] != "doisDois"){
                                  await FirebaseFirestore.instance.collection("recordes").doc().set({"usuario": dados.usuario, "placar": dados.placar});
                                  await colocaMoedas(dados.placar);
                                  showAlertDialog1(context);
                                }else{
                                  setState(() {
                                    doisDois = true;

                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  showAlertDialog1(BuildContext context) {
    // configura o button
    Widget okButton = ElevatedButton(
      child: Text("Voltar ao Menu"),
      onPressed: () {
        Navigator.pushNamed(context, "/Inicial");
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Você perdeu!"),
      content: Text("Dijkstra estaria triste com você."),
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  colocaMoedas(int quantidade) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var moedas = prefs.getInt('moedas');
    if(moedas == null){
      prefs.setInt('moedas', quantidade);
    }else{
      prefs.setInt('moedas', moedas + quantidade);
    }
  }
}

