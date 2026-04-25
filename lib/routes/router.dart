import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinterest_clone/routes/route_transition.dart';
import 'package:pinterest_clone/routes/routes.dart';
import '../screens/Main_shell_Screen.dart';
import '../screens/SignUp Screens/Create_Name_Screen.dart';
import '../screens/SignUp Screens/Create_Password_Screen.dart';
import '../screens/Startup_screen.dart';
import '../screens/loader_screen.dart';
import '../screens/login_Screen.dart';
import '../features/auth/state/auth_session.dart';
import '../features/auth/state/providers.dart';
import '../screens/saved_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authControllerProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.loader,
    routes: [
      GoRoute(
        path: AppRoutes.loader,
        builder: (context, state) => const LoaderScreen(),
      ),
      GoRoute(
        path: AppRoutes.emailEntry,
        builder: (context, state) => const EmailEntryScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) {
          final email = state.uri.queryParameters['email'];
          return LoginScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.createPassword,
        builder: (context, state) => const CreatePasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.createName,
        pageBuilder: (context, state) {
          return buildAuthSlidePage(
            key: state.pageKey,
            child: const CreateNameScreen(),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const MainShellScreen(currentIndex: 0),
      ),
      GoRoute(
        path: AppRoutes.saved,
        name: 'saved',
        builder: (context, state) => const SavedScreen(),
      ),
    ],
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isAuthRoute = location.startsWith('/auth/');
      final isLoader = location == AppRoutes.loader;

      if (auth.status == AuthStatus.unknown) {
        return isLoader ? null : AppRoutes.loader;
      }

      if (auth.isSubmitting) {
        return null;
      }

      if (auth.status == AuthStatus.authenticated) {
        if (isLoader || isAuthRoute) {
          return AppRoutes.home;
        }
        return null;
      }

      if (auth.status == AuthStatus.unauthenticated) {
        if (location == AppRoutes.home ||
            location == AppRoutes.saved ||
            location == AppRoutes.editProfile ||
            location == AppRoutes.account) {
          return AppRoutes.emailEntry;
        }

        if (isLoader) {
          return AppRoutes.emailEntry;
        }
      }

      return null;
    },
  );
});