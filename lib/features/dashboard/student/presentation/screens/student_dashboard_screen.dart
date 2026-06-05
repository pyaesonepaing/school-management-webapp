import 'package:flutter/material.dart';

class StudentDashboardScreen
    extends StatelessWidget {

  const StudentDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Student Dashboard'),
      ),

      body: ListView(
        padding:
            const EdgeInsets.all(16),

        children: const [

          ListTile(
            leading:
                Icon(Icons.schedule),
            title:
                Text('My Schedule'),
          ),

          ListTile(
            leading:
                Icon(Icons.video_call),
            title:
                Text('Meetings'),
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

          ListTile(
            leading:
                Icon(Icons.fact_check),
            title:
                Text('Attendance'),
          ),
        ],
      ),
    );
  }
}