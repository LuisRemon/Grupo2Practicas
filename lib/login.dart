import 'package:flutter/material.dart';
import 'barra_inferior.dart';
import 'package:proyecto_sm/model/auth_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto_sm/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto_sm/api_connection/api_connection.dart';

class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proyecto',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4B39EF)),
          useMaterial3: true,
        ),
        home: const Scaffold(body: MyHomeLoginApp())
    );
  }
}

class MyHomeLoginApp extends StatefulWidget {
  const MyHomeLoginApp({super.key});

  @override
  State<MyHomeLoginApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomeLoginApp> {
  String? errorMessage = '';//
  bool isLogin = true;

  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  get userdatos => null;

  @override
  void dispose(){
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  static final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@unmsm\.edu\.pe$");

  bool _esEmail(String str)
  {
    return _emailRegExp.hasMatch(str.toLowerCase());
  }

  // Widget _errorMessage() {
  //   return Text(errorMessage == '' ? '' : '$errorMessage');
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              //const SizedBox(height: 40),
              //Center(
              Container(
                width: double.infinity,
                height: 350,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4B39EF), // #4B39EF
                      Color(0xFFFF5963), // #FF5963
                      Color(0xFFEE8B60), // #EE8B60
                    ],
                    stops: [0, 0.5, 1],
                    begin: AlignmentDirectional(-1, -1),
                    end: AlignmentDirectional(1, 1),
                  ),
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x00FFFFFF),
                        Colors.white,
                      ],
                      stops: [0, 1],
                      begin: AlignmentDirectional(0, -1),
                      end: AlignmentDirectional(0, 1),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 170,
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white60,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0.00, 0.00),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/images/logo_reservatech_morado.png',
                              width: 118,
                              height: 138,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 50),
                child: Column(
                  children: [
                    // const SizedBox(height: 40),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Correo Institucional',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: _controllerEmail,
                      validator: (value) {
                        if (!_esEmail(value.toString())){
                          return 'Ingrese su correo correctamente';
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: _controllerPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese su contraseña';
                        }
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // _signIn();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    // iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    backgroundColor: const Color(0xFF4B39EF),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(230.0, 50.0),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Bordes redondeados del botón
                      side: const BorderSide(
                        color: Colors.transparent, // Color del borde
                        width: 1, // Ancho del borde
                      ),
                    ),
                  ),
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'ReadexPro',
                        color: Colors.white
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void _signIn() async {
  //   String email = _controllerEmail.text;
  //   String password = _controllerPassword.text;
  //
  //   User? user = await _auth.signInWithEmailAndPassword(email, password);
  //   if(user != null) {
  //     print("User is successfully signedIn");
  //     final response = await http.post(
  //         Uri.parse(API.consultalogin),
  //         body: {
  //           "correo": user.email,
  //         },
  //       );
  //
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //
  //       if (data['success']) {
  //         setState(() {
  //           UserData userdatos = UserData(
  //               nombre: data['nombre'],
  //               apellidoPaterno: data['apellido_paterno'],
  //               apellidoMaterno: data['apellido_materno'],
  //               ciclo: data['ciclo'],
  //               codigo: data['codigo'],
  //               correo: data['correo'],
  //               escuelaProfesional: data['escuela_profesional'],
  //               foto: data['foto']
  //           );
  //         });
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => MyAppBarra(userData: userdatos),
  //         ),
  //         // (Route<dynamic> route) => false, // Esta función siempre devuelve false, eliminando todas las rutas anteriores.
  //       );
  //       } else {
  //           // Manejar el caso en el que no se encontraron registros.
  //       }
  //     }else {
  //       // Manejar errores de conexión.
  //     }
  //   }else {
  //     print("Some error happened");
  //   }
  // }
}