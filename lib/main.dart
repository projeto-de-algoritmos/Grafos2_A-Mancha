import 'package:flutter/material.dart';
import 'package:nuvem/Inicial.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nuvem/Jogo.dart';
import 'package:nuvem/ProximoJogo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/Jogo': (context) => const Jogo(),
        '/Inicial': (context) => const Inicial(),
        '/ProximoJogo': (context) => const ProximoJogo(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Inicial(),
    );
  }
}
