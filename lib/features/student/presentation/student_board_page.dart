import 'package:cornerstone_app/features/user/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentBoardPage extends ConsumerWidget {
  const StudentBoardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final courses = user.getCourses();

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil do Aluno')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, ${user.firstName()}!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            const Text(
              'Seus cursos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: courses.isEmpty
                  ? const Center(child: Text('No course found.'))
                  : ListView.separated(
                      itemCount: courses.length,
                      separatorBuilder: (_, __) => const Divider(),
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return ListTile(
                          title: Text(course.name),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Score: ${course.grade.score.toStringAsFixed(1)}%',
                              ),
                              Text('Absence: ${course.attendance.absences}'),
                            ],
                          ),
                          leading: const Icon(Icons.school),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
