import 'package:cornerstone_app/core/http/dio_with_converter_manager.dart';

class Grade extends GetterFromHtml<Grade> {
  final double score;

  Grade({required this.score});

  Grade.empty() : score = 0;

  @override
  Grade getFromHtml(String html) {
    return Grade(
      score: getterFromHtml<double>(
        html,
        startWith: '<span id="gradePointAverage"><strong>',
        endWith: '%</strong><br/>',
        converter: (value) {
          try {
            return double.parse(value);
          } catch (_) {
            return 0.0;
          }
        },
      ),
    );
  }
}
