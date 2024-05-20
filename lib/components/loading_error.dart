// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ErrorDialog extends StatelessWidget {
  final String error;
  const ErrorDialog._({super.key, required this.error});

  static Future<void> show(BuildContext context, String errorMessage) {
    return showCupertinoDialog(
        context: context,
        builder: (_) => ErrorDialog._(
              error: errorMessage,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(error),
      actions: [
        CupertinoDialogAction(
          child: const Text("Okay "),
          onPressed: () => Navigator.of(context).pop(),
        )
      ],
    );
  }
}

class LoadingSheet extends StatelessWidget {
  const LoadingSheet._({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(48))),
        context: context,
        builder: (_) => const LoadingSheet._());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
            color: Theme.of(context).colorScheme.secondary, size: 80),
      ),
    );
  }
}
