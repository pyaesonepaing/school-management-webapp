import 'package:flutter/material.dart';
import 'package:school_management_app/features/students/presentation/screens/student_detail_screen.dart';

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

  Set<int> selectedStudents = {};

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

                Wrap(
                  spacing: 10,
                  runSpacing: 10,

                  children: [

                    SizedBox(
                      width: 350,
                      child: TextField(
                        controller: searchController,
                        onChanged: search,
                        decoration: const InputDecoration(
                          hintText: 'Search students...',
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: selectedStudents.isEmpty
                            ? null
                            : () {},
                        child: const Text(
                          'Bulk Enroll',
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: selectedStudents.isEmpty
                            ? null
                            : () {},
                        child: const Text(
                          'Bulk Delete',
                        ),
                      ),
                    ),
                  ],
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

                      : ListView.builder(

                          itemCount: filtered.length,

                          itemBuilder: (context, index) {

                            final student =
                                filtered[index];

                            return Container(

                              margin:
                                  const EdgeInsets.only(
                                bottom: 12,
                              ),

                              decoration: BoxDecoration(

                                color: Colors.white,

                                borderRadius:
                                    BorderRadius.circular(12),

                                border: Border.all(
                                  color:
                                      Colors.grey.shade300,
                                ),
                              ),

                              child: Padding(
                                  padding: const EdgeInsets.all(16),

                                  child: Row(

                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,

                                    children: [
                                      Checkbox(

                                        value: selectedStudents.contains(
                                          student.id,
                                        ),

                                        onChanged: (value) {

                                          setState(() {

                                            if (value == true) {

                                              selectedStudents.add(
                                                student.id,
                                              );

                                            } else {

                                              selectedStudents.remove(
                                                student.id,
                                              );

                                            }

                                          });

                                        },
                                      ),
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor:
                                            const Color(0xFF1E1E8C),

                                        child: Text(
                                          student.name
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 16),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [

                                            Text(
                                              student.name,
                                              style:
                                                  const TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),

                                            const SizedBox(height: 4),

                                            Text(student.email),

                                            const SizedBox(height: 8),

                                            Text(
                                              student.studentNo,
                                              style: const TextStyle(
                                                color:
                                                    Color(0xFF1E1E8C),
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Row(
                                        mainAxisSize:
                                            MainAxisSize.min,

                                        children: [

                                          IconButton(
                                            icon: const Icon(
                                              Icons.visibility,
                                              color: Colors.blue,
                                            ),

                                            onPressed: () {

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      StudentDetailScreen(
                                                    studentId:
                                                        student.id,
                                                  ),
                                                ),
                                              );

                                            },
                                          ),

                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.edit,
                                            ),
                                          ),

                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.school,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                            );
                          },
                        )
                ),
              ],
            ),
    );
  }
}