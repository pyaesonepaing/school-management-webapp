import 'package:dio/dio.dart';

class StudentService {

  final Dio dio = Dio();

  Future<List<dynamic>> getStudents(
    String token) async {

    final response = await dio.get(
      'http://127.0.0.1:8000/api/admin/students',
      options: Options(
        headers: {
          'Authorization':
              'Bearer $token',
          'Accept':
              'application/json',
        },
      ),
    );

    print(response.data);

    return response.data;
  }

  Future<void> createStudent({
    required String token,
    required String name,
    required String email,
    required String password,
    String? phone,
    String? gender,
    String? dob,
    String? address,
    List<int>? batchIds,
  }) async {
    try {
      await dio.post(
        'http://127.0.0.1:8000/api/admin/students',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'gender': gender,
          'dob': dob,
          'address': address,
          'batch_ids': batchIds,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      print('Student created successfully');
    } on DioException catch (e) {
      print('STATUS: ${e.response?.statusCode}');
      print('DATA: ${e.response?.data}');
    } catch (e) {
      // Catch any other unexpected errors
      print('Unexpected error: $e');
    }
  }

  Future<Map<String, dynamic>>
    getStudentDetail({
    required String token,
    required int studentId,
  }) async {

    final response = await dio.get(
      'http://127.0.0.1:8000/api/admin/students/$studentId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    return response.data;
  }


  Future<void> updateStudent({

    required String token,
    required int studentId,

    required String name,
    required String email,

    String? phone,
    String? gender,
    String? address,

    required bool status,

  }) async {

    await dio.put(

      'http://127.0.0.1:8000/api/admin/students/$studentId',

      data: {

        'name': name,
        'email': email,
        'phone': phone,
        'gender': gender,
        'address': address,
        'status': status,

      },

      options: Options(
        headers: {
          'Authorization':
              'Bearer $token',
        },
      ),
    );
  }


}