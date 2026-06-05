import 'package:dio/dio.dart';

class AuthService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      'http://127.0.0.1:8000/api/login',
      data: {
        'email': email,
        'password': password,
      },
    );

    return response.data;
  }
}