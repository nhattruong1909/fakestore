part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginFailedState extends LoginState {
  final String message;

  LoginFailedState(this.message);
}

class NotLoggedInState extends LoginState {
  final String? path;
  NotLoggedInState({this.path});
}

class LoginSuccess extends LoginState {
  final UserEntity? user;
  final String? path;

  LoginSuccess(this.user, this.path);

  @override
  List<Object?> get props => [user, path];
}
