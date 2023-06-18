import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';



class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late CalendarFormat _calendarFormat;
  late DateTime _selectedDate;
  late DateTime _focusedDate;
  late Map<DateTime, List<dynamic>> _events;
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _selectedDate = DateTime.now();
    _focusedDate = DateTime.now();
    _events = {};
    _stream = FirebaseFirestore.instance.collection('myData').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDate,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                final events = snapshot.data!.docs;

                for (var event in events) {
                  final Map<String, dynamic>? data =
                      event.data() as Map<String, dynamic>?;

                  if (data != null &&
                      data.containsKey('dateTime') &&
                      data.containsKey('note')) {
                    final DateTime dateTime = data['dateTime'].toDate();
                    final note = data['note'];

                    _events[dateTime] = [note];
                  }
                }

                return ListView.builder(
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    final Map<String, dynamic>? data =
                        event.data() as Map<String, dynamic>?;

                    if (data != null &&
                        data.containsKey('dateStart') &&
                        data.containsKey('note') &&
                        isSameDay(data['dateStart'].toDate(), _selectedDate)) {
                      final DateTime dateTime = data['dateStart'].toDate();
                      final DateTime dateEnd = data['dateEnd'].toDate();
                      final note = data['note'];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          onTap: () => print('Price is: $note ILS'),
                          title: Text('Price is: $note ILS'),
                          subtitle: Text(
                              'From ${DateFormat.jm().format(dateTime).toString()} to ${DateFormat.jm().format(dateEnd).toString()}'),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
