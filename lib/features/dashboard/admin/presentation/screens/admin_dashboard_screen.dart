import 'package:flutter/material.dart';

import '../../data/dashboard_service.dart';
import '../../models/dashboard_model.dart';

import '../../../../../core/storage/token_storage.dart';
import '../../../../../widgets/layouts/admin_layout.dart';

class AdminDashboardScreen
    extends StatefulWidget {
  const AdminDashboardScreen({
    super.key,
  });

  @override
  State<AdminDashboardScreen>
      createState() =>
          _AdminDashboardScreenState();
}

class _AdminDashboardScreenState
    extends State<AdminDashboardScreen> {

  DashboardModel? dashboard;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadDashboard();
  }

  Future<void> loadDashboard() async {
    try {

      final token =
          await TokenStorage.getToken();

      if (token == null) return;

      final response =
          await DashboardService()
              .getDashboard(token);

      dashboard =
          DashboardModel.fromJson(
        response,
      );

      setState(() {
        isLoading = false;
      });

    } catch (e) {

      setState(() {
        isLoading = false;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
    selectedIndex: 0,
    pageTitle: 'Dashboard',
    child: isLoading
      ? const Center(
          child: CircularProgressIndicator(),
        )
          : SingleChildScrollView(
              padding:
                  const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  const SizedBox(
                    height: 20,
                  ),

                  GridView.count(
                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    crossAxisCount: 4,
                    childAspectRatio: 1.8,

                    crossAxisSpacing: 15,

                    mainAxisSpacing: 15,

                    children: [

                      StatCard(
                        title: 'Students',
                        value: dashboard!
                            .students
                            .toString(),
                        icon:
                            Icons.people,
                      ),

                      StatCard(
                        title: 'Teachers',
                        value: dashboard!
                            .teachers
                            .toString(),
                        icon:
                            Icons.person,
                      ),

                      StatCard(
                        title: 'Campuses',
                        value: dashboard!
                            .campuses
                            .toString(),
                        icon:
                            Icons.location_city,
                      ),

                      StatCard(
                        title: 'Batches',
                        value: dashboard!
                            .batches
                            .toString(),
                        icon:
                            Icons.groups,
                      ),

                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  const Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(16),

                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black12,
                        ),
                      ],
                    ),

                    child: const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          'Recent Announcements',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        SizedBox(height: 15),

                        Text(
                          'No announcements yet',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(16),

                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black12,
                        ),
                      ],
                    ),

                    child: const Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          'Recent Blogs',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        SizedBox(height: 15),

                        Text(
                          'No blogs yet',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),

        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          )
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 24,
            backgroundColor:
                const Color(0xFF1E1E8C)
                    .withOpacity(.1),

            child: Icon(
              icon,
              color:
                  const Color(0xFF1E1E8C),
            ),
          ),

          const SizedBox(width: 12),

          Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}