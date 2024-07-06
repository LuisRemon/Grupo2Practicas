import 'package:flutter/material.dart';
import 'package:proyecto_sm/viewmodel/login_viewmodel.dart';

class LoginAppView extends StatelessWidget {
  const LoginAppView({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación de Inicio de Sesión',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4B39EF)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white, // Establece el color de la flecha de regreso a blanco
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold( // Agregar un Scaffold o widget de Material como ancestro
        body: MyHomeLoginApp(viewModel: LoginViewModel()),
      ),
    );
  }
}

class MyHomeLoginApp extends StatefulWidget {
  final LoginViewModel viewModel;

  const MyHomeLoginApp({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<MyHomeLoginApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomeLoginApp> {
  @override
  Widget build(BuildContext context) {
    final viewModel = widget.viewModel;

    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: viewModel.formKey,
          child: Column(
            children: <Widget>[
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
                      controller: viewModel.emailController,
                      validator: (value) {
                        if (!viewModel.isEmailValid(value.toString())){
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
                      controller: viewModel.passwordController,
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
                    if (viewModel.formKey.currentState!.validate()) {
                      viewModel.AdapterSignIn(context);
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
}