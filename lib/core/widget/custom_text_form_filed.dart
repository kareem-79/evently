import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormFiled extends StatelessWidget {
  const CustomTextFormFiled({
    super.key,
    required this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.secure = false,
    this.validator,
    this.controller,
    this.maxLine = 1,
  });

  final String label;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool secure;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.sp),
      child: TextFormField(
        textAlign: TextAlign.start,
        maxLines: maxLine,
        controller: controller,
        validator: validator,
        obscureText: secure,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
