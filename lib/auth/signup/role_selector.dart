import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/signup_controller.dart';

class RoleSelector extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignUpController = ref.read(signUpProvider.notifier);

    const List<String> roles = <String>['user', 'admin'];
    return DropdownMenu<String>(
      initialSelection: roles.first,
      onSelected: (String? value) => SignUpController.onRoleChange(value!),
      dropdownMenuEntries: roles.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
