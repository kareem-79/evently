import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/widget/custom_text_form_filed.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool secure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h),
              Image.asset(ImageAssets.eventlyLogo, height: 186.h, width: 136.w),
              SizedBox(height: 24.h),
              CustomTextFormFiled(
                keyboardType: TextInputType.emailAddress,
                label: "E-mail",
                prefixIcon: Icons.email,
              ),
              CustomTextFormFiled(
                secure: secure,
                label: "Password",
                prefixIcon: Icons.lock,
                suffixIcon: IconButton(
                  onPressed: () {
                    secure = !secure;
                    setState(() {});
                  },
                  icon: Icon(secure?Icons.visibility_off:Icons.visibility),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(onPress: () {}, text: "Forget Password ?"),
                  ],
                ),
              ),
              CustomElevatedButton(
                onPress: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutesManager.register,
                  );
                },
                text: "Login",
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don’t Have Account ?",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    CustomTextButton(
                      onPress: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.register,
                        );
                      },
                      text: "Create Account",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1.sp,
                      color: ColorsManager.blue,
                      indent: 26,
                      endIndent: 16,
                    ),
                  ),
                  Text(
                    "Or",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      color: ColorsManager.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1.sp,
                      color: ColorsManager.blue,
                      indent: 16,
                      endIndent: 26,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  side: BorderSide(color: ColorsManager.blue),
                ),
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.all(12.0.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(ImageAssets.googleLogo),
                      SizedBox(width: 10.w),
                      Text(
                        "Login With Google",
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsManager.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
