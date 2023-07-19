import 'package:equatable/equatable.dart';

abstract class BookingsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Create extends BookingsEvent {
  final String startTime;
  final String endTime;
  final int? price;

  Create(this.startTime, this.endTime, this.price);
  //
}

class GetData extends BookingsEvent {
  GetData();
}
