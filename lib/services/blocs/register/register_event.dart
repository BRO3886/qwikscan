part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterInitated extends RegisterEvent {
  final Map<String, String> userData;

  RegisterInitated({@required this.userData});
  @override
  // TODO: implement props
  List<Object> get props => [];
}
