import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/cart.dart';
import '../../../data/repos/cart.dart';
import '../../utils/api_response.dart';
import '../../utils/shared_prefs_custom.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial());

  final sp = SharedPrefs();
  final repository = CartRepository();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    final token = await sp.getUserToken();

    if (event is FetchAllCarts) {
      yield CartFetchLoading();
      final response = await repository.fetchAllCarts(token);

      switch (response.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          yield AllCartFetchSucess(carts: response.data);
          break;
        case Status.ERROR:
          yield AllCartFetchFailure(message: response.message);
          break;
      }
    } else if (event is CreateCart) {
      yield CartCreateLoading();

      final response = await repository.createCart(token, event.name);

      switch (response.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          yield CartCreateSuccess(cart: response.data);
          break;
        case Status.ERROR:
          yield CartCreateFailure(message: response.message);
          break;
      }
    }
  }
}
