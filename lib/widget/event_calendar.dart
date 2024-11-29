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

  _newEvent() {
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
      location = '';
      title = '';
      startDate = null;
      visibility = '';
    });
  }

  void _addEvent({DateTime? currentDate}) {
    startDate = currentDate;
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
                    location = '';
                    title = '';
                    startDate = null;
                    visibility = '';
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

  void _onCalendarTapped(CalendarLongPressDetails details) {
    final DateTime selectedDate = details.date!;
    if (details.targetElement == CalendarElement.calendarCell) {
      final List<Event> eventsForSelectedDate = _events
          .where((event) =>
              DateFormat('yyyy-MM-dd').format(event.date) ==
              DateFormat('yyyy-MM-dd').format(selectedDate))
          .toList();

      if (eventsForSelectedDate.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.event, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  'Eventos em ${DateFormat('dd-MM-yyyy').format(selectedDate)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            content: SizedBox(
              height: 200,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: eventsForSelectedDate.length,
                itemBuilder: (context, index) {
                  final event = eventsForSelectedDate[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: const Icon(Icons.event_note, color: Colors.blue),
                      title: Text(
                        event.description ?? 'Sem descrição',
                        style: const TextStyle(fontSize: 16),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetailPage(event: event),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton.icon(
                onPressed: () => {
                  _addEvent(currentDate: selectedDate),
                },
                icon: const Icon(Icons.add, color: Colors.green),
                label: const Text(
                  'Adicionar Evento',
                  style: TextStyle(color: Colors.green),
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close, color: Colors.red),
                label: const Text(
                  'Fechar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        );
      } else {
        _addEvent(currentDate: selectedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
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
        onLongPress: _onCalendarTapped,
        backgroundColor: Colors.white,
        todayHighlightColor: Colors.blue,
      ),
    );
  }
}
