import 'package:flutter_bloc/flutter_bloc.dart';

// Define the events
abstract class NavigationEvent {}

class Button1Pressed extends NavigationEvent {}

class Button2Pressed extends NavigationEvent {}

class NavigationBloc extends Bloc<NavigationEvent, int> {
  NavigationBloc() : super(0);

  @override
  Stream<int> mapEventToState(NavigationEvent event) async* {
    if (event is Button1Pressed) {
      yield 1;
    } else if (event is Button2Pressed) {
      yield 2;
    }
  }
}
