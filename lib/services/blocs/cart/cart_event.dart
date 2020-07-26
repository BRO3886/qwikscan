part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class FetchAllCarts extends CartEvent {
  @override
  List<Object> get props => [];
}

class CreateCart extends CartEvent {
  final String name;

  CreateCart({@required this.name});
  @override
  List<Object> get props => [];
}

class EditCartName extends CartEvent {
  @override
  List<Object> get props => [];
}
