import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../data/models/item.dart';
import '../../../data/repos/item.dart';
import '../../utils/api_response.dart';
import '../../utils/shared_prefs_custom.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial());

  final sp = SharedPrefs();
  final repository = ItemRepository();

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    final token = await sp.getUserToken();
    if (event is GetCartItems) {
      yield ItemLoading();
      final response = await repository.fetchAllItems(token, event.cartId);
      print("cart id is ${event.cartId}");
      switch (response.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          yield FetchItemsSuccess(items: response.data);
          break;
        case Status.ERROR:
          yield FetchItemsFailure(message: response.message);
          break;
      }
    } else if (event is AddItem) {
      yield ItemLoading();
      final response = await repository.addItem(token, event.data);
      switch (response.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          yield AddItemSuccess(item: response.data);
          break;
        case Status.ERROR:
          yield AddItemFailure(message: response.message);
          break;
      }
    }
  }
}
