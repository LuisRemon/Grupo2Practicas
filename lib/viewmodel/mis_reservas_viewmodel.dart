import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:proyecto_sm/api_connection/api_connection.dart'; // Importa la conexión API
import 'package:proyecto_sm/model/reserva_model.dart'; // Importa el modelo de reserva
import '../model/user_model.dart'; // Importa el modelo de usuario

class MisReservasViewModel {
  final UserData userData; // Datos del usuario

  MisReservasViewModel(this.userData); // Constructor
  API instancia = API.obtenerInstancia();
  Function()? onReservasUpdated; // Función de actualización de reservas


  // Método para obtener las reservas
  Future<List<Reserva>> getReservas(int idEstado, int codUsuario) async {
    List<Reserva> ListaReservas = []; // Lista de reservas

    // Realiza la solicitud HTTP GET para obtener las reservas
    final response = await http.get(Uri.parse(instancia.consultareservas +
        "?id_estado=$idEstado&codigo_usuario=$codUsuario"));

    if (response.statusCode == 200) { // Si la solicitud es exitosa
      final data = json.decode(response.body); // Decodifica la respuesta JSON

      if (data['success']) { // Si la respuesta indica éxito
        List<dynamic> reservas = data["reservas"]; // Obtiene la lista de reservas

        for(var reserva in reservas) { // Itera sobre las reservas
          // Crea un objeto Reserva y lo agrega a la lista
          Reserva objReserva = Reserva(
              idReserva: int.parse(reserva['id_reserva']),
              horaInicio: int.parse(reserva['hora_inicio']),
              horaFin: int.parse(reserva['hora_fin']),
              dia: reserva['dia'],
              fecha: reserva['fecha'],
              idEstado: int.parse(reserva['id_estado']),
              codigoUsuario: int.parse(reserva['codigo_usuario']),
              idSalon: int.parse(reserva['id_salon']),
              nombre: reserva['nombre'],
              pabellon: reserva['pabellon'],
              imagen: reserva['imagen']
          );
          ListaReservas.add(objReserva); // Agrega la reserva a la lista
        }
      } else {
        // Manejar el caso en el que no se encontraron registros.
      }
    } else {
      // Manejar errores de conexión.
    }
    return ListaReservas; // Devuelve la lista de reservas
  }

  // Método para actualizar una reserva
  Future<void> updateReserva(int idReserva) async {
    // Realiza la solicitud HTTP POST para actualizar la reserva
    final response = await http.post(
      Uri.parse(instancia.updatereservas), // URL de actualización de reservas
      body: {
        'id_reserva': idReserva.toString() // Parámetro: ID de la reserva
      },
    );

    if (response.statusCode == 200) { // Si la solicitud es exitosa
      final data = json.decode(response.body); // Decodifica la respuesta JSON

      if (data['success']) { // Si la actualización fue exitosa
        if (onReservasUpdated != null) {
          onReservasUpdated!(); // Llama a la función de actualización de reservas si está definida
        }
        print("Información actualizada exitosamente."); // Mensaje de éxito
      } else {
        print("Hubo un error al ejecutar los cambios."); // Mensaje de error
      }
    }
  }

  // Método para actualizar la disponibilidad de un salón
  Future<void> updateDisponibilidad(int idSalon, String pabellon, String dia, int horaInicio, int horaFin) async {
    // Realiza la solicitud HTTP POST para actualizar la disponibilidad del salón
    var response = await http.post(
      Uri.parse(instancia.updatedisponibilidadcancelar), // URL de actualización de disponibilidad
      body: {
        'id_salon': idSalon.toString(), // Parámetro: ID del salón
        'pabellon': pabellon, // Parámetro: Pabellón
        'dia': dia, // Parámetro: Día
        'hora_inicio': horaInicio.toString(), // Parámetro: Hora de inicio
        'hora_fin': horaFin.toString() // Parámetro: Hora de fin
      },
    );

    if (response.statusCode == 200) { // Si la solicitud es exitosa
      var jsonResponse = json.decode(response.body); // Decodifica la respuesta JSON

      if (jsonResponse['success']) { // Si la actualización fue exitosa
        print('Actualización exitosa'); // Mensaje de éxito
      } else {
        print('Error en la actualización: ${jsonResponse['error']}'); // Mensaje de error
      }
    } else {
      print('Error de conexión: ${response.reasonPhrase}'); // Error en la solicitud HTTP
    }
  }
}