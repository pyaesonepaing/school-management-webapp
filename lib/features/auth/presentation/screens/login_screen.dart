import 'package:flutter/material.dart';


import '../../data/auth_service.dart';

import '../../../dashboard/admin/presentation/screens/admin_dashboard_screen.dart';

import '../../../dashboard/student/presentation/screens/student_dashboard_screen.dart';

import '../../../dashboard/teacher/presentation/screens/teacher_dashboard_screen.dart';

import '../../../../core/storage/token_storage.dart';
import 'dart:ui';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  bool isLoading = false;

  Future<void> login() async {
  try {
    setState(() {
      isLoading = true;
    });

    final response =
        await AuthService().login(
      email: emailController.text,
      password:
          passwordController.text,
    );

    final token =
        response['token'];

    final role =
        response['user']['role'];

    await TokenStorage.saveToken(
      token,
    );

    await TokenStorage.saveRole(
      role,
    );

    if (!mounted) return;

    if (role ==
        'super_admin') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const AdminDashboardScreen(),
        ),
      );
    } else if (role ==
        'teacher') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const TeacherDashboardScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              const StudentDashboardScreen(),
        ),
      );
    }
  } catch (e) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content:
            Text(e.toString()),
      ),
    );
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

  final emailController =
      TextEditingController();

  final passwordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(

        children: [

          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3,
                sigmaY: 3,
              ),
              child: Container(
                color: Colors.black.withOpacity(
                  0.25,
                ),
              ),
            ),
          ),

          Center(
            child: Container(

              width: 420,

              padding:
                  const EdgeInsets.all(30),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(24),

                boxShadow: [

                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),

                ],
              ),

              child: Column(
                mainAxisSize:
                    MainAxisSize.min,

                children: [

                  Image.asset(
                    'assets/images/logo.png',
                    height: 90,
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    'Hui Zhi Chinese School',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 25),

                  TextField(
                    controller:
                        emailController,
                    decoration:
                        const InputDecoration(
                      labelText:
                          'Email',
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

                  SizedBox(
                    width:
                        double.infinity,

                    child:
                        ElevatedButton(

                      onPressed: login,

                      child: isLoading
                        ? const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [

                              SizedBox(
                                width: 18,
                                height: 18,
                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(width: 12),

                              Text(
                                'Logging In...',
                                style: TextStyle(
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : const Text(
                            'LOGIN',
                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  TextButton(
                    onPressed: () {

                      // later navigate to forgot password page

                    },

                    child: const Text(
                      'Forgot Password?',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}