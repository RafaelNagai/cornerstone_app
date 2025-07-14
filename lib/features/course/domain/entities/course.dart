import 'package:cornerstone_app/core/http/dio_with_converter_manager.dart';

class Course extends GetterFromHtml<Course> {
  final String id;
  final String name;

  Course({required this.id, required this.name});

  Course.empty() : id = '', name = '';

  @override
  Course getFromHtml(String html) {
    return Course(
      id: getterFromHtml<String>(html, startWith: 'courseID=', endWith: '">'),
      name: getterFromHtml<String>(
        html,
        startWith: '</strong>&nbsp;&nbsp;',
        endWith: '</span></a>',
      ),
    );
  }
}
