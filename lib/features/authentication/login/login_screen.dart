import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/utils/validation.dart';
import '../../../core/widget/custom_text_form_filed.dart';
import '../../../l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool secure = true;
  var formKey=GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController=TextEditingController();
    passwordController=TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 40.h),
                Image.asset(ImageAssets.eventlyLogo, height: 186.h, width: 136.w),
                SizedBox(height: 24.h),
                CustomTextFormFiled(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  label: AppLocalizations.of(context)!.email,
                  prefixIcon: Icons.email,
                  validator: (input) {
                    if(input==null||input.trim().isEmpty){
                      return AppLocalizations.of(context)!.email_required;
                    }
                    if(!Validation.isValidateEmail(input)){
                      return AppLocalizations.of(context)!.email_invalid;
                    }
                    return null;
                  },
                ),
                CustomTextFormFiled(
                  controller: passwordController,
                  secure: secure,
                  label: AppLocalizations.of(context)!.password,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    onPressed: () {
                      secure = !secure;
                      setState(() {});
                    },
                    icon: Icon(secure?Icons.visibility_off:Icons.visibility),
                  ),
                  validator: (input) {
                    if(input==null||input.trim().isEmpty){
                      return AppLocalizations.of(context)!.password_required;
                    }
                    if(input.length<8){
                      return AppLocalizations.of(context)!.password_min;
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(onPress: () {}, text: AppLocalizations.of(context)!.forget_password),
                    ],
                  ),
                ),
                CustomElevatedButton(
                  onPress: _login,
                  text: AppLocalizations.of(context)!.login,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.do_not_have_account,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(width: 2.w,),
                      CustomTextButton(
                        onPress: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.register,
                          );
                        },
                        text: AppLocalizations.of(context)!.create_account,
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
                      AppLocalizations.of(context)!.or,
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
                          AppLocalizations.of(context)!.login_with_google,
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
      ),
    );

  }
  void _login() {
    if (formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
    }
  }
}
