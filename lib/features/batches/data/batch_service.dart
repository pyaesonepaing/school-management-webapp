import 'package:dio/dio.dart';

class BatchService {

  final Dio dio = Dio();

  Future<List<dynamic>> getBatches(
    String token,
  ) async {

    final response = await dio.get(
      'http://127.0.0.1:8000/api/admin/batches',
      options: Options(
        headers: {
          'Authorization':
              'Bearer $token',
          'Accept':
              'application/json',
        },
      ),
    );

    return response.data;
  }
}