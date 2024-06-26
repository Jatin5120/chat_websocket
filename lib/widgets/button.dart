import 'package:chat_assignment/utils/utils.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
  }) : icon = null;

  const AppButton.icon({
    super.key,
    required this.icon,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  })  : label = '',
        assert(
          icon != null,
          'icon cannot be null for IsmCallButton.icon',
        );

  final VoidCallback? onTap;
  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  static MaterialStateProperty<TextStyle?> _textStyle(BuildContext context) => MaterialStateProperty.all(
        context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      );

  static MaterialStateProperty<EdgeInsetsGeometry?> _padding() => MaterialStateProperty.all(
        const EdgeInsets.all(16),
      );

  static MaterialStateProperty<OutlinedBorder?> _borderRadius() => MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      );

  @override
  Widget build(BuildContext context) => SizedBox(
        height: icon != null ? null : 48,
        width: icon != null ? null : double.maxFinite,
        child: icon == null
            ? _Primary(
                label: label,
                onTap: onTap,
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
              )
            : _Icon(
                icon: icon!,
                onTap: onTap,
                backgroundColor: backgroundColor,
                foregroundColor: foregroundColor,
              ),
      );
}

class _Primary extends StatelessWidget {
  const _Primary({
    this.onTap,
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
  });

  final VoidCallback? onTap;
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ButtonStyle(
          padding: AppButton._padding(),
          shape: AppButton._borderRadius(),
          backgroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.isDisabled) {
                return AppColors.grey;
              }
              return backgroundColor ?? AppColors.primary;
            },
          ),
          foregroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.isDisabled) {
                return AppColors.grey;
              }

              return foregroundColor ?? AppColors.white;
            },
          ),
          textStyle: AppButton._textStyle(context),
        ),
        onPressed: onTap,
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      );
}

class _Icon extends StatelessWidget {
  const _Icon({
    this.onTap,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  final VoidCallback? onTap;
  final IconData icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) => IconButton(
        style: ButtonStyle(
          shape: AppButton._borderRadius(),
          backgroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.isDisabled) {
                return AppColors.grey;
              }
              const primaryColor = AppColors.primary;

              return backgroundColor ?? primaryColor;
            },
          ),
          foregroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.isDisabled) {
                return AppColors.grey;
              }

              return foregroundColor ?? AppColors.white;
            },
          ),
        ),
        onPressed: onTap,
        icon: Icon(icon),
      );
}
