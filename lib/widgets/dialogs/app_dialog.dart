import 'package:flutter/material.dart';

class AppDialog {

  static void success(
    BuildContext context, {
    required String title,
    required String message,
  }) {

    showDialog(
      context: context,

      builder: (_) {

        return AlertDialog(

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),

          title: Row(
            children: [

              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),

              const SizedBox(width: 10),

              Text(title),
            ],
          ),

          content: Text(message),

          actions: [

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void error(
    BuildContext context, {
    required String title,
    required String message,
  }) {

    showDialog(
      context: context,

      builder: (_) {

        return AlertDialog(

          title: Row(
            children: [

              const Icon(
                Icons.error,
                color: Colors.red,
              ),

              const SizedBox(width: 10),

              Text(title),
            ],
          ),

          content: Text(message),

          actions: [

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String message,
  }) {

    return showDialog<bool>(
      context: context,

      builder: (_) {

        return AlertDialog(

          title: Text(title),

          content: Text(message),

          actions: [

            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text(
                'Confirm',
              ),
            ),
          ],
        );
      },
    );
  }
}