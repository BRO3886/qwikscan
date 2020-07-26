import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../data/models/user.dart';
import '../../../data/repos/user.dart';
import '../../utils/api_response.dart';
import '../../utils/shared_prefs_custom.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  final sp = SharedPrefs();
  final repository = UserRepository();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginIniated) {
      yield LoginLoading();
      final apiResponse = await repository.login(event.email, event.password);
      switch (apiResponse.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          yield LoginSuccess(user: apiResponse.data);
          var user = apiResponse.data.user;
          sp.setName(user.name);
          sp.setUserEmail(user.email);
          sp.setUserID(user.userId);
          sp.setUserToken(apiResponse.data.token);
          sp.setLoggedInStatus(true);
          break;
        case Status.ERROR:
          yield LoginFailed(msg: apiResponse.message);
          break;
      }
    }
  }
}
