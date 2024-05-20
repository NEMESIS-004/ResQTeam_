import 'package:flutter/material.dart';
import 'package:redqteam/components/size_fade_switcher.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final void Function(String value) onChanged;
  final String? errorText;
  final bool obscureText;
  final Widget? icon;
  const TextInputField({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.errorText,
    this.obscureText = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1.5,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: TextField(
            obscureText: obscureText,
            onChanged: onChanged,
            decoration: InputDecoration(
                icon: icon,
                fillColor: Theme.of(context).canvasColor,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
        SizeFadeSwitcher(
            child: errorText != null
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                    child: Text(errorText!,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error)))
                : const SizedBox.shrink())
      ],
    );
  }
}
