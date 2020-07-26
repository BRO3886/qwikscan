// To parse this JSON data, do
//
//     final allCarts = allCartsFromJson(jsonString);

import 'dart:convert';

AllCarts allCartsFromJson(String str) => AllCarts.fromJson(json.decode(str));

String allCartsToJson(AllCarts data) => json.encode(data.toJson());

class AllCarts {
  AllCarts({
    this.carts,
    this.message,
  });

  List<Cart> carts;
  String message;

  factory AllCarts.fromJson(Map<String, dynamic> json) => AllCarts(
        carts: List<Cart>.from(json["carts"].map((x) => Cart.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "carts": List<dynamic>.from(carts.map((x) => x.toJson())),
        "message": message,
      };
}

class Cart {
  Cart({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.cartId,
    this.cartName,
    this.userId,
  });

  int id;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  String cartId;
  String cartName;
  String userId;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["ID"],
        createdAt: DateTime.parse(json["CreatedAt"]),
        updatedAt: DateTime.parse(json["UpdatedAt"]),
        deletedAt: json["DeletedAt"],
        cartId: json["id"],
        cartName: json["cart_name"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CreatedAt": createdAt.toIso8601String(),
        "UpdatedAt": updatedAt.toIso8601String(),
        "DeletedAt": deletedAt,
        "id": cartId,
        "cart_name": cartName,
        "user_id": userId,
      };
}
