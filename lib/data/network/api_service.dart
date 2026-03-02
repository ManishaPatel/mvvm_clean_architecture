import 'dart:convert';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:http/http.dart' as http;
import 'package:mvvm_clean_architecture/core/api_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants.dart';
import '../../core/logger.dart';
import '../../core/utils.dart';


class ApiService {
  final String baseUrl;
  ApiService({this.baseUrl = ApiConstants.baseUrl});

  Future<dynamic> _request({
    required String endpoint,
    required String method,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    List<dynamic>? accumulatedData,
  }) async {
    Uri uri = Uri.parse('$baseUrl$endpoint');

    // Add query parameters if provided
    if (queryParams != null && queryParams.isNotEmpty) {
      uri = uri.replace(queryParameters: queryParams.map((k, v) => MapEntry(k, v.toString())));
    }

    // Initialize headers if null
    headers ??= {};
    headers['Content-type'] = 'application/json';

    final prefs = Get.find<SharedPreferences>();
    final authToken = prefs.getString(Constant.spAuthKey);

    // Add auth_token if the user is logged in
    if (authToken!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
    }

    http.Response response;
    switch (method.toUpperCase()) {
      case 'POST':
        response = await http.post(uri, headers: headers, body: jsonEncode(body));
        break;
      case 'PUT':
        response = await http.put(uri, headers: headers, body: jsonEncode(body));
        break;
      case 'DELETE':
        response = await http.delete(uri, headers: headers, body: jsonEncode(body));
        break;
      case 'PATCH':
        response = await http.patch(uri, headers: headers, body: jsonEncode(body));
        break;
      case 'HEAD':
        response = await http.head(uri, headers: headers);
        break;
      default:
        response = await http.get(uri, headers: headers);
    }

    Log.info("URL :::$uri");
    if (response.statusCode == 204) {
      return response;

    } else if(response.statusCode == 201){
      final responseBody = jsonDecode(response.body);
      Log.info("Response :::$responseBody");
      return responseBody;

    } else if (response.statusCode >= 200 && response.statusCode < 300) {
      final responseBody = jsonDecode(response.body);
      Log.info("Response :::$responseBody");

      if (response.headers.containsKey('x-pagination-page-count')) {
        int totalPages = int.parse(response.headers['x-pagination-page-count']!);
        int currentPage = int.parse(response.headers['x-pagination-current-page']!);

        // Initialize accumulated data if not provided
        accumulatedData ??= [];
        // Add current page data to accumulated data
        accumulatedData.addAll(responseBody);
        if (currentPage < totalPages) {
          // Add a query parameter for the next page
          final nextQueryParams = {
            ...(queryParams ?? {}),
            'page': (currentPage + 1).toString(),
          };
          return _request(
              endpoint: endpoint,
              method: method,
              queryParams: nextQueryParams,
              body: body,
              headers: headers,
              accumulatedData: accumulatedData);
        } else {
          // All pages fetched, return accumulated data
          return accumulatedData;
        }
      } else {
        return responseBody;
      }
    } else if (response.statusCode == 400) {
      final responseBody = jsonDecode(response.body);
      Utils.showToast((responseBody['message']));

    } else if (response.statusCode == 401) {
      final responseBody = jsonDecode(response.body);
      Utils.showToast((responseBody['message']));
      // Get.toNamed(RoutesName.login);

    } else if (response.statusCode == 422) {
      final errorList = jsonDecode(response.body);
      if (errorList is List && errorList.isNotEmpty) {
        String message = '';
        for(int i=0;i<errorList.length;i++) {
          final error = errorList[i];
          if (error is Map<String, dynamic>) {
            message += (i > 0 ? "\n" : "") + (error['message'] ?? "Validation error");
            Utils.showToast(error['message'] ?? "Validation error");
          }
        }
        Utils.showToast(message);
      } else {
        Utils.showToast("Unexpected response format");
      }
      return null;
      // Utils.showToast("field_not_found".tr);
    } else if (response.statusCode == 500){
        final responseBody = jsonDecode(response.body);
        Utils.showToast((responseBody['message']));
        return null;
    } else {
        Utils.showToast("please_try_again_later".tr);
        throw Exception('Failed to perform $method request: ${response.statusCode}');
    }
  }

  // Method-specific functions for ease of use
  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) {
    return _request(
      endpoint: endpoint,
      method: 'GET',
      queryParams: queryParams,
      headers: headers,
    );
  }

  Future<dynamic> post({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _request(
      endpoint: endpoint,
      method: 'POST',
      queryParams: queryParams,
      body: body,
      headers: headers,
    );
  }

  Future<dynamic> delete({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String,dynamic>? data,
    Map<String, String>? headers,
  }) {
    return _request(
      endpoint: endpoint,
      method: 'DELETE',
      queryParams: queryParams,
      body: data,
      headers: headers,
    );
  }

  Future<dynamic> put({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _request(
      endpoint: endpoint,
      method: 'PUT',
      queryParams: queryParams,
      body: body,
      headers: headers,
    );
  }

  Future<dynamic> patch({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) {
    return _request(
      endpoint: endpoint,
      method: 'PATCH',
      queryParams: queryParams,
      body: body,
      headers: headers,
    );
  }

  Future<dynamic> head({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) {
    return _request(
      endpoint: endpoint,
      method: 'HEAD',
      queryParams: queryParams,
      headers: headers,
    );
  }

  Future<dynamic> options({
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) {
    return _request(
      endpoint: endpoint,
      method: 'OPTIONS',
      queryParams: queryParams,
      headers: headers,
    );
  }
}
