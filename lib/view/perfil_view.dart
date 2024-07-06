import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:proyecto_sm/model/auth_model.dart';
import 'package:proyecto_sm/view/mi_informacion_view.dart';
import 'package:proyecto_sm/view/mis_reservas_view.dart';
import 'package:proyecto_sm/viewmodel/mis_reservas_viewmodel.dart';
import 'package:proyecto_sm/model/user_model.dart';
import 'package:proyecto_sm/viewmodel/perfil_viewmodel.dart';

import 'login_view.dart'; // Importa el ViewModel

class Perfil extends StatefulWidget {
  final PerfilViewModel viewModel;

  const Perfil({Key? key, required this.viewModel}) : super(key: key);

  @override
  _Perfil createState() => _Perfil();
}

class _Perfil extends State<Perfil> {
  final unfocusNode = FocusNode();
  bool? switchValue;
  late final MisReservasViewModel reservarViewModel;
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  void initState() {
    super.initState();
    reservarViewModel = MisReservasViewModel(widget.viewModel.userData);
    //switchValue = widget.viewModel.switchValue;
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return GestureDetector(
      onTap: () => unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: const Color(0xFF4B39EF),
        body: Align(
          alignment: const AlignmentDirectional(0.00, 0.00),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 200,
                child: Stack(
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.00, 0.00),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                widget.viewModel.userData.foto,
                                width: 180,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 12),
                child: Text(
                  '${widget.viewModel.userData.nombre} ${widget.viewModel.userData.apellidoPaterno}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Outfit',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                child: Text(
                  '${widget.viewModel.userData.correo}',
                  style: const TextStyle(
                    fontFamily: 'ReadexPro',
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 400,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Color(0x33000000),
                        offset: Offset(0, -1),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                                child: Text(
                                  'Ajustes',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 24,
                                    color: Color(0xFF14181B),
                                  ),
                                ),
                              ),
                              OpcionAjustes(
                                context,
                                widget.viewModel.userData,
                                Icons.edit,
                                'Información personal',
                                'Editar Perfil',
                                MiInformacion(userData: widget.viewModel.userData),
                              ),
                              OpcionAjustes(
                                context,
                                widget.viewModel.userData,
                                Icons.calendar_month,
                                'Ver mis reservas',
                                'Historial',
                                MisReservas(viewModel: reservarViewModel),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                      child: Icon(
                                        Icons.notifications_active,
                                        color: Color(0xFF57636C),
                                        size: 24,
                                      ),
                                    ),
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                        child: Text(
                                          'Mostrar notificaciones',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'ReadexPro',
                                            color: Color(0xFF57636C),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Switch.adaptive(
                                      value: switchValue ?? true,
                                      onChanged: (newValue) {
                                        setState(() => switchValue = newValue);
                                      },
                                      activeColor: const Color(0xFF4B39EF),
                                      activeTrackColor: const Color(0x4D4B39EF),
                                      inactiveTrackColor: const Color(0xFFE0E3E7),
                                      inactiveThumbColor: const Color(0xFF57636C),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: InkWell(
                                  onTap: () => _showRatingDialog(context),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                        child: Icon(
                                          Icons.star,
                                          color: Color(0xFF57636C),
                                          size: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                          child: Text(
                                            'Califícanos',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'ReadexPro',
                                              color: Color(0xFF57636C),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Deja un comentario',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'ReadexPro',
                                          color: Color(0xFF4B39EF),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
                                child: InkWell(
                                  onTap: () {
                                    showLogoutDialog(context);
                                  },
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                        child: Icon(
                                          Icons.logout_rounded,
                                          color: Color(0xFF57636C),
                                          size: 24,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                                          child: Text(
                                            'Salir de mi cuenta',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'ReadexPro',
                                              color: Color(0xFF57636C),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Cerrar Sesión',
                                        style: TextStyle(
                                          fontFamily: 'ReadexPro',
                                          color: Color(0xFF4B39EF),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Personaliza el radio de los bordes
          ),
          backgroundColor: const Color(0xFFEAE7FD),
          title: const Text('Cerrar sesión'),
          content: const Text('¿Está seguro de que desea cerrar sesión?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Cancelar', style: TextStyle(color: Color(0xFF4B39EF))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: const Text('Cerrar sesión', style: TextStyle(color: Color(0xFF4B39EF))),
              onPressed: () {
                _auth.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginAppView(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showRatingDialog(BuildContext context) {
    // actual store listing review & rating
    void _rateAndReviewApp() async {
      // refer to: https://pub.dev/packages/in_app_review
      final _inAppReview = InAppReview.instance;

      if (await _inAppReview.isAvailable()) {
        print('request actual review from store');
        _inAppReview.requestReview();
      } else {
        print('open actual store listing');
        // TODO: use your own store ids
        _inAppReview.openStoreListing(
          appStoreId: '<your app store id>',
          microsoftStoreId: '<your microsoft store id>',
        );
      }
    }

    final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: const Text(
        'Puntúanos',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: const Text(
        '¿Te está gustando nuestra aplicación? ¡Califícanos y déjanos tus comentarios.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: Image.asset('assets/images/logo_reservatech_morado.png', width: 100, height: 100),
      submitButtonText: 'Enviar',
      commentHint: '¡Deja tu comentario!',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          _rateAndReviewApp();
        }
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }
}

Widget OpcionAjustes(BuildContext context, UserData userData, IconData icono, String nombreOpcion, String detalleOpcion, Widget ventana) {
  return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
      child: InkWell(
        onTap: () {
          if (userData != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ventana,
              ),
            );
          } else {
          // Manejar el caso en el que userData es nulo
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
              child: Icon(
                icono,
                color: const Color(0xFF57636C),
                size: 24,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                child: Text(
                  nombreOpcion,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'ReadexPro',
                    color: Color(0xFF57636C),
                  ),
                ),
              ),
            ),
            Text(
              detalleOpcion,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'ReadexPro',
                color: Color(0xFF4B39EF),
                fontSize: 14,
              ),
            ),
          ],
        ),
      )
  );
}