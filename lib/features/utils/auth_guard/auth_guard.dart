import 'dart:async';

import 'package:fakestore/features/auth/presentation/bloc/login_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard extends RouteGuard {
  AuthGuard({required this.loginBloc}) : super(redirectTo: '/login');
  final LoginBloc loginBloc;
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    loginBloc..add(CheckLoggedInEvent(path: route.uri.path));
    // Modular.setArugment();
    // Modular.args;
    
    final state = loginBloc.state;
    if (state is LoginSuccess) {
      return true;
    } else {
      return false;
    }
  }


}

