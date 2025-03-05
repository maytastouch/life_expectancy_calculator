import 'package:time_left/core/theme/bloc/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

enum ThemeEvent { loadTheme, toggleDark, toggleLight }

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.lightTheme) {
    on<ThemeEvent>(_mapEventToState);
    add(ThemeEvent.loadTheme);
  }

  Future<void> _mapEventToState(
      ThemeEvent event, Emitter<ThemeState> emit) async {
    print('ThemeBloc: Handling event $event');

    switch (event) {
      case ThemeEvent.loadTheme:
        final themeState = await _loadTheme();
        print(
            'ThemeBloc: Loaded theme - isDark: ${themeState.themeData.brightness == Brightness.dark}');
        emit(themeState);
        break;
      case ThemeEvent.toggleDark:
        await _saveTheme('dark');
        print('ThemeBloc: Switched to dark theme');
        emit(ThemeState.darkTheme);
        break;
      case ThemeEvent.toggleLight:
        await _saveTheme('light');
        print('ThemeBloc: Switched to light theme');
        emit(ThemeState.lightTheme);
        break;
    }
  }

  Future<ThemeState> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final theme = prefs.getString('theme') ?? 'light';
      print('ThemeBloc: Loading saved theme: $theme');
      if (theme == 'dark') {
        return ThemeState.darkTheme;
      } else {
        return ThemeState.lightTheme;
      }
    } catch (e) {
      print('ThemeBloc: Error loading theme: $e');
      return ThemeState.lightTheme;
    }
  }

  Future<void> _saveTheme(String theme) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('theme', theme);
      print('ThemeBloc: Saved theme preference: $theme');
    } catch (e) {
      print('ThemeBloc: Error saving theme: $e');
    }
  }
}
