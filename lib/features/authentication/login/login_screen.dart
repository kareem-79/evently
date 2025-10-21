import 'package:evently/core/prefs_manager/prefs_manager.dart';
import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/core/utils/ui_utils.dart';
import 'package:evently/core/utils/validation.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_text_button.dart';
import 'package:evently/core/widget/custom_text_form_filed.dart';
import 'package:evently/firebase/firebase_services.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/user_model.dart';
import 'package:evently/provider/config_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late bool secure = true;
  var formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
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
                Image.asset(
                  ImageAssets.eventlyLogo,
                  height: 186.h,
                  width: 136.w,
                ),
                SizedBox(height: 24.h),
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
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return AppLocalizations.of(context)!.password_required;
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextButton(
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            RoutesManager.resetPasswordScreen,arguments: UserModel(
                            id: '',
                            name: '',
                            email: emailController.text.trim(),
                            favouriteEventIds: [],
                          ),
                          );
                        },
                        text: AppLocalizations.of(context)!.forget_password,
                      ),
                    ],
                  ),
                ),
                CustomElevatedButton(
                  onPress: login,
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
                      SizedBox(width: 2.w),
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
                  onPressed: () async {
                    await FirebaseServices.signInWithGoogle(context);
                    if (FirebaseAuth.instance.currentUser != null) {
                      UserModel.currentUser =
                          await FirebaseServices.getUserFromFireStore(
                            FirebaseAuth.instance.currentUser!.uid,
                          );
                      _navigate();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(14.0.sp),
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
                SizedBox(height: 24.h,),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: ColorsManager.blue)
                    ),
                    child: ToggleSwitch(
                      minWidth: 60,
                      cornerRadius: 30,
                      curve: Curves.easeOutQuart,
                      animate: true,
                      animationDuration: 300,
                      initialLabelIndex:
                      configProvider.appLanguageCode == "ar" ? 1 : 0,
                      totalSwitches: 2,
                      customWidgets: [
                        Image.asset(ImageAssets.lr, width: 30),
                        Image.asset(ImageAssets.eg, width: 30),
                      ],
                      activeBgColor: [
                        Theme.of(context).secondaryHeaderColor,
                      ],
                      inactiveBgColor: Theme.of(context).shadowColor,
                      radiusStyle: true,
                      borderWidth: 1,
                      borderColor: [Colors.transparent],
                      onToggle: (index) {
                        if (index == 0) {
                          configProvider.changeAppLanguage("en");
                        } else {
                          configProvider.changeAppLanguage("ar");
                        }
                        setState(() {});
                      },
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

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        UiUtils.showLoadingDialog(context);
        UserCredential userCredential = await FirebaseServices.login(
          emailController.text,
          passwordController.text,
        );
        UserModel.currentUser = await FirebaseServices.getUserFromFireStore(
          userCredential.user!.uid,
        );
        UiUtils.hideDialog(context);
        _navigate();
        UiUtils.showToast(
          AppLocalizations.of(context)!.login_success,
          Colors.green,
        );
      } on FirebaseAuthException catch (e) {
        UiUtils.hideDialog(context);
        UiUtils.showToast(
          AppLocalizations.of(context)!.incorrect_credentials,
          ColorsManager.red,
        );
      } catch (e) {
        UiUtils.hideDialog(context);
        UiUtils.showToast(
          AppLocalizations.of(context)!.failed_login,
          ColorsManager.red,
        );
      }
    }
  }

  _navigate() async {
    bool hasEnteredBefore = await PrefsManager.checkEntering();
    if (!hasEnteredBefore) {
      await PrefsManager.saveEntering();
      Navigator.pushReplacementNamed(context, RoutesManager.onBoarding);
    } else {
      Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
    }
  }
}
