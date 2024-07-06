import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:proyecto_sm/model/calendario_model.dart';
import '../model/reserva_model.dart';

class CalendarViewModel {
  final List<Meeting> _meetings = <Meeting>[];
  final CalendarDataSource calendarDataSource;

  CalendarViewModel(List<Reserva> reservas) : calendarDataSource = MeetingDataSource(<Meeting>[]) {
    initializeMeetings(reservas);
  }

  void initializeMeetings(List<Reserva> reservas) {
    final DateTime today = DateTime.now();
    // final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
    // final DateTime endTime = startTime.add(const Duration(hours: 2));
    for(var reserva in reservas){
      List<String> partes = reserva.fecha.split('/');
      int dia = int.parse(partes[0]); // Convertir la primera parte a entero (día)
      int mes = int.parse(partes[1]); // Convertir la segunda parte a entero (mes)
      int anio = int.parse(partes[2]);
      final DateTime startTime = DateTime(anio, mes, dia, reserva.horaInicio, 0, 0);
      final DateTime endTime = startTime.add(Duration(hours: reserva.horaFin-reserva.horaInicio));
      _meetings.add(Meeting(reserva.nombre, startTime, endTime, const Color(0xFF4B39EF), false));
    }
    calendarDataSource.appointments = _meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}