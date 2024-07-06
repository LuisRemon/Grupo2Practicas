import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyecto_sm/api_connection/api_connection.dart';
import 'package:proyecto_sm/model/salon_model.dart';
import '../model/disponibilidad_model.dart';
import '../model/user_model.dart';

class ReservarViewModel {

  String predValue = "Cargando...";
  late Interpreter interpreter;
  get reserva => null;
  final UserData userData;
  API instancia = API.obtenerInstancia();

  ReservarViewModel({required this.userData}) {
    _loadModelAndRunInference();
  }

  Future<void> _loadModelAndRunInference() async {
    interpreter = await Interpreter.fromAsset('assets/Modelo.tflite');
    final output = List.filled(1 * 1, 0.0).reshape([1, 1]);
    interpreter.run([96], output);
    final parsedValue = double.parse(output[0][0].toString());
    predValue = parsedValue.round().toString();
  }

  Future<List<Salon>> getSalones() async {
    List<Salon> ListaSalones = [];

    final response = await http.get(Uri.parse(instancia.consultasalones));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success']) {
        List<dynamic> salones = data["salones"];
        for(var salon in salones) {
          List<Disponibilidad> disponibilidades = await getDisponibilidades(int.parse(salon['id_salon']), salon['pabellon']);

          Salon reserva = Salon(
            idSalon: int.parse(salon['id_salon']),
            nombre: salon['nombre'],
            tipo: salon['tipo_salon'],
            pabellon: salon['pabellon'],
            capacidad: int.parse(salon['capacidad']),
            imagePath: salon['imagen'],
            disponibilidades: disponibilidades,
          );
          ListaSalones.add(reserva);
        }
      }else {
        // Manejar el caso en el que no se encontraron registros.
      }
    }else {
      // Manejar errores de conexión.
    }

  return ListaSalones;
  }

  Future<List<Disponibilidad>> getDisponibilidades(int idSalon, String pabellon) async {
    List<Disponibilidad> ListaDisponibilidades = [];

    final response = await http.get(Uri.parse(instancia.consultadisponibilidades + "?id_salon=$idSalon&pabellon=$pabellon"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['success']) {
        List<dynamic> disponibilidadesData = data["disponibilidades"];
        for (var disponibilidadData in disponibilidadesData) {
          bool estado = disponibilidadData['estado'] == 1.toString();

          Disponibilidad disponibilidad = Disponibilidad(
            idSalon: int.parse(disponibilidadData['id_salon']),
            pabellon: disponibilidadData['pabellon'],
            dia: disponibilidadData['dia'],
            horaInicio: int.parse(disponibilidadData['hora_inicio']),
            horaFin: int.parse(disponibilidadData['hora_fin']),
            estado: estado,
          );

          ListaDisponibilidades.add(disponibilidad);
        }
      } else {
        // Manejar el caso en el que no se encontraron registros.
      }
    } else {
      // Manejar errores de conexión.
    }

    return ListaDisponibilidades;
  }

  Future<void> insertReserva(String dia, String fecha, int horaInicio, int horaFin, int idSalon, String pabellon) async {

    var response = await http.post(
      Uri.parse(instancia.insertarreservas),
      body: {
        'dia': dia,
        'fecha': fecha,
        'hora_inicio': horaInicio.toString(),
        'hora_fin': horaFin.toString(),
        'id_salon': idSalon.toString(),
        'pabellon': pabellon,
        'codigo_usuario': userData.codigo.toString()
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        // Éxito en la inserción
        print('Inserción exitosa');
      } else {
        // Manejar error en la inserción
        print('Error en la inserción: ${jsonResponse['error']}');
      }
    } else {
      // Error en la solicitud HTTP
      print('Error de conexión: ${response.reasonPhrase}');
    }
  }

  Future<void> updateDisponibilidad(int idSalon, String pabellon, String dia, int horaInicio, int horaFin) async {
    // Realizar la solicitud POST

    var response = await http.post(
      Uri.parse(instancia.updatedisponibilidadreservar),
      body: {
        'id_salon': idSalon.toString(),
        'pabellon': pabellon,
        'dia': dia,
        'hora_inicio': horaInicio.toString(),
        'hora_fin': horaFin.toString()
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      if (jsonResponse['success']) {
        // Éxito en la actualización
        print('Actualización exitosa');
      } else {
        // Manejar error en la actualización
        print('Error en la actualización: ${jsonResponse['error']}');
      }
    } else {
      // Error en la solicitud HTTP
      print('Error de conexión: ${response.reasonPhrase}');
    }
  }
}