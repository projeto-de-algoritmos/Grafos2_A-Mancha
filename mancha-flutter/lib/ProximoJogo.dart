import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nuvem/classes/Dados.dart';
import 'package:nuvem/classes/Resultado.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProximoJogo extends StatefulWidget {
  const ProximoJogo({Key? key}) : super(key: key);

  @override
  State<ProximoJogo> createState() => _ProximoJogoState();
}
Dados dados = Dados([], [], 0, [], 0, "", 0);

class _ProximoJogoState extends State<ProximoJogo> {

  Color cor = Colors.white;

  void initState(){
    fazTudo();
    super.initState();
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
  Widget build(BuildContext context){
    fazTudo();
    final resultados = ModalRoute.of(context)!.settings.arguments as Resultado;
    return Container(
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
      child: Scaffold(
          backgroundColor: Colors.transparent.withOpacity(0),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 - 55,
                  ),
                  Text("Parabéns, você está na rodada: ${resultados.rodada}", style: const TextStyle(fontSize: 19),),
                  Text("Você também está com: ${resultados.placar} pontos!", style: const TextStyle(fontSize: 19),),
                  ElevatedButton(
                    child: const Text("Próxima rodada"),
                    onPressed: () async{
                      await http.post(Uri.parse("https://mancha.herokuapp.com/${resultados.usuario}"));
                      //await Future.delayed(const Duration(seconds: 2), (){});
                      var documento = await FirebaseFirestore.instance.collection("usuarios").doc(resultados.usuario);
                      documento.get().then((document){
                        Navigator.pushNamed(context, "/Jogo", arguments: Dados(document["inicial"], document["caminho"], document["pontuacao"], document["label"], 0, resultados.usuario, resultados.placar));
                      });
                      /*Dados dados = await pegaDados(nomeControlador.text);
                        print(dados.caminho);*/
                    },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.red)
                              )
                          )
                      )
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}



