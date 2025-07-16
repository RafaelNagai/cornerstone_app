import 'package:cornerstone_app/features/signin/presentation/providers/signin_provider.dart';
import 'package:cornerstone_app/features/student/presentation/components/course_card.dart';
import 'package:cornerstone_app/features/user/presentation/providers/user_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StudentBoardPage extends ConsumerStatefulWidget {
  const StudentBoardPage({super.key});

  @override
  ConsumerState<StudentBoardPage> createState() => _StudentBoardPageState();
}

class _StudentBoardPageState extends ConsumerState<StudentBoardPage> {
  final List<dynamic> _courses = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), _loadCourses);
  }

  void _loadCourses() async {
    final user = ref.read(currentUserProvider);
    if (user != null) {
      final courses = user.getCourses();
      for (int i = 0; i < courses.length; i++) {
        await Future.delayed(Duration(milliseconds: 100));
        if (mounted) {
          setState(() => _courses.add(courses[i]));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).padding.bottom;
    final user = ref.watch(currentUserProvider);

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(color: Color(0xFF002855)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Hi, {name}!'.tr(
                              namedArgs: {'name': user.firstName()},
                            ),
                            style: TextStyle(
                              color: Colors.yellow.shade400,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            'Welcome to cornerstone app.'.tr(),
                            style: TextStyle(color: Colors.grey.shade200),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: Text('Logout'.tr()),
                      onTap: () {
                        ref.read(authProvider.notifier).signOut();
                        context.pushReplacement('/signin');
                      },
                    ),
                  ],
                ),
              ),
              Text(
                "Version: 1.0.0",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  "By Rafael Kenji Sales Nagai",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            snap: true,
            pinned: true,
            title: Text(
              'Hi, {name}!'.tr(namedArgs: {'name': user.firstName()}),
            ),
            actions: [
              Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(40),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'Your Courses'.tr(),
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ),
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(color: Color(0xFF002855)),
            ),
          ),
          _courses.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      'No courses found.'.tr(),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                )
              : SliverPadding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: bottom + 20,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final course = _courses[index];
                      return TweenAnimationBuilder<Offset>(
                        duration: Duration(milliseconds: 500 + (index * 100)),
                        tween: Tween(
                          begin: const Offset(-1, 0),
                          end: Offset.zero,
                        ),
                        curve: Curves.easeOut,
                        builder: (context, offset, child) {
                          return Transform.translate(
                            offset: Offset(offset.dx * 100, 0),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: CourseCard(
                                name: course.name,
                                score: course.grade.score,
                                absences: course.attendance.absences,
                              ),
                            ),
                          );
                        },
                      );
                    }, childCount: _courses.length),
                  ),
                ),
        ],
      ),
    );
  }
}
