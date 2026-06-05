class DashboardModel {
  final int students;
  final int teachers;
  final int campuses;
  final int batches;

  DashboardModel({
    required this.students,
    required this.teachers,
    required this.campuses,
    required this.batches,
  });

  factory DashboardModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final stats = json['statistics'];

    return DashboardModel(
      students: stats['students'] ?? 0,
      teachers: stats['teachers'] ?? 0,
      campuses: stats['campuses'] ?? 0,
      batches: stats['batches'] ?? 0,
    );
  }
}