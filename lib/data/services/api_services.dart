import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:youapp_assignment/data/models/profile_model.dart';
import '../models/auth_model.dart';

class ApiService {
  static const String baseUrl = 'https://techtest.youapp.ai/api';
  final Dio _dio = Dio();
  final _storage = GetStorage();

  ApiService() {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = _storage.read('token');
        if (token != null) {
          options.headers['x-access-token'] = token;
        }
        return handler.next(options);
      },
    ));
  }

  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post('/login', data: request.toJson());
      final authResponse = AuthResponse.fromJson(response.data);
      if (authResponse.accessToken != null) {
        await _storage.write('token', authResponse.accessToken);
        print('Token saved: ${authResponse.accessToken}');
      }
      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await _dio.post('/register', data: request.toJson());
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Profile> getProfile() async {
    try {
      final response = await _dio.get('/getProfile');
      print(response);
      return Profile.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Profile> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await _dio.put('/updateProfile', data: data);
      print('respose $response');
      return Profile.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException error) {
    if (error.response?.data != null &&
        error.response?.data['message'] != null) {
      return error.response?.data['message'];
    }
    return 'An error occurred. Please try again.';
  }
}
