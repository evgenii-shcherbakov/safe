import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;

  const BaseDialog({
    super.key,
    this.title,
    this.content,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: AlertDialog(
        scrollable: true,
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actionsPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        title: title,
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: content,
        ),
        actions: actions,
        backgroundColor: Theme.of(context).dialogTheme.backgroundColor,
      ),
    );
  }
}
