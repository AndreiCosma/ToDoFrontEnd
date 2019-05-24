import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const []]) : super(props);
}

class ThemeEventDark extends ThemeEvent {}

class ThemeEventLight extends ThemeEvent {}
