import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,
  }) : super(key: key);

  static bool isDisplayTablet(BuildContext context) =>
      getWindowType(context) >= AdaptiveWindowType.medium;
  static bool isDisplayMobile(BuildContext context) =>
      getWindowType(context) < AdaptiveWindowType.medium;
  @override
  Widget build(BuildContext context) {
    AdaptiveWindowType currentEntry = getWindowType(context);

    switch (currentEntry) {
      case AdaptiveWindowType.xsmall:
        return mobile;
      case AdaptiveWindowType.small:
        return mobile;
      case AdaptiveWindowType.medium:
        return tablet;
      case AdaptiveWindowType.large:
        return tablet;
      case AdaptiveWindowType.xlarge:
        return tablet;
      default:
        throw AssertionError('Unsupported AdaptiveWindowType');
    }
  }
}
