import 'package:flutter/material.dart';
import 'package:proyecto_sm/viewmodel/reservar_viewmodel.dart';
import 'package:proyecto_sm/model/salon_model.dart';
import 'package:proyecto_sm/view/calendario_view.dart';
import 'package:intl/intl.dart';
import 'package:time_range_picker/time_range_picker.dart';

var textoCalendario = "  Escoge tu fecha";
var textoHorario = "  Escoge tu horario";

class ReservarView extends StatefulWidget {
  final ReservarViewModel viewModel;

  ReservarView({required this.viewModel});

  @override
  _ReservarViewState createState() => _ReservarViewState();
}

class _ReservarViewState extends State<ReservarView> {
  var predValue = "Cargando..."; // Texto de carga inicial
  List<Salon> listaSalones = [];
  List<Salon> salonesFiltrados = [];

  // List<String> itemsinicio = ['Inicio','8', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19'];
  // List<String> itemsfin = ['Fin', '9', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'];
  // String selectedItemInicio = "Inicio";
  // String selectedItemFin = "Fin";

  DateTime selectedDate = DateTime.now();
  bool mostrarSalonesFiltrados = false;
  String formattedSelectedDate = '';
  int? horaInicioSeleccionada;
  int? horaFinSeleccionada;

  String fechaPopup = '';
  String diaSemana = '';
  int? horaInicioPopup;
  int? horaFinPopup;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obtenerSalones();
    textoCalendario = "  Escoge tu fecha";
    textoHorario = "  Escoge tu horario";

