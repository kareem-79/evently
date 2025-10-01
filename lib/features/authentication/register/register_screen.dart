import 'dart:developer';
import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/core/utils/ui_utils.dart';
import 'package:evently/core/utils/validation.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_text_button.dart';
import 'package:evently/core/widget/custom_text_form_filed.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late bool secure = true;
  var formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
        elevation: 0,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  ImageAssets.eventlyLogo,
                  height: 186.h,
                  width: 136.w,
                ),
                SizedBox(height: 24.h),
                CustomTextFormFiled(
                  controller: nameController,
                  label: AppLocalizations.of(context)!.name,
                  prefixIcon: Icons.person,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.name_required;
                    }
                    if (input.length < 5) {
                      return AppLocalizations.of(context)!.name_min;
                    }
                    return null;
                  },
                ),
                CustomTextFormFiled(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  label: AppLocalizations.of(context)!.email,
                  prefixIcon: Icons.email,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.email_required;
                    }
                    if (!Validation.isValidateEmail(input)) {
                      return AppLocalizations.of(context)!.email_invalid;
                    }
                    return null;
                  },
                ),
                CustomTextFormFiled(
                  controller: passwordController,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.password_required;
                    }
                    if (input.length < 8) {
                      return AppLocalizations.of(context)!.password_min;
                    }
                    return null;
                  },
                  secure: secure,
                  label: AppLocalizations.of(context)!.password,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    onPressed: () {
                      secure = !secure;
                      setState(() {});
                    },
                    icon: Icon(
                      secure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                CustomElevatedButton(
                  onPress: _createAccount,
                  text: AppLocalizations.of(context)!.create_account,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.already_have_account,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      SizedBox(width: 2.w),
                      CustomTextButton(
                        onPress: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.login,
                          );
                        },
                        text: AppLocalizations.of(context)!.login,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createAccount() async {
    if (formKey.currentState?.validate() ?? false) {
      UiUtils.showLoadingDialog(context);
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        UiUtils.hideDialog(context);
        Navigator.pushReplacementNamed(context, RoutesManager.login);
      } on FirebaseAuthException catch (e) {
        UiUtils.hideDialog(context);
        if (e.code == 'weak-password') {
          UiUtils.showMassage(context, 'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          UiUtils.showMassage(context, 'The account already exists for that email.');
        }
      } catch (e) {
        UiUtils.hideDialog(context);
        UiUtils.showMassage(context, 'Failed to Register.');
      }

    }
  }
}
