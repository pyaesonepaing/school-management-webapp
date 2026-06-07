import 'package:flutter/material.dart';


import '../../features/students/presentation/screens/student_list_screen.dart';



class AdminLayout extends StatefulWidget {
  final Widget child;
  final int selectedIndex;
  final String pageTitle;

  const AdminLayout({
    super.key,
    required this.child,
    required this.selectedIndex,
    required this.pageTitle,
  });

  @override
  State<AdminLayout> createState() =>
      _AdminLayoutState();
}

class _AdminLayoutState
    extends State<AdminLayout> {

  void navigateTo(String menuTitle) {

    switch (menuTitle) {

      case 'Students':

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const StudentListScreen(),
          ),
        );

        break;

      case 'Dashboard':

        // later

        break;

      case 'Teachers':

        // later

        break;
    }
  }

  final Color sidebarColor =
      const Color(0xFF111827);

  final Color primaryColor =
      const Color(0xFF1E1E8C);

  final List<Map<String, dynamic>> menus = [

    {
      'title': 'Dashboard',
      'icon': Icons.dashboard_outlined,
    },

    {
      'title': 'Students',
      'icon': Icons.people_outline,
    },

    {
      'title': 'Teachers',
      'icon': Icons.school_outlined,
    },

    {
      'title': 'Campuses',
      'icon': Icons.location_city_outlined,
    },

    {
      'title': 'Batches',
      'icon': Icons.groups_outlined,
    },

    {
      'title': 'Schedules',
      'icon': Icons.schedule_outlined,
    },

    {
      'title': 'Meetings',
      'icon': Icons.video_call_outlined,
    },

    {
      'title': 'Assignments',
      'icon': Icons.assignment_outlined,
    },

    {
      'title': 'Exams',
      'icon': Icons.quiz_outlined,
    },

    {
      'title': 'Attendance',
      'icon': Icons.fact_check_outlined,
    },

    {
      'title': 'Announcements',
      'icon': Icons.campaign_outlined,
    },

    {
      'title': 'Blogs',
      'icon': Icons.article_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Row(

        children: [

          Container(
            width: 250,
            color: sidebarColor,

            child: Column(

              children: [

                const SizedBox(height: 20),

                Container(
                  margin:
                      const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),

                  padding:
                      const EdgeInsets.all(15),

                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius:
                        BorderRadius.circular(12),
                  ),

                  child: Row(
                    children: [

                      Container(
                        width: 60,
                        height: 60,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(12),
                        ),

                        padding: const EdgeInsets.all(5),

                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [

                            Text(
                              'Hui Zhi Academy',
                              style: TextStyle(
                                color:
                                    Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            Text(
                              'Chinese Language School',
                              style: TextStyle(
                                color:
                                    Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(

                    itemCount: menus.length,

                    itemBuilder:
                        (context, index) {

                      final menu =
                          menus[index];

                      final isSelected =
                          widget.selectedIndex ==
                              index;

                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),

                        child: Container(

                          decoration:
                              BoxDecoration(

                            color: isSelected
                                ? primaryColor
                                : Colors.transparent,

                            borderRadius:
                                BorderRadius.circular(
                                    12),
                          ),

                          child: ListTile(

                            leading: Icon(
                              menu['icon'],
                              color: Colors.white,
                            ),

                            title: Text(
                              menu['title'],
                              style:
                                  const TextStyle(
                                color:
                                    Colors.white,
                              ),
                            ),

                            onTap: () {
                              navigateTo(menu['title']);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(

                  margin:
                      const EdgeInsets.all(15),

                  padding:
                      const EdgeInsets.all(12),

                  decoration:
                      BoxDecoration(

                    color: Colors.white10,

                    borderRadius:
                        BorderRadius.circular(
                            12),
                  ),

                  child: Row(

                    children: [

                      const CircleAvatar(
                        backgroundColor:
                            Colors.white,

                        child: Icon(
                          Icons.person,
                          color:
                              Color(0xFF1E1E8C),
                        ),
                      ),

                      const SizedBox(width: 10),

                      const Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [

                            Text(
                              'Admin User',
                              style:
                                  TextStyle(
                                color:
                                    Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),

                            Text(
                              'Super Admin',
                              style:
                                  TextStyle(
                                color:
                                    Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.logout,
                          color:
                              Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(

            child: Container(

              color:
                  const Color(0xFFF5F7FB),

              child: Column(

                children: [

                  Container(
                    height: 70,
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),

                    color: Colors.white,

                    child: Row(

                      children: [

                        Text(
                          widget.pageTitle,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const Spacer(),

                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications_none,
                          ),
                        ),

                        const SizedBox(width: 10),

                        const CircleAvatar(
                          child:
                              Icon(Icons.person),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.all(
                              20),
                      child: widget.child,
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