import 'package:flutter/material.dart';

import '../../data/student_service.dart';
import '../../models/student_model.dart';

import '../../../../core/storage/token_storage.dart';
import '../../../../widgets/layouts/admin_layout.dart';
import 'student_enrollment_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() =>
      _StudentListScreenState();
}

class _StudentListScreenState
    extends State<StudentListScreen> {

  bool isLoading = true;

  List<StudentModel> students = [];
  List<StudentModel> filtered = [];

  final searchController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    loadStudents();
  }

  Future<void> loadStudents() async {
    try {

      final token =
          await TokenStorage.getToken();

      if (token == null) return;

      final response =
          await StudentService()
              .getStudents(token);

      print(response);

      students = response
          .map<StudentModel>(
            (e) =>
                StudentModel.fromJson(e),
          )
          .toList();

      filtered = List.from(students);

      setState(() {
        isLoading = false;
      });

    } catch (e) {

      print(e);

      setState(() {
        isLoading = false;
      });
    }
  }

  void search(String value) {

    filtered = students.where(
      (student) {
        return student.name
            .toLowerCase()
            .contains(
              value.toLowerCase(),
            );
      },
    ).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return AdminLayout(
      selectedIndex: 1,
      pageTitle: 'Students',

      child: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Row(

                  children: [

                    const Text(
                      'Students',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: 160,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const StudentEnrollmentScreen()
                            ),
                          );
                        },
                        child: const Text('Add Student'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20,
                ),

                TextField(
                  controller:
                      searchController,

                  onChanged: search,

                  decoration:
                      const InputDecoration(
                    hintText:
                        'Search Student...',
                    prefixIcon:
                        Icon(Icons.search),
                    border:
                        OutlineInputBorder(),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                Expanded(

                  child: filtered.isEmpty

                      ? Center(

                          child: Column(

                            mainAxisAlignment:
                                MainAxisAlignment
                                    .center,

                            children: [

                              const Icon(
                                Icons.people_outline,
                                size: 100,
                                color:
                                    Colors.grey,
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              const Text(
                                'No Students Found',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              const Text(
                                'Create your first student',
                                style: TextStyle(
                                  color:
                                      Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )

                      : SingleChildScrollView(

                          scrollDirection:
                              Axis.horizontal,

                          child: DataTable(

                            columns: const [

                              DataColumn(
                                label:
                                    Text('ID'),
                              ),

                              DataColumn(
                                label: Text(
                                  'Student No',
                                ),
                              ),

                              DataColumn(
                                label:
                                    Text('Name'),
                              ),

                              DataColumn(
                                label:
                                    Text('Email'),
                              ),
                            ],

                            rows:
                                filtered.map(
                              (student) {

                                return DataRow(

                                  cells: [

                                    DataCell(
                                      Text(
                                        student.id
                                            .toString(),
                                      ),
                                    ),

                                    DataCell(
                                      Text(
                                        student
                                            .studentNo,
                                      ),
                                    ),

                                    DataCell(
                                      Text(
                                        student
                                            .name,
                                      ),
                                    ),

                                    DataCell(
                                      Text(
                                        student
                                            .email,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ),
                ),
              ],
            ),
    );
  }
}