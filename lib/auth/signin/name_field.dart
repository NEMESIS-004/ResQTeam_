import 'package:flutter/material.dart';

import '../../components/text_input.dart';

class NameField extends StatelessWidget {
  const NameField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextInputField(
      hintText: "Name",
      icon: const Icon(Icons.person),
      onChanged: (_) {},
    );
  }
}
