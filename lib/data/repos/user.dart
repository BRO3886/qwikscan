import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../services/constants.dart';
import '../../services/utils/api_response.dart';
import '../../services/utils/errors.dart';
import '../models/user.dart';

class UserRepository {
  final _uri = BaseURL + UserGroup;

  Future<ApiResponse<User>> login(String email, String password) async {
    print("entered login");
    final url = _uri + LoginRoute;
    print("logging to : $url");

    try {
      final response = await http.post(
        url,
        // headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      print(response.statusCode);
      print(response.body);
      switch (response.statusCode) {
        case 200:
          return ApiResponse.completed(
            userFromJson(utf8.decode(response.bodyBytes)),
          );
          break;
        case 404:
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

  Future<ApiResponse<User>> register(Map<String, String> data) async {
    print("entered reg");
    final url = _uri + RegisterRoute;
    print("reg to : $url");
    try {
      final response = await http.post(
        url,
        body: jsonEncode(data),
      );

      print(response.statusCode);
      print(response.body);

      switch (response.statusCode) {
        case 201:
          return ApiResponse.completed(
            userFromJson(utf8.decode(response.bodyBytes)),
          );
          break;
        case 409:
          return ApiResponse.error(USER_EXSTS);
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
