import 'package:flutter/material.dart';
import 'package:proyecto_sm/utils/formulario_mediator.dart'; // Importar el formulario_mediator.dart
import 'package:proyecto_sm/model/user_model.dart';

class MiInformacionViewModel {
  late final FormularioMediator _mediator;
  final UserData userData;

  MiInformacionViewModel(this.userData) {
    _mediator = FormularioMediator(this); // Pasa una referencia del ViewModel al mediador
  }

  FormularioMediator get mediator => _mediator;

  String? textController1Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce tu nombre';
    }
    return null;
  }

  String? textController2Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce tu apellido paterno';
    }
    return null;
  }

  String? textController3Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce tu apellido materno';
    }
    return null;
  }

  String? textController4Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce tu ciclo';
    }
    return null;
  }

  String? textController5Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce tu escuela profesional';
    }
    return null;
  }

  String? textController6Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce tu código';
    }
    return null;
  }

  String? textController7Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, introduce tu correo';
    }
    return null;
  }

  void updateUserInformation() async {
    _mediator.updateUserInformation();
  }
}
