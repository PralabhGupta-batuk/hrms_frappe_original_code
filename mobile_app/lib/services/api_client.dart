import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../config/app_config.dart';

class ApiClient {
  late Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  
  ApiClient._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConfig.baseUrl,
      connectTimeout: AppConfig.connectionTimeout,
      receiveTimeout: AppConfig.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    
    // Add interceptors for logging and error handling
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add authentication token if available
        final token = await _storage.read(key: AppConfig.userTokenKey);
        if (token != null) {
          options.headers['Authorization'] = 'token $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }
  
  // Login method
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/api/method/login',
        data: {
          'usr': username,
          'pwd': password,
        },
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Login successful',
          'data': response.data,
        };
      }
      return {
        'success': false,
        'message': 'Login failed',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Login error: ${e.toString()}',
      };
    }
  }
  
  // Logout method
  Future<Map<String, dynamic>> logout() async {
    try {
      final response = await _dio.post(
        AppConfig.getApiUrl(AppConfig.logoutEndpoint),
      );
      
      if (response.statusCode == 200) {
        await _storage.deleteAll();
        return {
          'success': true,
          'message': 'Logout successful',
        };
      }
      return {
        'success': false,
        'message': 'Logout failed',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Logout error: ${e.toString()}',
      };
    }
  }
  
  // Generic GET request
  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(endpoint, queryParameters: params);
    } catch (e) {
      rethrow;
    }
  }
  
  // Generic POST request
  Future<Response> post(String endpoint, {dynamic data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }
  
  // Generic PUT request
  Future<Response> put(String endpoint, {dynamic data}) async {
    try {
      return await _dio.put(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }
  
  // Generic DELETE request
  Future<Response> delete(String endpoint) async {
    try {
      return await _dio.delete(endpoint);
    } catch (e) {
      rethrow;
    }
  }
  
  // Get Frappe resource
  Future<Map<String, dynamic>> getResource(String doctype, String name) async {
    try {
      final response = await get(AppConfig.getResourceUrl(doctype, name));
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      }
      return {
        'success': false,
        'message': 'Failed to fetch resource',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
  
  // Create Frappe resource
  Future<Map<String, dynamic>> createResource(
    String doctype,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await post(
        '/api/resource/$doctype',
        data: {'data': data},
      );
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      }
      return {
        'success': false,
        'message': 'Failed to create resource',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
  
  // Update Frappe resource
  Future<Map<String, dynamic>> updateResource(
    String doctype,
    String name,
    Map<String, dynamic> data,
  ) async {
    try {
      final response = await put(
        AppConfig.getResourceUrl(doctype, name),
        data: {'data': data},
      );
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['data'],
        };
      }
      return {
        'success': false,
        'message': 'Failed to update resource',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
  
  // Call Frappe method
  Future<Map<String, dynamic>> callMethod(
    String method, {
    Map<String, dynamic>? args,
  }) async {
    try {
      final response = await post(
        AppConfig.getApiUrl(method),
        data: args,
      );
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.data['message'],
        };
      }
      return {
        'success': false,
        'message': 'Method call failed',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
}
