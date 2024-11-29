import 'package:flutter/material.dart';
import 'package:smartboss/Finalizar_Rotas.dart';
import 'Cadastrar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IniciarRotas extends StatefulWidget {
  const IniciarRotas({super.key});

  @override
  _IniciarRotasState createState() => _IniciarRotasState();
}

class _IniciarRotasState extends State<IniciarRotas> {
  String? rotaselecionada;
  String nomeMotorista = 'Desconhecido';
  String horarioSaida = '00:00';

  @override
  void initState() {
    super.initState();
    _loadSelectedRoute();
  }

  Future<void> _loadSelectedRoute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rotaselecionada = prefs.getString('selectedRoute');
      _setRouteDetails(rotaselecionada);
    });
  }

  void _setRouteDetails(String? route) {
    switch (route) {
      case '1':
        nomeMotorista = 'Vanderlei';
        horarioSaida = '07:20';
        break;
      case '2':
        nomeMotorista = 'Carlos';
        horarioSaida = '07:22';
        break;
      case '3':
        nomeMotorista = 'Jorge';
        horarioSaida = '07:25';
        break;
      case '4':
        nomeMotorista = 'Luiz';
        horarioSaida = '07:30';
        break;
      default:
        nomeMotorista = 'Paulo';
        horarioSaida = '07:15';
        break;
    }
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
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.account_box_outlined,
            color: Colors.greenAccent,
            size: 100,
          ),
          SizedBox(height: 10),
          Text(
            'Veja se suas informações estão certas',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Motorista: ',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(width: 5),
              Text(
                nomeMotorista,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rota: ',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                rotaselecionada ?? 'Nenhuma rota selecionada',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Horário de Saída: ',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                horarioSaida,
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
                context,
                MaterialPageRoute(builder: (context) => FinalizarRotas()),
              );
            },
            child: Text('Iniciar Rota', style: TextStyle(color: Colors.black)),
          ),
        ]),
      ),
    );
  }
}
