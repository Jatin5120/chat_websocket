import 'package:chat_assignment/blocs/blocs.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:chat_assignment/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) => Hero(
        tag: const ValueKey('auth-form'),
        child: ColoredBox(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: context.read<AuthBloc>().loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'LOGIN',
                    style: context.textTheme.displayMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 40),
                  InputField(
                    controller: emailController,
                    label: 'Email',
                    validator: AppValidators.emailValidator,
                  ),
                  const SizedBox(height: 10),
                  InputField(
                    controller: passwordController,
                    label: 'Password',
                    validator: AppValidators.passwordValidator,
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    label: 'Login',
                    onTap: () {
                      final email = emailController.text;
                      final password = passwordController.text;
                      context.read<AuthBloc>().add(LoginWithEmail(email, password));
                    },
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: context.textTheme.labelLarge,
                      children: [
                        TextSpan(
                          text: 'Signup',
                          style: const TextStyle(
                            color: AppColors.primary,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () => context.go(AppRoutes.signup),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
