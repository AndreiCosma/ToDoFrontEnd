import 'package:equatable/equatable.dart';

abstract class ThemeState extends Equatable {
  ThemeState([List props = const []]) : super(props);
}

class ThemeStateLight extends ThemeState {}

class ThemeStateDark extends ThemeState {}
