import 'package:equatable/equatable.dart';
import 'package:perhutaniwisata_app/model/data_model.dart';

// Base class for all states
abstract class CubitStates extends Equatable {}

// Initial state
class InitialState extends CubitStates {
  @override
  List<Object> get props => [];
}

// Welcome page state
class WelcomeState extends CubitStates {
  @override
  List<Object> get props => [];
}

// Login page state
class LoginPageState extends CubitStates {
  @override
  List<Object> get props => [];
}

// Loading state
class LoadingState extends CubitStates {
  @override
  List<Object> get props => [];
}

// Loaded state with places data
class LoadedState extends CubitStates {
  LoadedState(this.places);
  final List<DataModel> places;
  @override
  List<Object> get props => [places];
}

// Detail page state with data model
class DetailState extends CubitStates {
  DetailState(this.place);
  final DataModel place;
  @override
  List<Object> get props => [place];
}

class ErrorState extends CubitStates {
  ErrorState(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

