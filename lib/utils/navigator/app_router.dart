import 'package:chat_assignment/blocs/auth/auth.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:chat_assignment/views/views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();

  static final _navigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router(BuildContext context) => GoRouter(
        initialLocation: AppRoutes.splash,
        navigatorKey: _navigatorKey,
        redirect: (context, state) {
          final isAuth = state.matchedLocation == AppRoutes.login || state.matchedLocation == AppRoutes.signup;

          if (!isAuth) {
            final authBloc = context.read<AuthBloc>();
            if (authBloc.isLoggedIn()) {
              return null;
            }
            return AppRoutes.login;
          }
          return null;
        },
        routes: [
          GoRoute(
            path: AppRoutes.splash,
            builder: (context, state) => const SplashView(),
          ),
          GoRoute(
            path: AppRoutes.login,
            builder: (context, state) => const LoginView(),
          ),
          GoRoute(
            path: AppRoutes.signup,
            builder: (context, state) => const SignupView(),
          ),
          // GoRoute(
          //   path: AppRoutes.conversations,
          //   builder: (context, state) => const ConversationsView(),
          //   routes: [
          //     GoRoute(
          //       path: ':conversationId',
          //       builder: (context, state) {
          //         final conversationId = state.pathParameters['conversationId'];
          //         return ConversationsView(conversationId: conversationId);
          //       },
          //     ),
          //   ],
          // ),
          GoRoute(
            path: AppRoutes.conversations,
            builder: (context, state) {
              final conversationId = state.extra as String?;
              return ConversationsView(conversationId: conversationId);
            },
          ),
          // GoRoute(
          //   path: '${AppRoutes.chat}/:conversationId',
          //   builder: (context, state) {
          //     final conversationId = state.pathParameters['conversationId']!;
          //     return ChatView(conversationId: conversationId);
          //   },
          // ),
        ],
      );
}
