part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class CheckLoggedInEvent extends LoginEvent {
  final String? path;
  const CheckLoggedInEvent({this.path});
}

class LoggingInEvent extends LoginEvent {
  final String username;
  final String password;
  final String? path;

  const LoggingInEvent(
      {required this.username, required this.password, this.path});

  @override
  List<Object?> get props => [username, password];
}

class LogoutEvent extends LoginEvent {
  LogoutEvent();
}
