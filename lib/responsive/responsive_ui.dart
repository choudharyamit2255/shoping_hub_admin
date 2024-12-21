import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveUi extends StatefulWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveUi({required this.mobile, required this.desktop});

  @override
  State<ResponsiveUi> createState() => _ResponsiveUiState();
}

class _ResponsiveUiState extends State<ResponsiveUi> {

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {

      return LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return widget.desktop;
          } else {
            return widget.mobile;
          }
        },
      );
    } else {
      // For mobile or small screen devices
      return widget.mobile;
    }
  }
}
