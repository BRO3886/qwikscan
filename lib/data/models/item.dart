// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));

String itemsToJson(Items data) => json.encode(data.toJson());

class Items {
  Items({
    this.items,
    this.message,
    this.totalPrice,
  });

  List<Item> items;
  String message;
  int totalPrice;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        message: json["message"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "message": message,
        "total_price": totalPrice,
      };
}

class Item {
  Item({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.itemId,
    this.cartId,
    this.itemName,
    this.itemPrice,
    this.itemQuantity,
    this.itemImageUrl,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String itemId;
  String cartId;
  String itemName;
  int itemPrice;
  int itemQuantity;
  String itemImageUrl;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["ID"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        deletedAt: json["DeletedAt"],
        itemId: json["id"],
        cartId: json["cart_id"],
        itemName: json["item_name"],
        itemPrice: json["item_price"],
        itemQuantity: json["item_quantity"],
        itemImageUrl: json["item_image_url"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
        "DeletedAt": deletedAt,
        "id": itemId,
        "cart_id": cartId,
        "item_name": itemName,
        "item_price": itemPrice,
        "item_quantity": itemQuantity,
        "item_image_url": itemImageUrl,
      };
}
