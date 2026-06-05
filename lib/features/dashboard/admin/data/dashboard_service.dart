import 'package:dio/dio.dart';

class DashboardService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getDashboard(
    String token,
  ) async {
    final response = await dio.get(
      'http://127.0.0.1:8000/api/admin/dashboard',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    return response.data;
  }
}