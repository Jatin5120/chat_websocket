import 'package:chat_assignment/utils/utils.dart';
import 'package:flutter/material.dart';

ThemeData kTheme(BuildContext context) => ThemeData.light().copyWith(
      primaryColor: AppColors.primary,
      iconTheme: const IconThemeData(color: AppColors.white),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        titleTextStyle: context.textTheme.titleLarge?.copyWith(
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
        actionsIconTheme: const IconThemeData(color: AppColors.white),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      scaffoldBackgroundColor: Colors.transparent,
    );
