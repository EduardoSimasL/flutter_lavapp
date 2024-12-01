import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'navigation_event.dart';
import 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(HomeState()) {
    on<NavigateToSchedulePage>((event, emit) {
      emit(ScheduleState());
    });

    on<NavigateToHomePage>((event, emit) {
      emit(HomeState());
    });

    on<NavigateToLiveMachinesPage>((event, emit) { // Novo evento
      emit(LiveMachinesState());
    });

    on<NavigateToMySchedulePage>((event, emit) { // Novo evento
      emit(MyScheduleState());
    });
  }
}


