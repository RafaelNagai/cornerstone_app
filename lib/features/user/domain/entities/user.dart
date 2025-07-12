import 'package:cornerstone_app/core/http/dio_with_converter_manager.dart';

class User extends GetterFromHtml<User> {
  final String name;

  User({required this.name});

  @override
  User getFromHtml(String html) {
    return User(
      name: getterFromHtml<String>(
        html,
        startWith: '<span class="hidden-xs">&nbsp;&nbsp;',
        endWith: '&nbsp;</span></a>',
      ),
    );
  }
}
