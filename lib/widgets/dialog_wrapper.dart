import 'dart:math';

import 'package:chat_assignment/utils/utils.dart';
import 'package:flutter/material.dart';

class DialogWrapper extends StatelessWidget {
  const DialogWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      backgroundColor: AppColors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: min(size.width * 0.7, 300),
          maxWidth: min(size.width, 400),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: child,
        ),
      ),
    );
  }
}
