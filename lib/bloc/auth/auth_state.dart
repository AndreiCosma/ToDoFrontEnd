import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  AuthState([List props = const []]) : super(props);
}

/*
 * Trigger @AuthEventCheckCached if this state is present
 */
class AuthStateInitial extends AuthState {}

/*
 * Show a loading widget.
 */
class AuthStateAuthenticating extends AuthState {}

/*
 * Show this state only on an @AuthEventAuthenticate
 */
class AuthStateFailure extends AuthState {}

/*
 * Continue and present the protected ui.
 */
class AuthStateAuthenticated extends AuthState {}

/*
 * Set this state if there is no token cached.
 */
class AuthStateFormUiPresent extends AuthState {}

class AuthStateNoInternet extends AuthState {}

class AuthStateUnexpectedError extends AuthState {}
