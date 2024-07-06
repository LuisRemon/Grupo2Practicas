import 'package:flutter/material.dart';
import 'package:proyecto_sm/model/user_model.dart';
import '../viewmodel/mi_informacion_viewmodel.dart';

class FormularioMediator {
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late TextEditingController textController4;
  late TextEditingController textController5;
  late TextEditingController textController6;
  late TextEditingController textController7;

  late MiInformacionViewModel _viewModel;

  FormularioMediator(this._viewModel) {
    UserData userData = _viewModel.userData;
    textController1 = TextEditingController(text: userData.nombre);
    textController2 = TextEditingController(text: userData.apellidoPaterno);
    textController3 = TextEditingController(text: userData.apellidoMaterno);
    textController4 = TextEditingController(text: userData.ciclo);
    textController5 = TextEditingController(text: userData.escuelaProfesional);
    textController6 = TextEditingController(text: userData.codigo.toString());
    textController7 = TextEditingController(text: userData.correo);
  }

  bool isValid() {
    return _viewModel.textController1Validator(textController1.text) == null &&
        _viewModel.textController2Validator(textController2.text) == null &&
        _viewModel.textController3Validator(textController3.text) == null &&
        _viewModel.textController4Validator(textController4.text) == null &&
        _viewModel.textController5Validator(textController5.text) == null &&
        _viewModel.textController6Validator(textController6.text) == null &&
        _viewModel.textController7Validator(textController7.text) == null;
  }

  void updateUserInformation() {
    _viewModel.userData.nombre = textController1.text;
    _viewModel.userData.apellidoPaterno = textController2.text;
    _viewModel.userData.apellidoMaterno = textController3.text;
    _viewModel.userData.ciclo = textController4.text;
    _viewModel.userData.escuelaProfesional = textController5.text;
    _viewModel.userData.codigo = int.tryParse(textController6.text) ?? 0;
    _viewModel.userData.correo = textController7.text;
  }
}