import 'package:flutter/material.dart';

class TeacherDashboardScreen
    extends StatelessWidget {

  const TeacherDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Teacher Dashboard'),
      ),

      body: ListView(
        padding:
            const EdgeInsets.all(16),

        children: const [

          ListTile(
            leading:
                Icon(Icons.groups),
            title:
                Text('My Batches'),
          ),

          ListTile(
            leading:
                Icon(Icons.schedule),
            title:
                Text('Today Schedule'),
          ),

          ListTile(
            leading:
                Icon(Icons.assignment),
            title:
                Text('Assignments'),
          ),

          ListTile(
            leading:
                Icon(Icons.quiz),
            title:
                Text('Exams'),
          ),
        ],
      ),
    );
  }
}