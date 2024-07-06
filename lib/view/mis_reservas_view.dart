import 'package:flutter/material.dart';
import 'package:proyecto_sm/model/reserva_model.dart';
import 'package:proyecto_sm/viewmodel/mis_reservas_viewmodel.dart';

import 'calendario_view.dart';

class MisReservas extends StatefulWidget {
  final MisReservasViewModel viewModel;

  const MisReservas({required this.viewModel});

  @override
  _MisReservasState createState() => _MisReservasState();
}

class _MisReservasState extends State<MisReservas> {
  List<Reserva> listaActivas = [];
  List<Reserva> listaPasadas = [];
  List<Reserva> listaCanceladas = [];

  @override
  void initState() {
    super.initState();
    widget.viewModel.onReservasUpdated = _actualizarReservas;
    obtenerReservas();
  }

  Future<void> obtenerReservas() async {
    List<Reserva> reservasActivas = await widget.viewModel.getReservas(1, widget.viewModel.userData.codigo);
    List<Reserva> reservasPasadas = await widget.viewModel.getReservas(2, widget.viewModel.userData.codigo);
    List<Reserva> reservasCanceladas = await widget.viewModel.getReservas(3, widget.viewModel.userData.codigo);

    setState(() {
      listaActivas = reservasActivas;
      listaPasadas = reservasPasadas;
      listaCanceladas = reservasCanceladas;
    });
  }

  void _actualizarReservas() {
    obtenerReservas();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: const Color(0xFFF1F4F8),
          appBar: AppBar(
            backgroundColor: const Color(0xFF4B39EF),
            title: const Text(
              'Mis Reservas',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'ReadexPro',
                  fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            bottom: const TabBar(
                indicatorColor: Colors.white,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ReadexPro',
                ),
                tabs: [
                  Tab(text: 'Activas'),
                  Tab(text: 'Pasadas'),
                  Tab(text: 'Canceladas'),
                ]
            ),
            // elevation: 0,
          ),
          body: TabBarView(
            children: <Widget>[
              Activas(listaActivas, context, widget.viewModel),
              Pasadas(listaPasadas),
              Canceladas(listaCanceladas)
            ],
          ),
        )
    );
  }
}

