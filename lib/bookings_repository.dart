import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_2/booking_class.dart';

class BookingsRepository {
  final _fireList = FirebaseFirestore.instance.collection('myNewData');

  Future<void> create(
      {required String startTime,
      required String endTime,
      required int? price}) async {
    try {
      await _fireList
          .add({'startTime': startTime, 'endTime': endTime, 'price': price});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error ${e.code}: ${e.message}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<BookingsList>> get() async {
    List<BookingsList> bookingsList = [];
    try {
      final fireList =
          await FirebaseFirestore.instance.collection('myNewData').get();

      for (var element in fireList.docs) {
        bookingsList.add(BookingsList.fromJson(element.data()));
      }
      print('ready to send list');
      return bookingsList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Failed with error ${e.code}: ${e.message}');
      }
      return bookingsList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
