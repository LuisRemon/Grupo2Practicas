class Reserva {
  int idReserva;
  int horaInicio;
  int horaFin;
  String dia;
  String fecha;
  int idEstado;
  int codigoUsuario;
  int idSalon;
  String nombre;
  String pabellon;
  String imagen;

  Reserva({
    required this.idReserva,
    required this.horaInicio,
    required this.horaFin,
    required this.dia,
    required this.fecha,
    required this.idEstado,
    required this.codigoUsuario,
    required this.idSalon,
    required this.nombre,
    required this.pabellon,
    required this.imagen
  });
}