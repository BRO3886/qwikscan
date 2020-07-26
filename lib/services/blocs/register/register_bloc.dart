import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../data/models/user.dart';
import '../../../data/repos/user.dart';
import '../../utils/api_response.dart';
import '../../utils/shared_prefs_custom.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial());

  final sp = SharedPrefs();
  final repository = UserRepository();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterInitated) {
      yield RegisterLoading();
      final response = await repository.register(event.userData);
      switch (response.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          var user = response.data.user;
          sp.setName(user.name);
          sp.setUserEmail(user.email);
          sp.setUserID(user.userId);
          sp.setUserPhoto(user.imageUrl);
          sp.setUserToken(response.data.token);
          sp.setLoggedInStatus(true);
          yield RegisterSuccess(user: response.data);
          break;
        case Status.ERROR:
          yield RegisterFailed(msg: response.message);
          break;
      }
    }
  }
}
