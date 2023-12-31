import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/booking_class.dart';
import 'package:flutter_application_2/booking_states.dart';
import 'package:flutter_application_2/bookings_events.dart';
import 'package:flutter_application_2/bookings_repository.dart';
import 'package:flutter_application_2/bookings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_application_2/bookings_bloc.dart';
import 'package:flutter_application_2/booking_class.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

// class _CalendarScreenState extends State<CalendarScreen> {
// late CalendarFormat _calendarFormat;
// late DateTime _selectedDate;
// late DateTime _focusedDate;
// late Map<DateTime, List<dynamic>> _events;
// late Stream<QuerySnapshot> _stream;

// @override
// void initState() {
//   super.initState();
//   // _calendarFormat = CalendarFormat.month;
//   // _selectedDate = DateTime.now();
//   // _focusedDate = DateTime.now();
//   // _events = {};
//   // // _stream = FirebaseFirestore.instance.collection('myData').snapshots();
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text('Calendar'),
//     ),
//     body: Column(
//       children: [
//         TableCalendar(
//           calendarFormat: _calendarFormat,
//           focusedDay: _focusedDate,
//           firstDay: DateTime.utc(2020, 1, 1),
//           lastDay: DateTime.utc(2025, 12, 31),
//           selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
//           onDaySelected: (selectedDay, focusedDay) {
//             setState(() {
//               _selectedDate = selectedDay;
//               _focusedDate = focusedDay;
//             });
//           },
//           eventLoader: (day) {
//             return _events[day] ?? [];
//           },
//         ),
//         Expanded(
//           child: StreamBuilder<QuerySnapshot>(
//             stream: _stream,
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               }

//               final events = snapshot.data!.docs;

//               for (var event in events) {
//                 final Map<String, dynamic>? data =
//                     event.data() as Map<String, dynamic>?;

//                 if (data != null &&
//                     data.containsKey('dateTime') &&
//                     data.containsKey('note')) {
//                   final DateTime dateTime = data['dateTime'].toDate();
//                   final note = data['note'];

//                   _events[dateTime] = [note];
//                 }
//               }

//               return ListView.builder(
//                 itemCount: events.length,
//                 itemBuilder: (context, index) {
//                   final event = events[index];
//                   final Map<String, dynamic>? data =
//                       event.data() as Map<String, dynamic>?;

//                   if (data != null &&
//                       data.containsKey('dateStart') &&
//                       data.containsKey('note') &&
//                       isSameDay(data['dateStart'].toDate(), _selectedDate)) {
//                     final DateTime dateTime = data['dateStart'].toDate();
//                     final DateTime dateEnd = data['dateEnd'].toDate();
//                     final note = data['note'];
//                     return Container(
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 12.0,
//                         vertical: 4.0,
//                       ),
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(12.0),
//                       ),
//                       child: ListTile(
//                         onTap: () => print('Price is: $note ILS'),
//                         title: Text('Price is: $note ILS'),
//                         subtitle: Text(
//                             'From ${DateFormat.jm().format(dateTime).toString()} to ${DateFormat.jm().format(dateEnd).toString()}'),
//                       ),
//                     );
//                   } else {
//                     return SizedBox.shrink();
//                   }
//                 },
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   );
// }

// List<BookingsList> _bookingsList = [];
// @override
// Widget build(BuildContext context) {
//   return MultiBlocProvider(
//     providers: [
//       BlocProvider<BookingsBloc>(
//         create: (context) => BookingsBloc().add(GetData()),
//       ),
//     ],
//     child: MultiBlocListener(
//       listeners: [
//         BlocListener<BookingsBloc, List<BookingsList>>(
//           listener: (context, bookingsList) async {
//             // if (bookingsList != null) {
//             setState(() {
//               _bookingsList = bookingsList;
//             });
//             // }
//           },
//           // child: Container(),
//         ),
//       ],
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Calendar'),
//         ),
//         body: SafeArea(
//           child: fireBaseLocations(context),
//         ),
//       ),
//     ),
//   );
// }

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<BookingsBloc>(context).add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('FireBookings')),
        ),
        body: BlocProvider(
          create: (context) =>
              BookingsBloc(bookingsRepository: BookingsRepository())
                ..add(GetData()),
          child: BlocBuilder<BookingsBloc, BookingsState>(
            builder: (context, state) {
              if (state is BookingsLoaded) {
                print('state is working');
                List<BookingsList> data = state.myData;
                print(DateTime.now());
                return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              'From ${data[index].startTime} to ${data[index].endTime}'),
                          trailing: Text('Price is ${data[index].price}'),
                        ),
                      );
                    });
              } else if (state is BookingsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Container();
              }
            },
          ),
        ));
  }
}
