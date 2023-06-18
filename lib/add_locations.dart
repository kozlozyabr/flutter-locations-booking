import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late TimeOfDay _selectedTimeOfEnd;
  late int _note;
  final _noteController = TextEditingController();

  Future<void> _saveDateTime() async {
    try {
      if (_selectedDate != null &&
          _selectedTime != null &&
          _selectedTimeOfEnd != null) {
        final selectedDateTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );

        final endingDateTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          _selectedTimeOfEnd!.hour,
          _selectedTimeOfEnd!.minute,
        );
        if (selectedDateTime.compareTo(endingDateTime) >= 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text('Please select correct time interval (> 0 minutes).')),
          );
        } else {
          await FirebaseFirestore.instance.collection('myData').add({
            'dateStart': selectedDateTime,
            'dateEnd': endingDateTime,
            'note': _noteController.text,
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('DateTime saved successfully!')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select both date and time.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save DateTime. $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    _selectedDate = selectedDate;
                  });
                }
              },
              child: Text('Select date')),
          SizedBox(height: 16.0),
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
                      _selectedTime = selectedTime;
                    });
                  }
                },
                child: Text('Select Start Time'),
              ),
              SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () async {
                  final selectedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    initialEntryMode: TimePickerEntryMode.input,
                  );

                  if (selectedTime != null) {
                    setState(() {
                      _selectedTimeOfEnd = selectedTime;
                    });
                  }
                },
                child: Text('Select End Time'),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _noteController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Input Price',
              ),
              onChanged: (value) {
                setState(() {
                  _note = int.tryParse(value) ?? 0;
                });
              },
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _saveDateTime,
            child: Text('Save your booking'),
          ),
        ],
      ),
    );
  }
}
