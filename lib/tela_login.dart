import 'package:flutter/material.dart';
import 'Rotas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final usuario = TextEditingController(text: 'motorista@gmail.com');
  final senha = TextEditingController(text: 'password');

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 110.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.white,
                ),
                Text(
                  'Faça seu login',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    controller: usuario,
                    decoration: const InputDecoration(
                      label: Text("Usuario",
                          style: TextStyle(color: Colors.white)),
                      hintText: "Insira seu Usuario",
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "E-mail não pode ser vazio.";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    controller: senha,
                    decoration: const InputDecoration(
                        label: Text("Senha",
                            style: TextStyle(color: Colors.white)),
                        hintText: "Insira a senha",
                        prefixIcon: Icon(Icons.password, color: Colors.white),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        )),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Senha não pode ser vazia.";
                      }
                      if (value.length < 6 || value.length > 10) {
                        return "A senha deve ter de 6 a 10 caracteres.";
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff79cbf0),
                      textStyle: TextStyle(color: Colors.black),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      final url = Uri.parse(
                          'https://smartbus.ibiruba.ifrs.edu.br/api/login');

                      final headers = {
                        'Content-Type': 'application/json',
                      };

                      final body = jsonEncode(
                          {'email': usuario.text, 'password': senha.text});

                      final response =
                          await http.post(url, headers: headers, body: body);
                      if (response.statusCode == 200) {
                        final Map<String, dynamic> jR =
                            jsonDecode(response.body);
                        final token = jR['token']['plainTextToken'];

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Rotas(token: token)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Usuário ou senha incorretos'),
                                backgroundColor: Colors.redAccent));
                      }
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.black)
                      : Text('Entrar', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
