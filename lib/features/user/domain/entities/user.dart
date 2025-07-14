import 'package:cornerstone_app/core/http/dio_with_converter_manager.dart';
import 'package:cornerstone_app/features/course/domain/entities/student_course.dart';

class User extends GetterFromHtml<User> with HasStudentCourses {
  final String name;

  User({required this.name, List<StudentCourse>? courses}) {
    if (courses != null) {
      setCourses(courses);
    }
  }

  String firstName() {
    return name.split(' ').first;
  }

  @override
  User getFromHtml(String html) {
    final coursesHtml = html.split(
      '<ul class="dropdown-menu nav-menu-dropdown-menu nav-menu-dropdown-menu-short">',
    );
    coursesHtml.removeAt(0);
    final coursesItemHtml = coursesHtml.first.split(
      '<li><a href="/web/studentPortal/courses/getHome',
    );
    coursesItemHtml.removeAt(0);

    final courses = <StudentCourse>[];
    for (var courseHtml in coursesItemHtml) {
      if (courseHtml.isNotEmpty) {
        final course = StudentCourse.empty().getFromHtml(courseHtml);
        courses.add(course);
      }
    }

    return User(
      name: getterFromHtml<String>(
        html,
        startWith: '<span class="hidden-xs">&nbsp;&nbsp;',
        endWith: '&nbsp;</span></a>',
      ),
      courses: courses,
    );
  }
}

late final User currentUser;
