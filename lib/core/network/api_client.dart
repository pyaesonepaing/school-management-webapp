import 'package:dio/dio.dart';
import 'package:school_management_app/core/constants/api_constants.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      headers: {
        'Accept': 'application/json',
      },
    ),
  );
}