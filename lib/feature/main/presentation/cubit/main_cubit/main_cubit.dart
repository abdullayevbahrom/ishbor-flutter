import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_state.dart';

part 'main_cubit.freezed.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void updateIndex(int index) {
    emit(state.copyWith(currentIndex: index));
  }

  void updateOpen(bool value) {
    emit(state.copyWith(isOpen: value));
  }

  void updateNtfMenu(bool value) {
    emit(state.copyWith(isNotificationMenuOpen: value));
  }
}
