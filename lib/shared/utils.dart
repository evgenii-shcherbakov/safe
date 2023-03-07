import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> showAnimatedDialog({
  required BuildContext context,
  required Widget Function(BuildContext) dialogBuilder,
  String barrierLabel = 'barrier',
  bool canSkip = true,
}) async {
  await showGeneralDialog(
    context: context,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return SafeArea(
        top: false,
        child: Builder(builder: (BuildContext ctx) {
          return Theme(
            data: Theme.of(ctx),
            child: dialogBuilder(ctx),
          );
        }),
      );
    },
    transitionBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        )
            .chain(
              CurveTween(
                curve: Curves.linear,
              ),
            )
            .animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 600),
    barrierDismissible: canSkip,
    barrierLabel: barrierLabel,
  );
}

bool isMobile() {
  return !kIsWeb && (Platform.isAndroid || Platform.isIOS);
}
