import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:nuvem/Lojinha.dart';
import 'package:nuvem/classes/Dados.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inicial extends StatefulWidget {
  const Inicial({Key? key}) : super(key: key);

  @override
  State<Inicial> createState() => _InicialState();
}

class _InicialState extends State<Inicial> {

  final TextEditingController nomeControlador = TextEditingController();
  Color cor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
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
  Widget build(BuildContext context) {

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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: pegaDados(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else{
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("A MANCHA", style: TextStyle(fontSize: 38, color: cor == Colors.black87 ? Colors. white : Colors.black87),),
                                Icon(Ionicons.git_merge_outline, size: 30, color: cor == Colors.black87 ? Colors. white : Colors.black87)
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2 + 30,
                                child: TextField(
                                  controller: nomeControlador,
                                  decoration: InputDecoration(
                                      prefixIcon: const Icon(Ionicons.person_circle),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(color: Colors.grey[800]),
                                      hintText: "Digite seu nome de usuário",
                                      fillColor: Colors.white70),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              ElevatedButton(
                                child: const Text("Jogar"),
                                onPressed: () async{
                                  if(nomeControlador.text.contains(" ") || nomeControlador.text == "" || nomeControlador.text.length > 20){
                                    showAlertDialog1(context);
                                  }else{
                                    await http.post(Uri.parse("https://mancha.herokuapp.com/${nomeControlador.text}"));
                                    //await Future.delayed(const Duration(seconds: 2), (){});
                                    var documento = await FirebaseFirestore.instance.collection("usuarios").doc(nomeControlador.text);
                                    documento.get().then((document){
                                      Navigator.pushNamed(context, "/Jogo", arguments: Dados(document["inicial"], document["caminho"], document["pontuacao"], document["label"], 0, nomeControlador.text, 0));
                                    });
                                  }
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
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:  [
                                Text("OS 5 MELHORES", style: TextStyle(fontSize: 30, color: cor == Colors.black87 ? Colors. white : Colors.black87),),
                                SizedBox(width: 5,),
                                Icon(Ionicons.trophy_outline, size: 30, color: cor == Colors.black87 ? Colors. white : Colors.black87)
                              ],
                            ),
                          ),
                          ListView.builder(
                          cacheExtent: 28.0,
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length > 5 ? 5 : snapshot.data.docs.length,
                          reverse: false,
                          itemBuilder: (_, index){
                            return Card(
                              child: Container(
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
                                height: 55,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("${snapshot.data.docs[index]["usuario"]}: ${snapshot.data.docs[index]["placar"]}", style: TextStyle(fontSize: 18, color: cor == Colors.black87 ? Colors. white : Colors.black87),),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 10,
                            child: ElevatedButton(
                                child: const Text("Lojinha"),
                                onPressed: () async{
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) => Lojinha())
                                  );
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
                          ),
                        ],
                      ),
                    ),
                  );
                }
              }
          ),
        )
      ),
    );
  }
  showAlertDialog1(BuildContext context) {
    // configura o button
    Widget okButton = ElevatedButton(
      child: Text("Voltar"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Nome inválido!"),
      content: Text("Não utilize caracteres especiais, espaço ou um nome muito grande."),
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

  //Future<Map<String, int>> pegaDados() async{
  Future pegaDados() async{
    QuerySnapshot documentos = await FirebaseFirestore.instance.collection("recordes").orderBy("placar", descending: true).get();
    return documentos;
  }

  colocaMoedas(int quantidade) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var moedas = prefs.getInt('moedas');
    if(moedas == null){
      prefs.setInt('moedas', quantidade);
      print("moedas antes: 0");
    }else{
      prefs.setInt('moedas', moedas + quantidade);
      print("moedas antes: $moedas");
    }
    moedas = prefs.getInt('moedas');
    print("moedas depois: $moedas");
  }
}

