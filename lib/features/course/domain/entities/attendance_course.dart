import 'package:cornerstone_app/features/student/domain/entities/attendance.dart';

class AttendanceCourse extends Attendance {
  final String courseName;

  AttendanceCourse({required super.absences, required this.courseName});

  AttendanceCourse.empty() : courseName = '', super(absences: 0);

  @override
  AttendanceCourse getFromHtml(String html) {
    final courseDivHtml = html.split('$courseName</td>').last;
    // Limpar espaços e quebras de linha entre as tags
    String cleaned = courseDivHtml
        .replaceAll(RegExp(r'>\s+<'), '><')
        .replaceAll(RegExp(r'[\r\n]+'), '');

    // Pegar todos os valores de <td>...</td> sem considerar conteúdo com <span>
    RegExp tdRegex = RegExp(r'<td[^>]*>(?!<span)(.*?)<\/td>');
    Iterable<Match> matches = tdRegex.allMatches(cleaned);
    return AttendanceCourse(
      absences: matches.first.group(1) != null
          ? int.parse(matches.first.group(1)!)
          : 0,
      courseName: courseName,
    );
  }
}
