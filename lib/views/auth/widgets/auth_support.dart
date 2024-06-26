import 'package:chat_assignment/utils/utils.dart';
import 'package:flutter/material.dart';

class AuthSupport extends StatelessWidget {
  const AuthSupport({
    super.key,
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) => Hero(
        tag: const ValueKey('auth-support'),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              label,
              style: context.textTheme.displayMedium?.copyWith(
                color: AppColors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
