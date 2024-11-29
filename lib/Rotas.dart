import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Iniciar_Rotas.dart';

class Rotas extends StatefulWidget {
  final String token;

  const Rotas({required this.token, super.key});

  @override
  _RotasState createState() => _RotasState();
}

class _RotasState extends State<Rotas> {
  String? _selectedRoute;
  String? _errorMessage;
  List<dynamic> _rotas = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRoutes();
  }

  Future<void> _fetchRoutes() async {
    const String url = 'https://smartbus.ibiruba.ifrs.edu.br/api/pegarrotas';

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${widget.token}', // Token recebido no construtor
      'Accept': 'application/json',
    };

    try {
      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          _rotas = jsonDecode(response.body);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage =
              'Erro ao carregar rotas. Código: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Erro na requisição: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveSelectedRoute(String route) async {
    // Lógica para salvar a rota selecionada
    print('Rota selecionada salva: $route');
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
        child: _isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions,
                    color: Colors.white,
                    size: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Escolha a rota que você irá fazer',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    hint: Text(
                      'Selecione a rota',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: _selectedRoute,
                    dropdownColor: Color(0xff79cbf0),
                    items: _rotas.map((rota) {
                      return DropdownMenuItem<String>(
                        value: rota['id'].toString(),
                        child: Row(
                          children: [
                            Icon(Icons.directions_bus, color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              rota['nome'],
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRoute = newValue;
                        _errorMessage = null;
                      });
                      _saveSelectedRoute(newValue!);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff79cbf0),
                      textStyle: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      if (_selectedRoute != null) {
                        print('Rota confirmada: $_selectedRoute');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IniciarRotas()),
                        );
                      } else {
                        setState(() {
                          _errorMessage = 'Por favor, selecione uma rota.';
                        });
                      }
                    },
                    child: Text(
                      'Confirmar Rota',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 10),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
