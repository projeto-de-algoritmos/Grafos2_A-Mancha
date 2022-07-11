import 'package:flutter/material.dart';
import 'package:nuvem/Inicial.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Lojinha extends StatefulWidget {
  const Lojinha({Key? key}) : super(key: key);

  @override
  State<Lojinha> createState() => _LojinhaState();
}

class _LojinhaState extends State<Lojinha> {

  var listaDeProdutos;
  var moedas;
  Color cor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    fazTudo();
    super.initState();
  }

  void fazTudo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listaDeProdutos = prefs.getString("listaProdutos");
    moedas = prefs.getInt('moedas');
    print(listaDeProdutos);
    if(moedas == null){
      moedas = 0;
      await prefs.setInt("moedas", 0);
    }
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
      moedas;
      listaDeProdutos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 10),
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
            child: ListView(
              children: [
                Stack(
                  children: [
                    Positioned(
                      left: 10,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Inicial())
                          );
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width-300,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(12.0)
                          ),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.arrow_back, color: Colors.white,),
                                  SizedBox(width: 6.0,),
                                  Text("Voltar", style: TextStyle(fontSize: 22.0, color: Colors.black87, fontWeight: FontWeight.bold)),
                                ],
                              )
                          ),
                        ),
                      ),
                    ),

                    const Center(child: Text("Loja", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),),),
                    Positioned(
                      right: 5,
                      top: 3,
                      child: Row(
                        children: [
                          Icon(Icons.monetization_on_outlined, color: cor == Colors.black87 ? Colors. white : Colors.black87,),
                          Text("${moedas}", style: TextStyle(color: cor == Colors.black87 ? Colors. white : Colors.black87),),
                        ],
                      ),
                    ),
                  ],
                ),
                Itens(Nome: "Cor de fundo", Item: "cor de fundo", Cor: "Vermelho",Posicao: "v", Preco: 5),
                Itens(Nome: "Cor de fundo", Item: "cor de fundo", Cor: "Roxo",Posicao: "a", Preco: 2000),
                Itens(Nome: "Cor de fundo", Item: "cor de fundo", Cor: "Preto",Posicao: "b", Preco: 2000),
                Itens(Nome: "Cor de fundo", Item: "cor de fundo", Cor: "Azul",Posicao: "c", Preco: 2000),
                Itens(Nome: "Cor de fundo", Item: "cor de fundo", Cor: "Ciano",Posicao: "d", Preco: 2000),
                Itens(Nome: "Cor de fundo", Item: "cor de fundo", Cor: "Teal",Posicao: "e", Preco: 2000),
                Itens(Nome: "Degradê", Item: "Degrade", Cor: "Degade",Posicao: "f", Preco: 50000),
              ],
            ),
          ),
        )
    );
  }
  Widget Itens({required String? Nome, required String Item, String? Cor, String? Posicao, required int Preco}){
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.brown,
            width: 3,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 4),
              child: Center(
                child: Text("$Nome", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ),
            ),
            Item == "cor de fundo" ?
            Container(
              height: 80,
              width: 80,
              color: Cor == "Roxo" ? Colors.purpleAccent :
              Cor == "Preto" ? Colors.black87  :
              Cor == "Azul" ? Colors.lightBlue :
              Cor == "Ciano" ? Colors.cyan :
              Cor == "Teal" ? Colors.teal :
              Cor == "Vermelho" ? Colors.white
                  : Colors.brown,
            ) :
            Item == "Degrade" ? Container(
              height: 80,
              width: 80,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        //Color(0XFFf82d48),
                        //Color(0XFFff1c36), //Color(0XFFff445d)
                        Colors.cyanAccent,
                        Colors.lightBlue,
                      ],
                      end: Alignment.bottomCenter,
                      begin: Alignment.topCenter
                  )
              ),
            ) :
            const Visibility(
                visible: false,
                child: Text("Oi")
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 4),
              child: GestureDetector(
                onTap: () async{
                  if(moedas < Preco && !listaDeProdutos.contains("$Posicao")){
                    await showDialog(
                      context:  context,
                      builder:  (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Você é pobre, brow!"),
                          content: const Text("Ganhe mais dinheiro jogando!"),
                          actions: [
                            TextButton(
                              child: const Text("Ok"),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      },
                    );
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Jogue um pouco mais para adquirir moedas!"),
                    ));
                  }else{
                    if(listaDeProdutos == null){
                      tiraMoedas(Preco);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("Compra realizada com sucesso!"),
                      ));
                      if(Item == "cor de fundo" || Item == "Degrade"){
                        colocaCor(Cor!, Posicao!);
                      }
                    }else if(listaDeProdutos.contains("$Posicao")){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("Escolha escolhida com sucesso! kkkk"),
                      ));
                      colocaCor(Cor!, Posicao!);
                    }else{
                      tiraMoedas(Preco);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        duration: Duration(seconds: 2),
                        content: Text("Compra realizada com sucesso!"),
                      ));
                      if(Item == "cor de fundo" || Item == "Degrade"){
                        colocaCor(Cor!, Posicao!);
                      }
                    }
                  }
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width-150,
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listaDeProdutos == null ? Icon(Icons.monetization_on, color: Colors.green,) : listaDeProdutos.contains("$Posicao") ? Icon(Icons.supervised_user_circle, color: Colors.black87,) : Icon(Icons.monetization_on, color: Colors.green,),
                          SizedBox(width: 6.0,),
                          listaDeProdutos == null ? Text("$Preco", style: TextStyle(fontSize: 22.0, color: Colors.black87, fontWeight: FontWeight.bold)) : listaDeProdutos.contains("$Posicao") ? Text("Escolher", style: TextStyle(fontSize: 22.0, color: Colors.black87, fontWeight: FontWeight.bold)) : Text("$Preco", style: TextStyle(fontSize: 22.0, color: Colors.black87, fontWeight: FontWeight.bold)),
                        ],
                      )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  colocaCor(String corr, String posicao) async{
    String? lugar;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cor", "$corr");
    lugar = prefs.getString("listaProdutos");
    if(lugar == null){
      prefs.setString("listaProdutos", "$posicao");
    }else{
      prefs.setString("listaProdutos", "${lugar}${posicao}");
    }
    fazTudo();
  }
  tiraMoedas(int quantidade) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    moedas = prefs.getInt('moedas')!;
    prefs.setInt('moedas', moedas - quantidade);
  }
}
