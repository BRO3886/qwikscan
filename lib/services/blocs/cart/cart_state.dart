part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  @override
  List<Object> get props => [];
}

class CartFetchLoading extends CartState {
  @override
  List<Object> get props => [];
}

class AllCartFetchSucess extends CartState {
  final AllCarts carts;

  AllCartFetchSucess({@required this.carts});
  @override
  List<Object> get props => [];
}

class AllCartFetchFailure extends CartState {
  final String message;

  AllCartFetchFailure({@required this.message});
  @override
  List<Object> get props => [];
}

class CartCreateLoading extends CartState {
  @override
  List<Object> get props => [];
}

class CartCreateSuccess extends CartState {
  final Cart cart;

  CartCreateSuccess({@required this.cart});
  @override
  List<Object> get props => [];
}

class CartCreateFailure extends CartState {
  final String message;

  CartCreateFailure({@required this.message});
  @override
  List<Object> get props => [];
}
