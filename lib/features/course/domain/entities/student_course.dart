import 'package:cornerstone_app/features/course/domain/entities/course.dart';
import 'package:cornerstone_app/features/course/domain/entities/grade.dart';

class StudentCourse extends Course {
  Grade grade;

  StudentCourse({required super.id, required super.name, required this.grade});

  StudentCourse.empty() : grade = Grade.empty(), super(id: '', name: '');

  StudentCourse copyWith({String? id, String? name, Grade? score}) {
    return StudentCourse(
      id: id ?? this.id,
      name: name ?? this.name,
      grade: score ?? grade,
    );
  }

  @override
  StudentCourse getFromHtml(String html) {
    final course = super.getFromHtml(html);

    return StudentCourse(
      id: course.id,
      name: course.name,
      grade: Grade.empty(),
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
