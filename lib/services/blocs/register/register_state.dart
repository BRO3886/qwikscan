part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [];
}

class RegisterSuccess extends RegisterState {
  final User user;

  RegisterSuccess({@required this.user});
  @override
  List<Object> get props => [];
}

class RegisterFailed extends RegisterState {
  final String msg;

  RegisterFailed({@required this.msg});
  @override
  List<Object> get props => [];
}
