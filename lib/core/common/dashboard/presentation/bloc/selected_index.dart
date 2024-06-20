// selected_index_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SelectedIndexEvent {}

class SelectIndex extends SelectedIndexEvent {
  final int index;

  SelectIndex(this.index);
}

class SelectedIndexState {
  final int index;

  SelectedIndexState(this.index);
}

class SelectedIndexBloc extends Bloc<SelectedIndexEvent, SelectedIndexState> {
  SelectedIndexBloc() : super(SelectedIndexState(0)) {
    on<SelectIndex>((event, emit) {
      emit(SelectedIndexState(event.index));
    });
  }
}
