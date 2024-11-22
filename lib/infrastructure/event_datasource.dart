import 'package:agenda_compartilhada/domain/event.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> events) {
    appointments = events.map((event) {
      return Appointment(
        subject: event.description ?? 'No Description',
        startTime: event.date,
        endTime: event.date.add(Duration(hours: 1)),
        location: event.location,
        notes: event.visibility,
        color: Colors.blue,
      );
    }).toList();
  }
}
