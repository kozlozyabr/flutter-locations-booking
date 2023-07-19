import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/booking_states.dart';
import 'package:flutter_application_2/bookings_events.dart';
import 'package:flutter_application_2/bookings_repository.dart';
import 'package:flutter_application_2/bookings_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTimeS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddDateTimeScreen(),
    );
  }
}

class AddDateTimeScreen extends StatefulWidget {
  @override
  _AddDateTimeScreenState createState() => _AddDateTimeScreenState();
}

class _AddDateTimeScreenState extends State<AddDateTimeScreen> {
  late String _selectedDate;
  late String _selectedStartTime;
  late String _selectedEndTime;
  late int _price;
  final _priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookingsBloc(bookingsRepository: BookingsRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add DateTime'),
        ),
        body: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _selectedDate = selectedDate.toString();
                    });
                  }
                },
                child: Text('Select date')),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.input,
                    );

                    if (selectedTime != null) {
                      setState(() {
                        _selectedStartTime = selectedTime.toString();
                      });
                    }
                  },
                  child: Text('Select Start Time'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.input,
                    );

                    if (selectedTime != null) {
                      setState(() {
                        _selectedEndTime = selectedTime.toString();
                      });
                    }
                  },
                  child: Text('Select End Time'),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Input Price',
                ),
                onChanged: (value) {
                  setState(() {
                    // _price = value;
                    _price = int.tryParse(value) ?? 0;
                  });
                },
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // if (_selectedStartTime == null || _selectedEndTime == null) {
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //       content: Text('please select correct date and time')));
                // } else {
                BookingsBloc(bookingsRepository: BookingsRepository())
                  ..add(Create(_selectedStartTime, _selectedEndTime, _price));
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('successfuly saved')));
                // }
              },
              child: Text('Save your booking'),
            ),
          ],
        ),
      ),
    );
  }
}
