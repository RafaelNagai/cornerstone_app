import 'package:cornerstone_app/features/course/domain/entities/course.dart';
import 'package:cornerstone_app/features/course/domain/entities/grade.dart';
import 'package:cornerstone_app/features/student/domain/entities/attendance.dart';

class StudentCourse extends Course {
  Grade grade;

  StudentCourse({
    required super.id,
    required super.name,
    required this.grade,
    required super.attendance,
  }) : assert(
         grade.score >= 0 && grade.score <= 100,
         'Score must be between 0 and 100',
       );

  StudentCourse.empty()
    : grade = Grade.empty(),
      super(id: '', name: '', attendance: Attendance.empty());

  StudentCourse copyWith({
    String? id,
    String? name,
    Grade? score,
    Attendance? attendance,
  }) {
    return StudentCourse(
      id: id ?? this.id,
      name: name ?? this.name,
      grade: score ?? grade,
      attendance: attendance ?? this.attendance,
    );
  }

  @override
  StudentCourse getFromHtml(String html) {
    final course = super.getFromHtml(html);

    return StudentCourse(
      id: course.id,
      name: course.name,
      grade: Grade.empty(),
      attendance: course.attendance,
    );
  }
}

mixin HasStudentCourses {
  List<StudentCourse> _courses = [];

  void setCourses(List<StudentCourse> courses) {
    _courses = courses;
  }

  void addCourse(StudentCourse course) {
    _courses.add(course);
  }

  List<StudentCourse> getCourses() {
    return _courses;
  }
}