    searchController.addListener(() {
      aplicarFiltroPorNombre(searchController.text);
    });
  }

  Future<void> obtenerSalones() async {
    List<Salon> salones = await ReservarViewModel(userData: widget.viewModel.userData).getSalones(); // Llama a la función para obtener la lista de salones
    // formattedSelectedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
    // print(formattedSelectedDate);

    // for (var objeto in salones) {
    //   print('Nombre: ${objeto.nombre}');
    //   for (var disp in objeto.disponibilidades) {
    //     print('Salon: ${disp.idSalon}, Día: ${disp.dia}, Hora inicio: ${disp.horaInicio}, Hora fin: ${disp.horaFin}, Estado: ${disp.estado}');
    //   }
    //   print('------');
    // }
    setState(() {
      listaSalones = salones; // Almacena la lista de salones en el estado del widget
      //salonesFiltrados = salones;
    });
  }

  void aplicarFiltro() {
    // Filtra la lista de salones según las selecciones del DatePicker y los Dropdowns
    salonesFiltrados = listaSalones.where((salon) {
      final fechaSeleccionada = selectedDate.toLocal();
      diaSemana = obtenerDiaSemana(fechaSeleccionada); // Obtiene el día de la semana
      // final horaInicioSeleccionada = int.tryParse(selectedItemInicio);
      // final horaFinSeleccionada = int.tryParse(selectedItemFin);

      formattedSelectedDate = DateFormat('dd/MM/yyyy').format(selectedDate);

      print(formattedSelectedDate.toString() + ' ' + fechaSeleccionada.toString() + ' ' + diaSemana + ' ' + horaInicioSeleccionada.toString() + ' ' + horaFinSeleccionada.toString());
      print(horaInicioSeleccionada);
      print(horaFinSeleccionada);
      if (fechaSeleccionada != null &&
          diaSemana != null &&
          horaInicioSeleccionada != null &&
          horaFinSeleccionada != null) { //diferente de Inicio y Fin
        // Comprueba si la hora de inicio y la hora de fin se superponen con la reserva
        return salon.disponibilidades.any((disponibilidad) {
          final horaInicioReserva = disponibilidad.horaInicio;
          final horaFinReserva = disponibilidad.horaFin;
          // print('horaInicioReserva: ' + horaInicioReserva.toString() + '\nhoraFinReserva: ' + horaFinReserva.toString());

          // Comprueba si el día de la semana, la hora de inicio y la hora de fin se superponen y si la disponibilidad está marcada como 1 (disponible)
          if (disponibilidad.dia == diaSemana &&
              horaInicioSeleccionada! < horaFinReserva &&
              horaFinSeleccionada! > horaInicioReserva &&
              disponibilidad.estado &&
              salon.idSalon == disponibilidad.idSalon) {

            fechaPopup = formattedSelectedDate;
            horaInicioPopup = horaInicioSeleccionada;
            horaFinPopup = horaFinSeleccionada;

            return true; // El salón está disponible en ese horario
          }
          return false;
        });
      }
      return false; // Si no se selecciona ninguna opción, no se aplica el filtro
    }).toList();
    print(salonesFiltrados);
    for (var salonFil in salonesFiltrados) {
      print('Nombre: ${salonFil.idSalon}, Pabellon: ${salonFil.pabellon}');
      // for (var disp in objeto.disponibilidades) {
      //   print('Salon: ${disp.idSalon}, Día: ${disp.dia}, Hora inicio: ${disp.horaInicio}, Hora fin: ${disp.horaFin}, Estado: ${disp.estado}');
      // }
      // print('------');
    }

    setState(() {
      if (horaInicioSeleccionada != null && horaFinSeleccionada != null) {
        mostrarSalonesFiltrados = true;
      } else {
        mostrarSalonesFiltrados = false; // Resgresa a listaSalones
      }
      // listaSalones = salonesFiltrados;
    });
  }

  String obtenerDiaSemana(DateTime fecha) {
    final fomatter = DateFormat('EEEE', 'es');
    return fomatter.format(fecha);
  }

  void aplicarFiltroPorNombre(String filtro) {
    setState(() {
      if (filtro.isNotEmpty) {
        // Filtra los salones cuyo nombre contiene el texto de búsqueda
        salonesFiltrados = listaSalones
            .where((salon) => salon.nombre.toLowerCase().contains(filtro.toLowerCase()))
            .toList();
      } else {
        // Si el campo de búsqueda está vacío, muestra la lista completa
        salonesFiltrados = List.from(listaSalones);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          titulo(context),
          prediccionReservas(widget.viewModel.predValue),
          // barraBusqueda(),
          filtros(),
          salones(context), // Pasa las reservas al widget de salones
        ],
      ),
    );
  }

  Widget titulo(context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 65, vertical: 25),
      padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 10),
      width: MediaQuery.of(context).size.width,
      child: const Text(
        'Reserva de Salones',
        style: TextStyle(
          fontSize: 24,
          fontFamily: 'Outfit',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget prediccionReservas(var predValue){
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 16),
      child: Text(
          "Reservas estimadas para hoy: $predValue",
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'ReadexPro',
            color: Colors.black,
          )
      ),
    );
  }

  Widget barraBusqueda() {
    return Container(
      width: 365.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: searchController, // Asocia el controlador al campo de texto
        decoration: const InputDecoration(
          hintText: 'Buscar Aulas',
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }

  Widget salones(context) {
    final salonesAMostrar = mostrarSalonesFiltrados ? salonesFiltrados : []; //listaSalones;

    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F4F8),
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
                    children: salonesAMostrar.map((salon) {
                      return buildCenteredContainer(
                        context,
                        salon.idSalon,
                        salon.nombre,
                        salon.pabellon,
                        salon.imagePath,
                      );
                    }).toList(),
                  ),
                ),
              ]
            ),
          ),
        ]
    );

  }

  Widget buildCenteredContainer(BuildContext context, int idSalon, String aula,
      String pabellon, String imagePath) {
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
                  //'assets/images/$imagePath',
                  'https://reservatech.azurewebsites.net/images/$imagePath',
                  width: 192,
                  height: 144,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                      child: Text(
                        aula,
                        style: const TextStyle(
                          fontFamily: 'ReadexPro',
                          fontSize: 16,
                          color: Color(0xFF14181B),
                        ),
                      ),
                    ),
                    Text(
                      pabellon,
                      style: const TextStyle(
                        fontFamily: 'ReadexPro',
                        fontSize: 14,
                        color: Color(0xFF57636C),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(
                          0.00, 0.00),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            showHacerReserva(context, idSalon, aula, pabellon);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4B39EF),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(113.0, 40.0),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12), // Bordes redondeados del botón
                              side: const BorderSide(
                                color: Colors.transparent, // Color del borde
                                width: 1, // Ancho del borde
                              ),
                            ),
                          ),
                          child: const Text(
                            'Reservar',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                                fontFamily: 'ReadexPro'
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

  showHacerReserva(BuildContext context, int idSalon, String aula, String pabellon) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Personaliza el radio de los bordes
          ),
          backgroundColor: const Color(0xFFEAE7FD),
          title: const Text('Reservar salón'),
          content: Text('¿Desea realizar la reserva? \n- $aula \n- $pabellon \n'
              '- $horaInicioPopup:00 - $horaFinPopup:00\n'
              '- $fechaPopup'),
              // '$horaInicioSeleccionada:00 - $horaFinSeleccionada:00 \n'
              // '$formattedSelectedDate'),
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
              child: const Text('Reservar', style: TextStyle(color: Color(0xFF4B39EF))),
              onPressed: () {
                // _auth.signOut();
                // Navigator.of(context).pop();
                // Navigator.of(context).pushReplacement(
                //   MaterialPageRoute(
                //     builder: (context) => LoginAppView(),
                //   ),
                // );

                widget.viewModel.insertReserva(diaSemana, fechaPopup, horaInicioPopup!, horaFinPopup!, idSalon, pabellon);
                widget.viewModel.updateDisponibilidad(idSalon, pabellon, diaSemana, horaInicioPopup!, horaFinPopup!);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget filtros(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      // width: 398,
      // height: 73,
      // decoration: const BoxDecoration(
      //   color: Colors.white,
      // ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                // padding: const EdgeInsets.only(left: 16,right: 15),
                child: InkWell(
                  onTap: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(3000),
                      cancelText: 'Cancelar',
                      confirmText: 'Aceptar',
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: const Color(0xFF4B39EF),
                            hintColor: const Color(0xFF4B39EF), // Cambia el color de resalte
                            colorScheme: const ColorScheme.light(primary: Color(0xFF4B39EF)), // Cambia el esquema de color
                            dialogTheme: DialogTheme(  // Aquí se establece el borde redondeado del diálogo
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (dateTime != null) {
                      setState(() {
                        selectedDate = dateTime;
                        formattedSelectedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
                        textoCalendario = " $formattedSelectedDate";
                        // textoCalendario = " ${dateTime.year}-${dateTime.month}-${dateTime.day}";
                      });
                    }
                  },
                  child: Container(
                    width: 170,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFC7C5C5),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          textoCalendario,
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'ReadexPro',
                            color: Colors.black,
                          ),
                        ),
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                          size: 24,
                        ), // Icono a la derecha
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 4.0),
              Expanded(
                //width: 180, // Ajusta el ancho del Container para el campo de entrada
                child: InkWell(
                  onTap: () async {
                    TimeRange? result = await showTimeRangePicker(
                      context: context,
                      start: const TimeOfDay(hour: 10, minute: 0),
                      end: const TimeOfDay(hour: 20, minute: 0),
                      interval: const Duration(hours: 1),
                      minDuration: const Duration(hours: 1),
                      maxDuration: const Duration(hours: 2),
                      use24HourFormat: false,
                      disabledTime: TimeRange(
                        startTime: const TimeOfDay(hour: 20, minute: 0),
                        endTime: const TimeOfDay(hour: 8, minute: 0),
                      ),
                      disabledColor: Colors.white,
                      // backgroundWidget: Image.asset('assets/images/aula101.jpg'),
                      strokeWidth: 8,
                      strokeColor: const Color(0x804B39EF),//Colors.green.shade500.withOpacity(0.8),
                      ticks: 8,
                      ticksLength: 32,
                      ticksColor: Colors.grey,
                      labels: [
                        '12 AM',
                        '3 AM',
                        '6 AM',
                        '9 AM',
                        '12 PM',
                        '3 PM',
                        '6 PM',
                        '9 PM',
                      ].asMap().entries.map((e) {
                        return ClockLabel.fromIndex(
                            idx: e.key, length: 8, text: e.value);
                      }).toList(),
                      labelOffset: 36,
                      rotateLabels: false,
                      padding: 64,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                      timeTextStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      activeTimeTextStyle: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        color: Colors.white,
                      ),
                      fromText: Strings.open,
                      toText: Strings.close,
                      handlerColor: const Color(0xFF4B39EF), //Colors.green.shade600,
                      selectedColor: const Color(0xFF6251EF), //Colors.green.shade400,
                      builder: (BuildContext context, Widget? child){
                        return Theme(
                          data: ThemeData.light().copyWith(
                            primaryColor: const Color(0xFF4B39EF),
                            hintColor: const Color(0xFF4B39EF), // Cambia el color de resalte
                            colorScheme: const ColorScheme.light(primary: Color(0xFF4B39EF)), // Cambia el esquema de color
                            dialogTheme: DialogTheme(  // Aquí se establece el borde redondeado del diálogo
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (result != null) {
                      print("result " + result.toString());
                      horaInicioSeleccionada = result.startTime.hour;
                      horaFinSeleccionada = result.endTime.hour;
                    }
                    if (horaInicioSeleccionada != null && horaFinSeleccionada != null) {
                      setState(() {
                        textoHorario = "${horaInicioSeleccionada}:00 - ${horaFinSeleccionada}:00";
                      });
                    }
                  },
                  child: Container(
                    width: 170,
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFC7C5C5),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          textoHorario,
                          style: const TextStyle(
                            fontSize: 13,
                            fontFamily: 'ReadexPro',
                            color: Colors.black,
                          ),
                        ),
                        const Icon(
                          Icons.schedule,
                          color: Colors.black,
                          size: 24,
                        ), // Icono a la derecha
                      ],
                    ),
                  ),
                ),
                /*
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: 90,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFFC7C5C5), // Color del borde
                          width: 2, // Ancho del borde
                        ),
                        borderRadius: BorderRadius.circular(8), // Borde redondeado
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedItemInicio,
                          items: itemsinicio.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'ReadexPro',
                              color: Colors.black,
                            ),
                          ),
                          )).toList(),
                          onChanged: (item) {
                            setState(() {
                              selectedItemInicio = item!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: 80,
                      decoration: BoxDecoration(
                      border: Border.all(
                      color: const Color(0xFFC7C5C5), // Color del borde
                      width: 2, // Ancho del borde
                      ),
                      borderRadius: BorderRadius.circular(8), // Borde redondeado
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedItemFin,
                          items: itemsfin.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: 'ReadexPro',
                              color: Colors.black,
                            ),
                          ),
                          )).toList(),
                          onChanged: (item) {
                            setState(() {
                              selectedItemFin = item!;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
                */
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 4),
                child: ElevatedButton(
                  onPressed: () {
                    aplicarFiltro(); // Llama al filtro cuando se presiona el botón "Buscar"
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
                  child: const Text('Buscar',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: 'Outfit'
                    )
                  )
                )
              )
            ]
          )
        ]
      )
    );
  }
}