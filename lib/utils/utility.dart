import 'package:chat_assignment/models/models.dart';
import 'package:chat_assignment/utils/utils.dart';
import 'package:chat_assignment/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Utility {
  Utility._();

  static void showInfoDialog(BuildContext context, DialogModel dialog) {
    showDialog(
      context: context,
      builder: (context) => DialogWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dialog.title != null)
              Text(
                dialog.title!,
                style: context.textTheme.titleLarge,
              ),
            const SizedBox(height: 16),
            Text(
              dialog.data,
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Okay',
              onTap: context.pop,
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }
}
