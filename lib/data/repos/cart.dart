import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../services/constants.dart';
import '../../services/utils/api_response.dart';
import '../../services/utils/errors.dart';
import '../models/cart.dart';

class CartRepository {
  final uri = BaseURL + CartGroup;

  Future<ApiResponse<AllCarts>> fetchAllCarts(String token) async {
    final url = uri + ShowAllCartsRoute;

    try {
      final response = await http.get(
        url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      print(response.statusCode);

      switch (response.statusCode) {
        case 200:
          return ApiResponse.completed(
              allCartsFromJson(utf8.decode(response.bodyBytes)));
          break;
        case 401:
          return ApiResponse.error(INVALID_CREDS);
          break;
        case 500:
          return ApiResponse.error(EXCEPTION);
          break;
        default:
          return ApiResponse.error("unhandled! " + EXCEPTION);
          break;
      }
    } on SocketException {
      return ApiResponse.error(NO_INTERNET_CONNECTION);
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(EXCEPTION + "error: ${e.toString()}");
    }
  }

  Future<ApiResponse<Cart>> createCart(String token, String name) async {
    final url = uri + CreateCartRoute;

    try {
      final response = await http.post(
        url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
        body: jsonEncode({
          "cart_name": name,
        }),
      );

      print(response.statusCode);

      switch (response.statusCode) {
        case 201:
          Map<String, dynamic> parsedJson =
              jsonDecode(utf8.decode(response.bodyBytes));
          return ApiResponse.completed(Cart.fromJson(parsedJson["cart"]));
          break;
        case 401:
          return ApiResponse.error(INVALID_CREDS);
          break;
        case 500:
          return ApiResponse.error(EXCEPTION);
          break;
        default:
          return ApiResponse.error("unhandled! " + EXCEPTION);
          break;
      }
    } on SocketException {
      return ApiResponse.error(NO_INTERNET_CONNECTION);
    } catch (e) {
      print(e.toString());
      return ApiResponse.error(EXCEPTION + "error: ${e.toString()}");
    }
  }
}
