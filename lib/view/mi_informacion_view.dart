import 'package:flutter/material.dart';
import 'package:proyecto_sm/model/user_model.dart';
import 'package:proyecto_sm/viewmodel/mi_informacion_viewmodel.dart';

import '../utils/formulario_mediator.dart';

class MiInformacion extends StatefulWidget {
  final UserData userData;
  const MiInformacion({Key? key, required this.userData}) : super(key: key);

  @override
  _MiInformacionState createState() => _MiInformacionState();
}

class _MiInformacionState extends State<MiInformacion> {
  late MiInformacionViewModel _viewModel;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _viewModel = MiInformacionViewModel(widget.userData);
    // _viewModel.textController1.text = widget.userData.nombre;
    // _viewModel.textController2.text = widget.userData.apellidoPaterno;
    // _viewModel.textController3.text = widget.userData.apellidoMaterno;
    // _viewModel.textController4.text = widget.userData.ciclo;
    // _viewModel.textController5.text = widget.userData.escuelaProfesional;
    // _viewModel.textController6.text = widget.userData.codigo.toString();
    // _viewModel.textController7.text = widget.userData.correo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B39EF),
        title: const Text(
          'Información Personal',
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'ReadexPro',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 24, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Tu información',
                      style: TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 24,
                        color: Color(0xFF14181B),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CampoTexto(
                      context,
                      _viewModel.mediator.textController1,
                      'Nombres',
                      _viewModel.textController1Validator,
                    ),
                    CampoTexto(
                      context,
                      _viewModel.mediator.textController2,
                      'Apellido Paterno',
                      _viewModel.textController2Validator,
                    ),
                    CampoTexto(
                      context,
                      _viewModel.mediator.textController3,
                      'Apellido Materno',
                      _viewModel.textController3Validator,
                    ),
                    CampoTexto(
                      context,
                      _viewModel.mediator.textController4,
                      'Ciclo',
                      _viewModel.textController4Validator,
                    ),
                    CampoTexto(
                      context,
                      _viewModel.mediator.textController5,
                      'Escuela Profesional',
                      _viewModel.textController5Validator,
                    ),
                    CampoTexto(
                      context,
                      _viewModel.mediator.textController6,
                      'Código',
                      _viewModel.textController6Validator,
                    ),
                    CampoTexto(
                      context,
                      _viewModel.mediator.textController7,
                      'Correo institucional',
                      _viewModel.textController7Validator,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 44),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 16),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              backgroundColor: Colors.white,
                              foregroundColor: const Color(0xFF14181B),
                              minimumSize: const Size(230.0, 52.0),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: Color(0xFFE0E3E7),
                                  width: 2,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'ReadexPro',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: const AlignmentDirectional(0.00, 0.00),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 16),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_viewModel.mediator.isValid()) {
                                setState(() {
                                  _viewModel.updateUserInformation();
                                });
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Por favor, completa todos los campos correctamente.'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              backgroundColor: const Color(0xFF4B39EF),
                              foregroundColor: Colors.white,
                              minimumSize: const Size(230.0, 52.0),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Guardar cambios',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'ReadexPro',
                              ),
                            ),
                          ),
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
    );
  }
}

Widget CampoTexto(BuildContext context, TextEditingController controller, String label, String? Function(String?)? validator) {
  return Row(
    mainAxisSize: MainAxisSize.max,
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
          child: TextFormField(
            controller: controller,
            obscureText: false,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'ReadexPro',
                color: Color(0xFF57636C),
              ),
              hintStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'ReadexPro',
                color: Color(0xFF57636C),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFE0E3E7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF4B39EF),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFFF5963),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFFFF5963),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.white,
              errorText: validator != null ? validator(controller.text) : null,
            ),
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'ReadexPro',
              color: Color(0xFF57636C),
            ),
            validator: validator,
          ),
        ),
      ),
    ],
  );
}