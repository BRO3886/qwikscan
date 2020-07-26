part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({@required this.user});

  @override
  List<Object> get props => [];
}

class LoginFailed extends LoginState {
  final String msg;

  LoginFailed({@required this.msg});
  @override
  List<Object> get props => [];
}
