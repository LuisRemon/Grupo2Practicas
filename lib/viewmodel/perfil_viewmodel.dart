import 'package:flutter/material.dart';
import 'package:proyecto_sm/model/user_model.dart';

class PerfilViewModel {
  final UserData userData;

  PerfilViewModel({required this.userData});

  void unfocus(BuildContext context) {
    final unfocusNode = FocusScope.of(context);
    if (unfocusNode.canRequestFocus) {
      unfocusNode.requestFocus();
    } else {
      unfocusNode.unfocus();
    }
  }
}

class PerfilViewOptions {
  // Puedes agregar opciones adicionales aquí según sea necesario.
}