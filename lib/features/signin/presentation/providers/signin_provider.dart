import 'package:cornerstone_app/core/http/dio_manager.dart';
import 'package:cornerstone_app/core/http/dio_with_converter_manager.dart';
import 'package:cornerstone_app/core/http/http_manager.dart';
import 'package:cornerstone_app/features/course/domain/entities/attendance_course.dart';
import 'package:cornerstone_app/features/course/domain/entities/grade.dart';
import 'package:cornerstone_app/features/signin/presentation/states/signin_state.dart';
import 'package:cornerstone_app/features/student/domain/entities/attendance.dart';
import 'package:cornerstone_app/features/user/domain/entities/user.dart';
import 'package:cornerstone_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref),
);

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  AuthNotifier(this.ref) : super(AuthLoading());

  Future<void> signOut() async {
    state = AuthLoading();
    try {
      final uri = Uri.parse(HttpManager.baseUrl);
      await DioManager().cookieJar.delete(uri);
      ref.read(currentUserProvider.notifier).state = null;
      state = AuthInitial();
      await DioWithConverterManager(
        dio: DioManager(),
      ).post<User>('/home/dashboard/prepare', User(name: ''));
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<bool> autoLogin() async {
    state = AuthLoading();
    try {
      final uri = Uri.parse(HttpManager.baseUrl);
      final cookies = await DioManager().cookieJar.loadForRequest(uri);
      final user = await DioWithConverterManager(
        dio: DioManager(),
      ).post<User>('/home/dashboard/prepare', User(name: ''));
      await _authLogin(user);
      return cookies.isNotEmpty;
    } catch (_) {
      return false;
    } finally {
      state = AuthInitial();
    }
  }

  Future<void> signIn(String userId, String password) async {
    state = AuthLoading();

    try {
      final user = await DioWithConverterManager(dio: DioManager()).post<User>(
        '/public/authenticate/login?loginAction=login&userName=$userId&userPass=$password',
        User(name: ''),
      );

      await _authLogin(user);

      state = AuthSuccess();
    } catch (e) {
      state = AuthError(
        e is AuthException ? e.message : 'UserID or Password is incorrect',
      );
      rethrow;
    }
  }

  Future<void> _authLogin(User user) async {
    for (int i = 0; i < user.getCourses().length; i++) {
      final course = user.getCourses()[i];

      final gradeData = await DioWithConverterManager(dio: DioManager()).get<Grade>(
        'https://ciccc.ampeducator.ca/web/studentPortal/courses/getGrades?courseID=${course.id}',
        Grade.empty(),
      );

      final attendanceCourseData =
          await DioWithConverterManager(dio: DioManager()).get<Attendance>(
            'https://ciccc.ampeducator.ca/web/studentPortal/attendance/list',
            AttendanceCourse(absences: 0, courseName: course.name),
          );

      // Atualiza a nota no curso
      user.getCourses()[i] = course.copyWith(
        score: gradeData,
        attendance: attendanceCourseData,
      );
    }

    // Atualiza o estado global do usuário
    ref.read(currentUserProvider.notifier).state = user;
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}