Widget aulaReservadaActiva(BuildContext context, int idReserva, int idSalon, String aula, String pabellon, String fecha, String dia, int horaInicio, int horaFin, String imagePath, MisReservasViewModel viewModel) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
    child: Container(
      width: 220,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E3E7),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://reservatech.azurewebsites.net/images/$imagePath',
                //'assets/images/$imagePath',
                width: 192,
                height: 144,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            iconSize: 20,
                            icon: const Icon(Icons.delete),
                            color: const Color(0xFF57636C),
                            onPressed: () {
                              showBorrarReserva(context, viewModel, idReserva, idSalon, pabellon, dia, horaInicio, horaFin);
                            },
                          ),
                        ],
                      ),
                      Text(
                        aula,
                        style: const TextStyle(
                          fontFamily: 'ReadexPro',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF14181B),
                        ),
                      ),
                      Text(
                        pabellon,
                        style: const TextStyle(
                          fontFamily: 'ReadexPro',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF57636C),
                        ),
                      ),
                      Text(
                        fecha,
                        style: const TextStyle(
                          fontFamily: 'ReadexPro',
                          fontSize: 14,
                          color: Color(0xFF57636C),
                        ),
                      ),
                      Text(
                        '$horaInicio:00 - $horaFin:00',
                        style: const TextStyle(
                          fontFamily: 'ReadexPro',
                          fontSize: 14,
                          color: Color(0xFF57636C),
                        ),
                      ),
                    ],
                  ),
                ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget aulaReservada(String aula, String pabellon, String fecha, String hora, String imagePath) {
  return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
    child: Container(
      width: 220,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Color(0x33000000),
            offset: Offset(0, 2),
          )
        ],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE0E3E7),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://reservatech.azurewebsites.net/images/$imagePath',
                //'assets/images/$imagePath',
                width: 192,
                height: 144,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 0, 8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aula,
                    style: const TextStyle(
                      fontFamily: 'ReadexPro',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF14181B),
                    ),
                  ),
                  Text(
                    pabellon,
                    style: const TextStyle(
                      fontFamily: 'ReadexPro',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF57636C),
                    ),
                  ),
                  Text(
                    fecha,
                    style: const TextStyle(
                      fontFamily: 'ReadexPro',
                      fontSize: 14,
                      color: Color(0xFF57636C),
                    ),
                  ),
                  Text(
                    hora,
                    style: const TextStyle(
                      fontFamily: 'ReadexPro',
                      fontSize: 14,
                      color: Color(0xFF57636C),
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

showBorrarReserva(BuildContext context, MisReservasViewModel viewModel, int idReserva, int idSalon, String pabellon, String dia, int horaInicio, int horaFin) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0), // Personaliza el radio de los bordes
        ),
        backgroundColor: const Color(0xFFEAE7FD),
        title: const Text('Borrar reserva'),
        content: const Text('¿Está seguro de que desea cancelar la reserva?'),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            child: const Text('Atrás', style: TextStyle(color: Color(0xFF4B39EF))),
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
            child: const Text('Borrar', style: TextStyle(color: Color(0xFF4B39EF))),
            onPressed: () {
              viewModel.updateReserva(idReserva);
              viewModel.updateDisponibilidad(idSalon, pabellon, dia, horaInicio, horaFin);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget Activas(List<Reserva> listaActivas, BuildContext context, MisReservasViewModel viewModel) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget> [
        Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Calendario(lista: listaActivas)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4B39EF),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(200.0, 40.0),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Bordes redondeados del botón
                          side: const BorderSide(
                            color: Colors.transparent, // Color del borde
                            width: 1, // Ancho del borde
                          ),
                        ),
                      ),
                      child: const Text('Ver Calendario',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: 'Outfit'
                          )
                      )
                  )
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F4F8),//Color(0xFFF1F4F8),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 44),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: listaActivas.map((reserva) {
                            return aulaReservadaActiva(
                              context,
                              reserva.idReserva,
                              reserva.idSalon,
                              reserva.nombre,
                              reserva.pabellon,
                              reserva.fecha,
                              reserva.dia,
                              reserva.horaInicio,
                              reserva.horaFin,
                              reserva.imagen,
                              viewModel
                            );
                          }).toList(),
                          // [
                          //   aulaReservada(context, 'Aula 101', '05/10/23', '10:00 AM - 12:00 PM', 'assets/images/aula101.jpg'),
                          // ]
                        ),
                      ),
                    ]
                ),
              ),
            ]
        )
      ],
    ),
  );
}

Widget Pasadas(List<Reserva> listaPasadas) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget> [
        Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F4F8),//Color(0xFFF1F4F8),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 44),
                        child: ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: listaPasadas.map((reserva) {
                              return aulaReservada(
                                  reserva.nombre,
                                  reserva.pabellon,
                                  reserva.fecha,
                                  '${reserva.horaInicio}:00 - ${reserva.horaFin}:00',
                                  reserva.imagen
                              );
                            }).toList(),
                            // [
                            //   aulaReservada('Aula 102', '05/10/23', '10:00 AM - 12:00 PM', 'assets/images/aula102.jpg'),
                            //   aulaReservada('Aula 103', '04/10/23', '03:00 PM - 05:00 PM', 'assets/images/aula103.jpg'),
                            //   aulaReservada('Aula 104', '03/10/23', '04:00 PM - 06:00 PM', 'assets/images/aula104.jpg'),
                            // ]
                        ),
                      ),
                    ]
                ),
              ),
            ]
        )
      ],
    ),
  );
}

Widget Canceladas(List<Reserva> listaCanceladas) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget> [
        Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF1F4F8),//Color(0xFFF1F4F8),
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 44),
                        child: ListView(
                            padding: EdgeInsets.zero,
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: listaCanceladas.map((reserva) {
                              return aulaReservada(
                                  reserva.nombre,
                                  reserva.pabellon,
                                  reserva.fecha,
                                  '${reserva.horaInicio}:00 - ${reserva.horaFin}:00',
                                  reserva.imagen
                              );
                            }).toList(),
                            // [
                            //   aulaReservada('Aula 101', '03/10/23', '04:00 PM - 06:00 PM', 'assets/images/aula101.jpg'),
                            // ]
                        ),
                      ),
                    ]
                ),
              ),
            ]
        )
      ],
    ),
  );
}