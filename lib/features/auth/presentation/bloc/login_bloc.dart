import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fakestore/features/auth/domain/entities/user_entity.dart';
import 'package:fakestore/features/auth/domain/usecases/get_user.dart';
import 'package:fakestore/features/auth/domain/usecases/login.dart';
import 'package:fakestore/features/auth/domain/usecases/logout.dart';
import 'package:fakestore/features/utils/model/user_request_model.dart';

import '../../../../core/commondomain/usecase/usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.login, required this.getUser, required this.logout})
      : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoggingInEvent>(_onLoggingIn);
    on<CheckLoggedInEvent>(_onCheckLoggedIn);
    on<LogoutEvent>(_onLogout);
  }

  final Login login;
  final GetUser getUser;
  final Logout logout;

  FutureOr<void> _onLoggingIn(
      LoggingInEvent event, Emitter<LoginState> emit) async {
    final result = await login(
        UserRequestModel(username: event.username, password: event.password));
    result.fold((l) => emit(LoginFailedState(l.message)),
        (r) => emit(LoginSuccess(r, event.path)));
  }

  FutureOr<void> _onCheckLoggedIn(
      CheckLoggedInEvent event, Emitter<LoginState> emit) async {
    var result = await getUser(NoParams());
    result.fold((l) => emit(NotLoggedInState(path: event.path)),
        (r) => emit(LoginSuccess(r, event.path)));
  }

  FutureOr<void> _onLogout(LogoutEvent event, Emitter<LoginState> emit) async {
    var result = await logout(NoParams());
    result.fold((l) => emit(LoginFailedState(l.message)),
        (r) => emit(NotLoggedInState()));
  }
}
