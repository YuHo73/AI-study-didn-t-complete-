import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/adaptive_scaffold.dart';
import 'pages/library_page.dart';
import 'pages/editor_page.dart';
import 'pages/profile_page.dart';
import 'screens/ai_chat_screen.dart';
import 'blocs/ai_chat/ai_chat_bloc.dart';
import 'pages/lesson_generator_page.dart';
import 'pages/content_converter_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/library',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return AdaptiveScaffold(
          currentIndex: _calculateSelectedIndex(state),
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: '/library',
          builder: (context, state) => const LibraryPage(),
        ),
        GoRoute(
          path: '/editor',
          builder: (context, state) => const EditorPage(),
        ),
        GoRoute(
          path: '/ai',
          builder: (context, state) => BlocProvider(
            create: (context) => AIChatBloc(),
            child: const AIChatScreen(),
          ),
          routes: [
            // AI子路由
            GoRoute(
              path: 'lesson-generator',
              builder: (context, state) => const LessonGeneratorPage(),
            ),
            GoRoute(
              path: 'content-converter',
              builder: (context, state) => const ContentConverterPage(),
            ),
          ],
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);

int _calculateSelectedIndex(GoRouterState state) {
  final String location = state.uri.path;
  if (location.startsWith('/library')) return 0;
  if (location.startsWith('/editor')) return 1;
  if (location.startsWith('/ai')) return 2;
  if (location.startsWith('/profile')) return 3;
  return 0;
} 