import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/booking_class.dart';
import 'package:flutter_application_2/booking_states.dart';
import 'package:flutter_application_2/bookings_events.dart';
import 'package:flutter_application_2/bookings_repository.dart';

class BookingsBloc extends Bloc<BookingsEvent, BookingsState> {
  final BookingsRepository bookingsRepository;

  BookingsBloc({required this.bookingsRepository}) : super(InitialState()) {
    on<Create>((event, emit) async {
      emit(BookingsAdding());
      try {
        await bookingsRepository.create(
            startTime: event.startTime,
            endTime: event.endTime,
            price: event.price);
        emit(BookingsAdded());
      } catch (e) {
        emit(BookingsError(e.toString()));
      }
    });

    on<GetData>((event, emit) async {
      emit(BookingsLoading());
      try {
        final data = await bookingsRepository.get();
        print('data gets');
        emit(BookingsLoaded(myData: data));
      } catch (e) {
        emit(BookingsError(e.toString()));
      }
    });
  }
}
