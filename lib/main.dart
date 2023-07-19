import 'package:flutter/material.dart';
import 'package:flutter_application_2/booking_class.dart';
import 'package:flutter_application_2/bookings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'locations_bloc.dart';
import 'add_locations.dart';
import 'booked_locations.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation',
      home: RepositoryProvider(
        create: (context) => BookingsRepository(),
        child: HomePage(),
      ),
      routes: {
        '/addtimes': (context) => AddTimeS(),
        '/calendarscreen': (context) => CalendarScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addtimes');
              },
              child: Text('Add time'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calendarscreen');
              },
              child: Text('Calendar'),
            ),
          ],
        ),
      ),
    );
  }
}
