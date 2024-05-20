import 'package:flutter/material.dart';

class DividerSignIn extends StatelessWidget {
  const DividerSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(children: [
        const Expanded(child: Divider()),
        Text(
          " OR ",
          style: TextStyle(color: Theme.of(context).dividerColor),
        ),
        const Expanded(child: Divider()),
      ]),
    );
  }
}
