import 'package:flutter/material.dart';
import 'package:smartboss/Finalizar_Rotas.dart';
import 'tela_principal.dart';
import 'tela_login.dart';
import 'Cadastrar.dart';
import 'Iniciar_Rotas.dart';
import 'Finalizar_Rotas.dart';

void main() {
  runApp(MaterialApp(
    home: MeuApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MeuApp extends StatefulWidget {
  @override
  State<MeuApp> createState() => _MeuAppState();
}

class _MeuAppState extends State<MeuApp> {
  int indiceAtual = 0;

  List telas = [
    TelaPrincipal(),
    Login(),
    Cadastro(),
    IniciarRotas(),
    FinalizarRotas()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff79cbf0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Smart',
              style: TextStyle(fontSize: 28),
            ),
            Icon(Icons.directions_bus_filled_outlined),
            Text(
              'Bus',
              style: TextStyle(fontSize: 28),
            ),
          ],
        ),
      ),
      body: telas[indiceAtual],
    );
  }

  void quandoClicar(int index) {
    setState(() {
      indiceAtual = index;
    });
  }
}
