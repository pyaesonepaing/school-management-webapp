import 'dart:async';

import 'package:flutter/material.dart';

import '../../../auth/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() =>
      _SplashScreenState();
}

class _SplashScreenState
    extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  late Animation<double> scaleAnimation;

  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );

    scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(controller);

    controller.forward();

    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder:
                (_, animation, __) =>
                    const LoginScreen(),

            transitionsBuilder:
                (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      body: Center(

        child: AnimatedBuilder(

          animation: controller,

          builder: (context, child) {

            return Opacity(

              opacity:
                  opacityAnimation.value,

              child: Transform.scale(

                scale:
                    scaleAnimation.value,

                child: Column(

                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  children: [

                    Image.asset(
                      'assets/images/logo.png',
                      height: 220,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    const Text(
                      'Hui Zhi Language Academy',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight:
                            FontWeight.bold,
                        color:
                            Color(0xFF1E1E8C),
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    const Text(
                      'Chinese Language School',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}