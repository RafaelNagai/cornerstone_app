import 'package:cornerstone_app/core/http/dio_manager.dart';
import 'package:cornerstone_app/core/http/dio_with_converter_manager.dart';
import 'package:cornerstone_app/features/signin/presentation/states/signin_state.dart';
import 'package:cornerstone_app/features/user/domain/entities/user.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthInitial());

  Future<void> signIn(String userId, String password) async {
    state = AuthLoading();

    try {
      final user = await DioWithConverterManager(dio: DioManager()).post<User>(
        '/public/authenticate/login?loginAction=login&userName=$userId&userPass=$password',
        User(name: ''),
      );
      debugPrint(user.name);
      // await DioManager().post<dynamic>(
      //   '/public/authenticate/login?loginAction=login&userName=$userId&userPass=$password',
      // );

      // final uri = Uri.parse(HttpManager.baseUrl);
      // final cookies = await DioManager().cookieJar.loadForRequest(uri);
      // debugPrint('🍪 Cookies salvos: $cookies');

      // final response = await DioManager().get<dynamic>(
      //   'https://ciccc.ampeducator.ca/web/studentPortal/courses/getGrades?courseID=7129',
      // );
      // debugPrint(response.data);
      //Aqui tem que aplicar a logica pra extrair tudo do usuario.

      state = AuthSuccess();
    } catch (e) {
      state = AuthError('Erro ao fazer login');
    }
  }
}
