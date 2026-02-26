import 'package:flutter/material.dart';
import 'package:todoapp_riverpod/config/theme/my_colors.dart';

class MyCheckbox extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged;

  const MyCheckbox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: onChanged,
      activeColor: MyColors.foreground,
    );
  }
}
