import 'package:chat_assignment/utils/utils.dart';

enum LayoutType {
  mobile(AppConstants.maxMobileWidth),
  tablet(AppConstants.maxTabletWidth),
  desktop(AppConstants.maxDesktopWidth),
  desktopLarge(AppConstants.maxLargeDesktopWidth);

  factory LayoutType.fromWidth(double width) {
    if (width <= LayoutType.mobile.maxWidth) {
      return LayoutType.mobile;
    }
    if (width <= LayoutType.tablet.maxWidth) {
      return LayoutType.tablet;
    }
    if (width <= LayoutType.desktop.maxWidth) {
      return LayoutType.desktop;
    }
    return LayoutType.desktopLarge;
  }

  const LayoutType(this.maxWidth);
  final double maxWidth;
}

enum MessageType {
  text,
  date;

  factory MessageType.fromName(String data) =>
      {
        MessageType.text.name: MessageType.text,
        MessageType.date.name: MessageType.date,
      }[data.toLowerCase()] ??
      MessageType.text;
}
