import 'package:chat_assignment/blocs/blocs.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:chat_assignment/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) => Hero(
        tag: const ValueKey('auth-form'),
        child: ColoredBox(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: context.read<AuthBloc>().signupKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'SIGN UP',
                    style: context.textTheme.displayMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 40),
                  InputField(
                    controller: nameController,
                    label: 'Name',
                    validator: AppValidators.userName,
                  ),
                  const SizedBox(height: 10),
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
                    onTap: () {
                      final name = nameController.text;
                      final email = emailController.text;
                      final password = passwordController.text;
                      context.read<AuthBloc>().add(SignupWithEmail(name, email, password));
                    },
                    label: 'Signup',
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: context.textTheme.labelLarge,
                      children: [
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: AppColors.primary,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () => context.go(AppRoutes.login),
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
