import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:namoz_vaqtlari/data/hive_data.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(ThemeMode mode) : super(ThemeState(mode));
  ThemeMode getTheme() {
    return state.currentTheme;
  }

  void changeTheme(ThemeMode mode) async {
    print(mode.toString());
    putData(mode.toString(), 'currentTheme');
    emit(ThemeState(mode));
  }
}
