import 'package:cornerstone_app/core/http/dio_manager.dart';
import 'package:cornerstone_app/core/http/dio_with_converter_manager.dart';
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
  AuthNotifier(this.ref) : super(AuthInitial());

  Future<void> signIn(String userId, String password) async {
    state = AuthLoading();

    try {
      final user = await DioWithConverterManager(dio: DioManager()).post<User>(
        '/public/authenticate/login?loginAction=login&userName=$userId&userPass=$password',
        User(name: ''),
      );

      for (int i = 0; i < user.getCourses().length; i++) {
        final course = user.getCourses()[i];

        final gradeData = await DioWithConverterManager(dio: DioManager())
            .get<Grade>(
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

      state = AuthSuccess();
    } catch (e) {
      state = AuthError('Login failed: ${e.toString()}');
      rethrow;
    }
  }
}
