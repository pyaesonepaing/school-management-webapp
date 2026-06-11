import 'package:flutter/material.dart';

import '../../../../widgets/layouts/admin_layout.dart';

class StudentEditScreen extends StatefulWidget {

  final Map<String, dynamic> student;

  const StudentEditScreen({
    super.key,
    required this.student,
  });

  @override
  State<StudentEditScreen> createState() =>
      _StudentEditScreenState();
}

class _StudentEditScreenState
    extends State<StudentEditScreen> {

  late TextEditingController
      nameController;

  late TextEditingController
      emailController;

  late TextEditingController
      phoneController;

  late TextEditingController
      addressController;

  String gender = 'male';

  bool status = true;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(
      text:
          widget.student['user']['name'],
    );

    emailController =
        TextEditingController(
      text:
          widget.student['user']['email'],
    );

    phoneController =
        TextEditingController(
      text:
          widget.student['user']['phone'] ??
              '',
    );

    addressController =
        TextEditingController(
      text:
          widget.student['address'] ??
              '',
    );

    gender =
        widget.student['gender'] ??
            'male';

    status =
        widget.student['user']
                ['status'] ==
            1;
  }

  Future<void> saveStudent() async {

    setState(() {
      isSaving = true;
    });

    try {

      /// TODO
      /// call update API here

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        const SnackBar(
          content: Text(
            'Student updated successfully',
          ),
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(

        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );

    }

    setState(() {
      isSaving = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return AdminLayout(

      selectedIndex: 1,

      pageTitle: 'Edit Student',

      child: SingleChildScrollView(

        child: Container(

          padding:
              const EdgeInsets.all(24),

          decoration: BoxDecoration(

            color: Colors.white,

            borderRadius:
                BorderRadius.circular(
                    12),
          ),

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Row(

                children: [

                  IconButton(

                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  const Text(
                    'Edit Student',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 30,
              ),

              Row(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Expanded(

                    flex: 1,

                    child: Container(

                      padding:
                          const EdgeInsets
                              .all(24),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.grey.shade50,

                        borderRadius:
                            BorderRadius.circular(
                                12),
                      ),

                      child: Column(

                        children: [

                          CircleAvatar(
                            radius: 50,

                            backgroundColor:
                                const Color(
                                    0xFF1E1E8C),

                            child: Text(
                              nameController
                                  .text[0]
                                  .toUpperCase(),

                              style:
                                  const TextStyle(
                                fontSize: 32,
                                color:
                                    Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          Text(
                            widget.student[
                                'student_no'],

                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          Chip(
                            label: Text(
                              status
                                  ? 'Active'
                                  : 'Inactive',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 25,
                  ),

                  Expanded(

                    flex: 2,

                    child: Column(

                      children: [

                        TextField(
                          enabled: false,

                          decoration:
                              InputDecoration(
                            labelText:
                                'Student No',

                            hintText:
                                widget.student[
                                    'student_no'],
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        TextField(
                          controller:
                              nameController,

                          decoration:
                              const InputDecoration(
                            labelText:
                                'Name',
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        TextField(
                          controller:
                              emailController,

                          decoration:
                              const InputDecoration(
                            labelText:
                                'Email',
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        TextField(
                          controller:
                              phoneController,

                          decoration:
                              const InputDecoration(
                            labelText:
                                'Phone',
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        DropdownButtonFormField<
                            String>(

                          value: gender,

                          decoration:
                              const InputDecoration(
                            labelText:
                                'Gender',
                          ),

                          items: const [

                            DropdownMenuItem(
                              value:
                                  'male',
                              child:
                                  Text(
                                'Male',
                              ),
                            ),

                            DropdownMenuItem(
                              value:
                                  'female',
                              child:
                                  Text(
                                'Female',
                              ),
                            ),
                          ],

                          onChanged:
                              (value) {

                            setState(() {
                              gender =
                                  value!;
                            });

                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),

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

                        const SizedBox(
                          height: 15,
                        ),

                        SwitchListTile(

                          contentPadding:
                              EdgeInsets.zero,

                          title:
                              const Text(
                            'Active Status',
                          ),

                          value:
                              status,

                          onChanged:
                              (value) {

                            setState(() {
                              status =
                                  value;
                            });

                          },
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        SizedBox(

                          width: double.infinity,

                          height: 50,

                          child:
                              ElevatedButton(

                            onPressed:
                                isSaving
                                    ? null
                                    : saveStudent,

                            child:
                                isSaving

                                    ? const SizedBox(
                                        width:
                                            20,
                                        height:
                                            20,

                                        child:
                                            CircularProgressIndicator(
                                          strokeWidth:
                                              2,
                                          color:
                                              Colors.white,
                                        ),
                                      )

                                    : const Text(
                                        'Save Changes',
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
      ),
    );
  }
}