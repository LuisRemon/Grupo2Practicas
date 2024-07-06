import 'package:flutter/material.dart';
import 'view/inicio_view.dart';
//import 'pages/perfil.dart';
import 'package:proyecto_sm/model/user_model.dart';
import 'package:proyecto_sm/view/reservar_view.dart';
import 'package:proyecto_sm/viewmodel/reservar_viewmodel.dart';
import 'package:proyecto_sm/view/perfil_view.dart';
import 'package:proyecto_sm/viewmodel/perfil_viewmodel.dart';

class MyAppBarra extends StatefulWidget {
  final UserData userData;

  MyAppBarra({required this.userData});

  @override
  _MyAppState createState() => _MyAppState(userData);
}

class _MyAppState extends State<MyAppBarra> {
  int paginaActual = 0;
  late List<Widget> paginas;
  final UserData userData;
  late ReservarViewModel viewModelReservar;
  late PerfilViewModel viewModelPerfil;

  _MyAppState(this.userData){
    viewModelReservar = ReservarViewModel(userData: userData);
    viewModelPerfil = PerfilViewModel(userData: userData);
  }

  @override
  void initState() {
    super.initState();
    paginas = [
      Inicio(userData: userData),
      ReservarView(viewModel: viewModelReservar),
      Perfil(viewModel: viewModelPerfil),
      //Perfil(userData: userData),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4B39EF),
          automaticallyImplyLeading: false,
          // leading: IconButton(
          //   icon: const Icon(
          //     Icons.arrow_back_rounded,
          //     color: Color(0xFF101213),
          //     size: 30,
          //   ),
          //   onPressed: () async {
          //     //context.pop();
          //   },
          // ),
          title: const Text(
            'ReservaTech',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Outfit',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(
          //       Icons.settings,
          //       color: Colors.white,
          //       size: 24,
          //     ),
          //     onPressed: () {
          //
          //     },
          //   ),
          // ],
          centerTitle: true,
          elevation: 0,
        ),
        body: paginas[paginaActual],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              paginaActual = index;
            });
          },
          currentIndex: paginaActual,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_module),
              label: 'Reservar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Perfil',
            ),
          ],
          selectedItemColor: const Color(0xFF4B39EF),
        ),
      ),
    );
  }
}