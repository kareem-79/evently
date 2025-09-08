import 'package:evently/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPress,
    required this.text,
  });

  final VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: ColorsManager.blue,
          decoration: TextDecoration.underline,
          decorationColor: ColorsManager.blue,
          fontStyle: FontStyle.italic,
        )
      ),
    );
  }
}
