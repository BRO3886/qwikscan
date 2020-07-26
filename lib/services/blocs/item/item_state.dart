part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();
}

class ItemLoading extends ItemState {
  @override
  List<Object> get props => [];
}

class ItemInitial extends ItemState {
  @override
  List<Object> get props => [];
}

class FetchItemsSuccess extends ItemState {
  final Items items;

  FetchItemsSuccess({@required this.items});

  @override
  List<Object> get props => [];
}

class FetchItemsFailure extends ItemState {
  final String message;

  FetchItemsFailure({@required this.message});
  @override
  List<Object> get props => [];
}

class AddItemSuccess extends ItemState {
  final Item item;

  AddItemSuccess({@required this.item});
  @override
  List<Object> get props => [];
}

class AddItemFailure extends ItemState {
  final String message;

  AddItemFailure({@required this.message});
  @override
  List<Object> get props => [];
}

class UpdateItemSuccess extends ItemState {
  @override
  List<Object> get props => [];
}

class UpdateItemFailure extends ItemState {
  final String message;

  UpdateItemFailure({@required this.message});
  @override
  List<Object> get props => [];
}

class DeleteItemSuccess extends ItemState {
  @override
  List<Object> get props => [];
}

class DeleteItemFailure extends ItemState {
  final String message;

  DeleteItemFailure({@required this.message});
  @override
  List<Object> get props => [];
}
