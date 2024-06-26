import 'package:chat_assignment/utils/utils.dart';
import 'package:flutter/material.dart';

class NoConversations extends StatelessWidget {
  const NoConversations({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.message,
              size: 48,
              color: AppColors.primary,
            ),
            Text(
              'No Conversations',
              style: context.textTheme.headlineLarge,
            ),
            Text(
              'Click on the + button to create a new conversation',
              style: context.textTheme.titleMedium,
            ),
          ],
        ),
      );
}
