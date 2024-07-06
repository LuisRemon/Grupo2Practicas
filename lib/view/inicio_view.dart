import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyecto_sm/model/auth_model.dart';
import 'package:proyecto_sm/model/user_model.dart';
import 'package:proyecto_sm/view/predicciones_view.dart';
import 'package:proyecto_sm/viewmodel/predicciones_viewmodel.dart';
import 'package:proyecto_sm/view/mis_reservas_view.dart';
import 'package:proyecto_sm/viewmodel/mis_reservas_viewmodel.dart';

class Inicio extends StatelessWidget {
  //Inicio({super.key});
  final UserData userData;

  Inicio({required this.userData});

  final User? user = FirebaseAuthService().currentUser;
  // final reservarViewModel = MisReservasViewModel();
  final prediccionViewModel = misPrediccionViewModel();
  //
  // Future<void> signOut() async {
  //   await Auth().signOut();
  // }

  @override
  Widget build(BuildContext context) {
    final MisReservasViewModel reservasViewModel = MisReservasViewModel(userData);

    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Bienvenido, ${userData.nombre} ${userData.apellidoPaterno}',
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Icon(
              Icons.location_history,
              color: Colors.black,
              size: 150,
            ),
            const SizedBox(height: 20),
            const Text(
              '¿Qué deseas hacer?',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Outfit',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            buildCenteredContainer('Ver\nmi\nhorario','assets/images/Ver_Horario.jpg',220,142, context, MisReservas(viewModel: reservasViewModel)),
            const SizedBox(height: 30),
            buildCenteredContainer('Ver\npredicción','assets/images/Reservar_Salon.jpg',220,142, context, PrediccionWidget(viewModel: prediccionViewModel)),
          ],
        ),
      ),
    );
  }
}

Widget buildCenteredContainer(String text, String imagePath, double largo, double alto, BuildContext context, Widget ventana) {
  return Container(
    width: 380.0,
    height: 162.0,
    decoration: BoxDecoration(
      color: const Color(0xFFF9F3F3),
      borderRadius: BorderRadius.circular(10.0),
    ),
    padding: const EdgeInsets.all(10.0),
    child: Column(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0), // El valor controla la circularidad del borde
              child: Image.asset(
                imagePath,
                width: largo,
                height: alto,
              ),
            ),
            SizedBox(
              width: 140.0, // Ancho deseado para el contenedor del texto y el botón
              child: Column(
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'ReadexPro',
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ventana,
                          ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(100, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xFF4B39EF),
                    ),
                    child: const Text(
                      'Ir ahora',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

}