import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class EventCalendar extends StatefulWidget {
  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  List<Appointment> _appointments = [];
  DateTime? _selectedDate;

  void _addEvent() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        DateTime? startDate;
        DateTime? endDate;

        return AlertDialog(
          title: Text('Add Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Start Date (yyyy-mm-dd)'),
                onChanged: (value) => startDate = DateTime.tryParse(value),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'End Date (yyyy-mm-dd)'),
                onChanged: (value) => endDate = DateTime.tryParse(value),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty && startDate != null && endDate != null) {
                  setState(() {
                    _appointments.add(
                      Appointment(
                        subject: title,
                        startTime: startDate!,
                        endTime: endDate!,
                        color: Colors.blue,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _onCalendarTapped(CalendarTapDetails details) {
    setState(() {
      _selectedDate = details.date;
    });

    if (_selectedDate != null) {
      final eventsForSelectedDate = _appointments.where((appointment) {
        return appointment.startTime.year == _selectedDate!.year &&
               appointment.startTime.month == _selectedDate!.month &&
               appointment.startTime.day == _selectedDate!.day;
      }).toList();

      if (eventsForSelectedDate.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Events on ${_selectedDate!.toLocal().toString().split(' ')[0]}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: eventsForSelectedDate.map((event) => Text(event.subject)).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addEvent,
          ),
        ],
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: EventDataSource(_appointments),
        onTap: _onCalendarTapped,
      ),
    );
  }
}

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Appointment> appointments) {
    this.appointments = appointments;
  }
}
