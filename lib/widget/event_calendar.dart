import 'package:agenda_compartilhada/domain/event.dart';
import 'package:agenda_compartilhada/infrastructure/event_datasource.dart';
import 'package:agenda_compartilhada/widget/event_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EventCalendar extends StatefulWidget {
  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  List<Event> _events = [];
  DateTime? _selectedDate;
  String title = '';
  DateTime? startDate;
  String? location;
  String? visibility;
  int userId = 1;

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  void _addEvent() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar um Evento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Nome do Evento'),
                onChanged: (value) => title = value,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  startDate == null
                      ? 'Selecionar a Data'
                      : 'Data Selecionada: ${DateFormat('dd/MM/yyyy').format(startDate!)}',
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Local'),
                onChanged: (value) => location = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Visibilidade'),
                onChanged: (value) => visibility = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (title.isNotEmpty &&
                    startDate != null &&
                    location != null &&
                    visibility != null) {
                  setState(() {
                    _events.add(
                      Event(
                        location: location!,
                        description: title,
                        date: startDate!,
                        visibility: visibility!,
                        idUser: userId,
                      ),
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Adicionar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
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
      final eventsForSelectedDate = _events.where((event) {
        return event.date.year == _selectedDate!.year &&
            event.date.month == _selectedDate!.month &&
            event.date.day == _selectedDate!.day;
      }).toList();

      if (eventsForSelectedDate.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
                'Eventos em ${DateFormat('dd-MM-yyyy').format(_selectedDate!)}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: eventsForSelectedDate.map((event) {
                return ListTile(
                  title: Text(event.description ?? 'Sem descrição'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailPage(event: event),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Fechar'),
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
        title: Text('Calendário de Eventos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addEvent,
          ),
        ],
      ),
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: EventDataSource(_events),
        onTap: _onCalendarTapped,
      ),
    );
  }
}
