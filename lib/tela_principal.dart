import 'package:flutter/material.dart';
import 'tela_login.dart';
import 'Cadastrar.dart';

class TelaPrincipal extends StatelessWidget {
  const TelaPrincipal({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff053247),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'SmartBus',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Icon(
              Icons.directions_bus,
              color: Colors.white,
              size: 100,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff79cbf0),
                textStyle: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text('Logar',
                  style:TextStyle(color: Colors.black)
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff79cbf0),
                textStyle: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cadastro()));
              },
              child: Text('Cadastrar-se',
                  style:TextStyle(color: Colors.black)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
