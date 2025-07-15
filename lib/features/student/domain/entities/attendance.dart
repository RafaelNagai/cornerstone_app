import 'package:cornerstone_app/core/http/dio_with_converter_manager.dart';

class Attendance extends GetterFromHtml<Attendance> {
  int absences;

  Attendance({required this.absences});

  Attendance.empty() : absences = 0;

  @override
  Attendance getFromHtml(String html) {
    throw UnimplementedError('Attendance parsing not implemented yet');
  }
}
