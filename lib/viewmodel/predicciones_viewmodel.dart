import 'dart:convert';
import 'dart:ffi';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:proyecto_sm/api_connection/api_connection.dart';
import 'package:http/http.dart' as http;

class misPrediccionViewModel {
  String predValue = "Cargando...";
  late Interpreter interpreter;

  misPrediccionViewModel() {
    _loadModelAndRunInference();
  }

  API instancia = API.obtenerInstancia();

  Future<void> _loadModelAndRunInference() async {
    interpreter = await Interpreter.fromAsset('assets/Modelo.tflite');
    final output = List.filled(1 * 1, 0.0).reshape([1, 1]);
    interpreter.run([96], output);
    final parsedValue = double.parse(output[0][0].toString());
    predValue = parsedValue.round().toString();
  }

  Future<List<int>> cargarListaPrediccion() async {

    final response = await http.get(Uri.parse(instancia.obtenerdatosprediccion));
    List<int> listareservas = [];

    if (response.statusCode == 200) {
      // Decodificar el JSON
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      // Verificar si la solicitud fue exitosa
      if (jsonResponse['success']) {
        // Obtener la lista de reservas
        Iterable<dynamic> listaJson = jsonResponse['listareservas'];
        listareservas = listaJson.map((reserva) {
          if (reserva is int) {
            return reserva;
          } else if (reserva is String) {
            // Intentar convertir la cadena a un entero
            try {
              return int.parse(reserva);
            } catch (e) {
              // Manejar el error si la conversión no es posible
              print('Error al convertir la cadena a entero: $e');
              return 0; // O algún valor por defecto
            }
          } else {
            // Manejar otros tipos si es necesario
            print('Tipo desconocido en la lista: ${reserva.runtimeType}');
            return 0; // O algún valor por defecto
          }
        }).toList();

      } else {
        print('La solicitud no fue exitosa');
      }
    } else {
      print('Error en la solicitud: ${response.statusCode}');
    }

    return listareservas;
  }

  getReservas() {}
}
