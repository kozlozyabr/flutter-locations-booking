import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BookingsList {
  String startTime, endTime;
  int? price; // note

  BookingsList({
    required this.startTime,
    required this.endTime,
    required this.price,
  });

  factory BookingsList.fromJson(Map<String, dynamic> json) {
    return BookingsList(
        startTime: json['startTime'],
        endTime: json['endTime'],
        price: json['price']);
  }
}
