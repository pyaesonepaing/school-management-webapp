import 'package:flutter/material.dart';
import 'package:school_management_app/features/batches/models/batch_model.dart';

import '../../../../widgets/layouts/admin_layout.dart';
import '../../../../core/storage/token_storage.dart';
import '../../data/student_service.dart';
import '../../../../widgets/dialogs/app_dialog.dart';


class StudentEnrollmentScreen extends StatefulWidget {
  const StudentEnrollmentScreen({super.key});

  @override
  State<StudentEnrollmentScreen> createState() =>
      _StudentEnrollmentScreenState();
}

class _StudentEnrollmentScreenState
    extends State<StudentEnrollmentScreen> {

int? selectedCampusId;

int? selectedLevelId;

int? selectedBatchId;

List<BatchModel> batches = [];

  final nameController =
      TextEditingController();

  final emailController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  final addressController =
      TextEditingController();

  String gender = 'male';

  final List<Map<String, dynamic>>
      pendingStudents = [];


  void addToQueue() {

    pendingStudents.add({

      'name': nameController.text,

      'email': emailController.text,

      'phone': phoneController.text,

      'password': passwordController.text,

      'gender': gender,

      'address': addressController.text,

      'batch_id': selectedBatchId,

    });

    nameController.clear();

    emailController.clear();

    phoneController.clear();

    passwordController.clear();

    addressController.clear();

    setState(() {});
  }


  Future<void> directAdd() async {

    try {

      final token =
          await TokenStorage.getToken();

      if (token == null) return;

      await StudentService().createStudent(

        token: token,

        name:
            nameController.text,

        email:
            emailController.text,

        password:
            passwordController.text,

        phone:
            phoneController.text,

        gender:
            gender,

        address:
            addressController.text,

        batchIds:
            selectedBatchId == null
                ? []
                : [selectedBatchId!],
      );

      if (!mounted) return;

      AppDialog.success(
        context,
        title: 'Student Added',
        message:
            'Student has been enrolled successfully.',
      );


    } catch (e) {

      AppDialog.success(
        context,
        title: 'Student Added',
        message:
            'Student has been enrolled successfully.',
      );

    }
  }

  Future<void> saveAll() async {

    try {

      final token =
          await TokenStorage.getToken();

      if (token == null) return;

      for (final student
          in pendingStudents) {

        await StudentService()
            .createStudent(

          token: token,

          name:
              student['name'],

          email:
              student['email'],

          password:
              student['password'],

          phone:
              student['phone'],

          gender:
              student['gender'],

          address:
              student['address'],

          batchIds:
              student['batch_id'] ==
                      null
                  ? []
                  : [
                      student[
                          'batch_id']
                    ],
        );
      }

      if (!mounted) return;

      AppDialog.success(
        context,
        title: 'Enrollment Complete',
        message:
            '${pendingStudents.length} students have been enrolled successfully.',
      );


    } catch (e) {

      AppDialog.error(
        context,
        title: 'Operation Failed',
        message: e.toString(),
      );

    }
  }

  @override
  Widget build(BuildContext context) {

    return AdminLayout(

      selectedIndex: 1,

      pageTitle:
          'Student Enrollment',

      child: Row(

        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [

          Expanded(
            flex: 2,

            child: Card(

              child: Padding(
                padding: const EdgeInsets.all(20),

                child: SingleChildScrollView(

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

                          const Text(
                            'Student Enrollment',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const Padding(
                        padding: EdgeInsets.only(
                          left: 48,
                        ),
                        child: Text(
                          'Register students individually or in bulk',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [

                          Expanded(
                            child: TextField(
                              controller:
                                  nameController,
                              decoration:
                                  const InputDecoration(
                                labelText:
                                    'Name',
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            child: TextField(
                              controller:
                                  emailController,
                              decoration:
                                  const InputDecoration(
                                labelText:
                                    'Email',
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [

                          Expanded(
                            child: TextField(
                              controller:
                                  phoneController,
                              decoration:
                                  const InputDecoration(
                                labelText:
                                    'Phone',
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            child:
                                DropdownButtonFormField(
                              value: gender,

                              items: const [

                                DropdownMenuItem(
                                  value: 'male',
                                  child:
                                      Text('Male'),
                                ),

                                DropdownMenuItem(
                                  value: 'female',
                                  child:
                                      Text('Female'),
                                ),
                              ],

                              onChanged: (value) {

                                setState(() {
                                  gender =
                                      value.toString();
                                });

                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      const Divider(),

                      const SizedBox(height: 15),

                      const Text(
                        'Account Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller:
                            passwordController,
                        obscureText: true,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'Password',
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Divider(),

                      const SizedBox(height: 15),

                      const Text(
                        'Academy Information (Optional)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Row(
                        children: [

                          Expanded(
                            child:
                                DropdownButtonFormField<
                                    int>(
                              value:
                                  selectedCampusId,

                              decoration:
                                  const InputDecoration(
                                labelText:
                                    'Campus',
                              ),

                              items: const [],

                              onChanged:
                                  (value) {},
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            child:
                                DropdownButtonFormField<
                                    int>(
                              value:
                                  selectedLevelId,

                              decoration:
                                  const InputDecoration(
                                labelText:
                                    'Level',
                              ),

                              items: const [],

                              onChanged:
                                  (value) {},
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            child:
                                DropdownButtonFormField<
                                    int>(

                              value:
                                  selectedBatchId,

                              decoration:
                                  const InputDecoration(
                                labelText:
                                    'Batch',
                              ),

                              items:
                                  batches.map(
                                (batch) {

                                  return DropdownMenuItem(
                                    value:
                                        batch.id,

                                    child:
                                        Text(
                                      batch.name,
                                    ),
                                  );

                                },
                              ).toList(),

                              onChanged:
                                  (value) {

                                setState(() {
                                  selectedBatchId =
                                      value;
                                });

                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25),

                      const Divider(),

                      const SizedBox(height: 15),

                      const Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller:
                            addressController,
                        maxLines: 3,
                        decoration:
                            const InputDecoration(
                          labelText:
                              'Address',
                        ),
                      ),

                      const SizedBox(height: 25),

                      Row(
                        children: [

                          Expanded(
                            child:
                                ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(
                                shape:
                                    const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.zero,
                                ),
                                minimumSize:
                                    const Size
                                        .fromHeight(
                                            50),
                              ),

                              onPressed: addToQueue,

                              child: const Text(
                                'Add To Queue',
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          Expanded(
                            child:
                                ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(
                                shape:
                                    const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.zero,
                                ),
                                minimumSize:
                                    const Size
                                        .fromHeight(
                                            50),
                              ),

                              onPressed: directAdd,

                              child: const Text(
                                'Direct Add',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(
            width: 20,
          ),

          Expanded(
            flex: 1,

            child: Card(

              child: Padding(

                padding:
                    const EdgeInsets.all(
                        20),

                child: Column(

                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,

                  children: [

                    const Text(
                      'Pending Students',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Text(
                      'Total: ${pendingStudents.length}',
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Expanded(

                      child: pendingStudents
                              .isEmpty

                          ? const Center(
                              child: Text(
                                'No students added',
                              ),
                            )

                          : ListView.builder(

                              itemCount:
                                  pendingStudents
                                      .length,

                              itemBuilder:
                                  (
                                context,
                                index,
                              ) {

                                final student =
                                    pendingStudents[
                                        index];

                                return Card(

                                  child:
                                      ListTile(

                                    title: Text(
                                      student[
                                          'name'],
                                    ),

                                    subtitle:
                                        Text(
                                      student[
                                          'email'],
                                    ),

                                    trailing:
                                        IconButton(

                                      onPressed: () {

                                        pendingStudents.removeAt(index);

                                        setState(() {});

                                      },

                                      icon:
                                          const Icon(
                                        Icons
                                            .delete,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        style:
                            ElevatedButton.styleFrom(
                          shape:
                              const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.zero,
                          ),
                          minimumSize:
                              const Size.fromHeight(50),
                        ),

                        onPressed:
                          pendingStudents.isEmpty
                              ? null
                              : saveAll,

                        child: const Text(
                          'Save All',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}