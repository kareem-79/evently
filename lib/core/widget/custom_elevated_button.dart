import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, required this.onPress, required this.text});
  final VoidCallback onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(vertical: 16.0.sp),
      child: ElevatedButton(onPressed: onPress, child: Text(text),),
    );
  }
}
