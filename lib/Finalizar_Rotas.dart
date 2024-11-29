import 'package:flutter/material.dart';
import 'package:smartboss/tela_principal.dart';
import 'Rotas.dart';
import 'dart:async';

class FinalizarRotas extends StatefulWidget {
  const FinalizarRotas({super.key});

  @override
  _FinalizarRotasState createState() => _FinalizarRotasState();
}

class _FinalizarRotasState extends State<FinalizarRotas> {
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  String get _formattedTime {
    int minutes = _seconds ~/ 60;
    int seconds = _seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff053247),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bus_alert,
              color: Colors.white,
              size: 100,
            ),
            SizedBox(height: 10),
            Text(
              'Rota em andamento',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tempo de rota: ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  _formattedTime,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff79cbf0),
                textStyle: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => TelaPrincipal()));
              },
              child: Text('Finalizar Rota',
                  style:TextStyle(color: Colors.black)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
