import 'package:chat_assignment/blocs/blocs.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(StartSplash());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashNavigateAuth) {
              context.go(AppRoutes.login);
            } else if (state is SplashNavigateConversations) {
              context.go(AppRoutes.conversations);
            }
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
}
