import 'package:bloc/bloc.dart';
import 'package:perhutaniwisata_app/cubit/app_cubit_states.dart';
import 'package:perhutaniwisata_app/services/data_services.dart';

import '../model/data_model.dart';

class AppCubits extends Cubit<CubitStates> {
  AppCubits({required this.data}) : super(InitialState()) {
    emit(WelcomeState());
  }
  final DataServices data;
  late final List<DataModel> places;

  void getData() async {
    try {
      emit(LoadingState());
      places = await data.getInfo();
      emit(LoadedState(places));
    } catch (e) {
      // Handle error
    }
  }

  void detailPage(DataModel data) {
    emit(DetailState(data));
  }

  void goHome() {
    emit(LoadedState(places));
  }

  void goToLoginPage() {
    emit(LoginPageState());
  }
}
