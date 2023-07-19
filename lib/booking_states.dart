import 'package:equatable/equatable.dart';
import 'package:flutter_application_2/booking_class.dart';
import 'package:const_date_time/const_date_time.dart';

// class BookingsState {
//   const BookingsState(
//       {this.startTime = '', this.endTime = '', this.price = ''});

//   final String startTime;
//   final String endTime;
//   final String price;

//   BookingsState copyWith({
//     String? startTime,
//     String? endTime,
//     String? price,
//   }) {
//     return BookingsState(
//         startTime: startTime ?? this.startTime,
//         endTime: endTime ?? this.endTime,
//         price: price ?? this.price);
//   }
// }

abstract class BookingsState extends Equatable {}

class InitialState extends BookingsState {
  @override
  List<Object?> get props => [];
}

class BookingsAdding extends BookingsState {
  @override
  List<Object?> get props => [];
}

class BookingsAdded extends BookingsState {
  @override
  List<Object?> get props => [];
}

class BookingsError extends BookingsState {
  final String error;

  BookingsError(this.error);

  @override
  List<Object?> get props => [error];
}

class BookingsLoading extends BookingsState {
  @override
  List<Object?> get props => [];
}

class BookingsLoaded extends BookingsState {
  BookingsLoaded({required this.myData});
  final List<BookingsList> myData;

  @override
  List<Object?> get props => [myData];
}

// class BookingsLoaded extends BookingsState {
//   List<BookingsList> myData;
//   BookingsLoaded(this.myData);
//   @override
//   List<Object?> get props => [myData];
// }

