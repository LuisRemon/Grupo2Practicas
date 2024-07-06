class Disponibilidad {
  int idSalon;
  String pabellon;
  String dia;
  int horaInicio;
  int horaFin;
  bool estado;

  Disponibilidad({
    required this.idSalon,
    required this.pabellon,
    required this.dia,
    required this.horaInicio,
    required this.horaFin,
    required this.estado,
  });
}