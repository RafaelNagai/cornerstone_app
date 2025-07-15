import 'package:cornerstone_app/core/http/dio_with_converter_manager.dart';
import 'package:cornerstone_app/features/student/domain/entities/attendance.dart';

class Course extends GetterFromHtml<Course> {
  final String id;
  final String name;
  final Attendance attendance;

  Course({required this.id, required this.name, required this.attendance});

  Course.empty() : id = '', name = '', attendance = Attendance.empty();

  @override
  Course getFromHtml(String html) {
    return Course(
      id: getterFromHtml<String>(html, startWith: 'courseID=', endWith: '">'),
      name: getterFromHtml<String>(
        html,
        startWith: '</strong>&nbsp;&nbsp;',
        endWith: '</span></a>',
      ),
      attendance: Attendance.empty(),
    );
  }
}
