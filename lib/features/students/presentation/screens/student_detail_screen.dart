import 'package:flutter/material.dart';
import 'package:school_management_app/features/students/presentation/screens/student_edit_screen.dart';

import '../../data/student_service.dart';

import '../../../../core/storage/token_storage.dart';
import '../../../../widgets/layouts/admin_layout.dart';

class StudentDetailScreen extends StatefulWidget {
  final int studentId;

  const StudentDetailScreen({
    super.key,
    required this.studentId,
  });

  @override
  State<StudentDetailScreen> createState() =>
      _StudentDetailScreenState();
}

class _StudentDetailScreenState
    extends State<StudentDetailScreen> {

  bool isLoading = true;

  Map<String, dynamic>? student;

  @override
  void initState() {
    super.initState();

    loadStudent();
  }

  Future<void> loadStudent() async {
    try {

      final token =
          await TokenStorage.getToken();

      if (token == null) return;

      final response =
          await StudentService()
              .getStudentDetail(
        token: token,
        studentId: widget.studentId,
      );

      setState(() {
        student = response;
        isLoading = false;
      });

    } catch (e) {

      print(e);

      setState(() {
        isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    return AdminLayout(
      selectedIndex: 1,
      pageTitle: 'Student Detail',

      child: isLoading

          ? const Center(
              child:
                  CircularProgressIndicator(),
            )

          : SingleChildScrollView(

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Row(

                    children: [

                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        'Student Profile',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Row(

                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Container(

                        width: 300,

                        padding:
                            const EdgeInsets.all(24),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius:
                              BorderRadius.circular(
                                  16),

                          boxShadow: const [
                            BoxShadow(
                              color:
                                  Colors.black12,
                              blurRadius: 8,
                            ),
                          ],
                        ),

                        child: Column(

                          children: [

                            CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  const Color(
                                      0xFF1E1E8C),

                              child: Text(
                                student!['user']
                                        ['name']
                                    .substring(0, 1)
                                    .toUpperCase(),

                                style:
                                    const TextStyle(
                                  color:
                                      Colors.white,
                                  fontSize: 32,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(
                                height: 15),

                            Text(
                              student!['user']
                                  ['name'],

                              textAlign:
                                  TextAlign.center,

                              style:
                                  const TextStyle(
                                fontSize: 20,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            const SizedBox(
                                height: 5),

                            Text(
                              student![
                                  'student_no'],
                              style:
                                  const TextStyle(
                                color:
                                    Colors.grey,
                              ),
                            ),

                            const SizedBox(
                                height: 15),

                            Chip(
                              label: Text(
                                student!['user']
                                            ['status'] ==
                                        1
                                    ? 'Active'
                                    : 'Inactive',
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(

                        child: Column(

                          children: [

                            Card(

                              child: Padding(
                                padding:
                                    const EdgeInsets
                                        .all(20),

                                child: Column(

                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    const Text(
                                      'Personal Information',
                                      style:
                                          TextStyle(
                                        fontSize:
                                            20,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),

                                    const Divider(),

                                    ListTile(
                                      title:
                                          const Text(
                                        'Email',
                                      ),
                                      subtitle:
                                          Text(
                                        student![
                                                'user']
                                            ['email'],
                                      ),
                                    ),

                                    ListTile(
                                      title:
                                          const Text(
                                        'Phone',
                                      ),
                                      subtitle:
                                          Text(
                                        student![
                                                    'user']
                                                [
                                                'phone'] ??
                                            '-',
                                      ),
                                    ),

                                    ListTile(
                                      title:
                                          const Text(
                                        'Gender',
                                      ),
                                      subtitle:
                                          Text(
                                        student![
                                                'gender'] ??
                                            '-',
                                      ),
                                    ),

                                    ListTile(
                                      title:
                                          const Text(
                                        'Address',
                                      ),
                                      subtitle:
                                          Text(
                                        student![
                                                'address'] ??
                                            '-',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                                height: 20),

                            Card(

                              child: Padding(
                                padding:
                                    const EdgeInsets
                                        .all(20),

                                child: Column(

                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    const Text(
                                      'Academic Information',
                                      style:
                                          TextStyle(
                                        fontSize:
                                            20,
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),

                                    const Divider(),

                                    ListTile(
                                      title:
                                          const Text(
                                        'Batch',
                                      ),

                                      subtitle:
                                          Text(
                                        student![
                                                    'batches']
                                                .isEmpty
                                            ? 'Not Assigned'
                                            : student![
                                                        'batches']
                                                    [0]
                                                [
                                                'name'],
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),

                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          children: [

                                            const Text(
                                              'Actions',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight:
                                                    FontWeight.bold,
                                              ),
                                            ),

                                            const Divider(),

                                            ElevatedButton.icon(
                                              onPressed: () {

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        StudentEditScreen(
                                                      student: student!,
                                                    ),
                                                  ),
                                                );

                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                              ),
                                              label: const Text(
                                                'Edit Student',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}