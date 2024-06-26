import 'package:chat_assignment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;
}

extension BuildContextExtension on BuildContext {
  LayoutType get type => LayoutType.fromWidth(MediaQuery.of(this).size.width);

  bool get isDesktop => [LayoutType.desktop, LayoutType.desktopLarge].contains(type);

  bool get isMobile => type == LayoutType.mobile;
}

extension MaterialStateExtension on Set<MaterialState> {
  bool get isDisabled => any((e) => [MaterialState.disabled].contains(e));
}

extension DateExtension on DateTime {
  String get formatDate => DateFormat('dd MMM yyyy').format(this);

  String get formatTime => DateFormat.jm().format(this);

  bool isSameDay(DateTime other) => isSameMonth(other) && day == other.day;

  bool isSameMonth(DateTime other) => year == other.year && month == other.month;

  String messageDate() {
    var now = DateTime.now();
    if (now.isSameDay(this)) {
      return 'Today';
    }
    if (now.isSameMonth(this)) {
      if (now.day - day == 1) {
        return 'Yesterday';
      }
      if (now.difference(this) < const Duration(days: 8)) {
        return weekday.weekDayString;
      }
      return formatDate;
    }
    return formatDate;
  }
}

extension IntExtension on int {
  String get weekDayString {
    if (this > 7 || this < 1) {
      throw AppException('Value should be between 1 & 7');
    }
    var weekDays = {
      1: 'Monday',
      2: 'Tuesday',
      3: 'Wednesday',
      4: 'Thursday',
      5: 'Friday',
      6: 'Saturday',
      7: 'Sunday',
    };
    return weekDays[this]!;
  }
}
