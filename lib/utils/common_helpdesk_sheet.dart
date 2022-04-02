import 'package:flutter/material.dart';

class CommonHelpdeskSheet extends StatelessWidget {
  final Widget child;

  CommonHelpdeskSheet({required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 50),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12))),
          child: child),
    );
  }
}
