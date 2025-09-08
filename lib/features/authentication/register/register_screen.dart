import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/core/utils/validation.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_text_button.dart';
import 'package:evently/core/widget/custom_text_form_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late bool secure = true;
  var formKey=GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController=TextEditingController();
    emailController=TextEditingController();
    passwordController=TextEditingController();
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
      appBar: AppBar(title: Text("Register")),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(ImageAssets.eventlyLogo, height: 186.h, width: 136.w),
                SizedBox(height: 24.h),
                CustomTextFormFiled(
                  controller: nameController,
                  label: "Name",
                  prefixIcon: Icons.person,
                  validator: (input) {
                    if(input==null||input.trim().isEmpty){
                      return "Name is Required";
                    }
                    if(input.length<5){
                      return "Sorry,Name should be at least 6 char";
                    }
                    return null;
                  },
                ),
                CustomTextFormFiled(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  label: "E-mail",
                  prefixIcon: Icons.email,
                  validator: (input) {
                    if(input==null||input.trim().isEmpty){
                      return "E-mail is Required";
                    }
                    if(!Validation.isValidateEmail(input)){
                      return "E-mail is not validate";
                    }
                    return null;
                  },
                ),
                CustomTextFormFiled(
                  controller: passwordController,
                  validator: (input) {
                    if(input==null||input.trim().isEmpty){
                      return "Password is Required";
                    }
                    if(input.length<8){
                      return "Sorry,Password should be at least 8 char";
                    }
                    return null;
                  },
                  secure: secure,
                  label: "Password",
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    onPressed: () {
                      secure = !secure;
                      setState(() {});
                    },
                    icon: Icon(secure ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
                CustomElevatedButton(
                  onPress: _createAccount,
                  text: "Create Account",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already Have Account ? ",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      CustomTextButton(
                        onPress: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.login,
                          );
                        },
                        text: "Login",
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

  void _createAccount() {
    if (formKey.currentState?.validate() ?? false) {
      print("Now create account...");
    }
  }

}
