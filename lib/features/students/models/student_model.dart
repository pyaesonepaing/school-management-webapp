class StudentModel {
  final int id;

  final String name;

  final String email;

  final String studentNo;

  StudentModel({
    required this.id,
    required this.name,
    required this.email,
    required this.studentNo,
  });

  factory StudentModel.fromJson(
    Map<String, dynamic> json) {

    return StudentModel(
      id: int.tryParse(
            json['id'].toString(),
          ) ??
          0,

      name:
          json['user']?['name']
              ?.toString() ??
          '',

      email:
          json['user']?['email']
              ?.toString() ??
          '',

      studentNo:
          json['student_no']
              ?.toString() ??
          '',
    );
  }
}