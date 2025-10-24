import 'dart:developer';

import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/utils/ui_utils.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPassword extends StatelessWidget {
  final UserModel user;
  const ResetPassword({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    AppLocalizations? local = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(local!.reset_password)),
      body: Padding(
        padding: EdgeInsets.all(16.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(ImageAssets.resetPassword, width: 360.w, height: 360.h),
              SizedBox(height: 80.h,),
              CustomElevatedButton(onPress: () {
                _resetPassword(user.email, context);
                Navigator.pop(context);
              },text: local.reset_password,)
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _resetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email:user.email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent!')),
      );
      log("Password reset link sent to: ${user.email}");
    }  catch (e) {
      log("$e");
      UiUtils.showToast("Error", ColorsManager.red);
    }
  }
}
