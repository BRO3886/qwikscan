part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();
}

class AddItem extends ItemEvent {
  final Map<String, dynamic> data;

  AddItem({@required this.data});
  @override
  List<Object> get props => [];
}

class UpateItem extends ItemEvent {
  @override
  List<Object> get props => [];
}

class DeleteItem extends ItemEvent {
  @override
  List<Object> get props => [];
}

class GetCartItems extends ItemEvent {
  final String cartId;

  GetCartItems({@required this.cartId});
  @override
  List<Object> get props => [];
}
