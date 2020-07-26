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

class AddCartItem extends CartEvent {
  @override
  List<Object> get props => [];
}

class UpdateCartItem extends CartEvent {
  @override
  List<Object> get props => [];
}

class DeleteCartItem extends CartEvent {
  @override
  List<Object> get props => [];
}

class ShowCartItems extends CartEvent {
  final String cartId;

  ShowCartItems({@required this.cartId});
  @override
  List<Object> get props => [];
}
