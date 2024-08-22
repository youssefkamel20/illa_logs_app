import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:illa_logging_app/shared/components/main_cubit/states.dart';



class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightThemeState()); // Default to light theme
  static ThemeCubit get(context) => BlocProvider.of(context);

  bool isLightTheme = true;
  Icon themeIcon = const Icon(Icons.brightness_4_outlined);
  void toggleTheme (){
    isLightTheme = !isLightTheme;
    isLightTheme? themeIcon = const Icon(Icons.brightness_4_outlined) : themeIcon = const Icon(Icons.brightness_4);
    emit(isLightTheme? LightThemeState() : DarkThemeState());
  }
}
