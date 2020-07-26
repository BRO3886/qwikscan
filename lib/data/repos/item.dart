import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../services/constants.dart';
import '../../services/utils/api_response.dart';
import '../../services/utils/errors.dart';
import '../models/item.dart';

class ItemRepository {
  final uri = BaseURL + CartGroup;
  Future<ApiResponse<Items>> fetchAllItems(String token, String cartId) async {
    final url = uri + ShowItemsInCartRoute + cartId;

    try {
      final response = await http.get(
        url,
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );

      print(response.statusCode);

      switch (response.statusCode) {
        case 200:
          return ApiResponse.completed(
              itemsFromJson(utf8.decode(response.bodyBytes)));
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
