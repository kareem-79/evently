import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/features/layout/profile/custom_drop_down.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/user_model.dart';
import 'package:evently/provider/config_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(44)),
          ),
          child: SafeArea(
            bottom: false,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ImageAssets.profileImg),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10.0.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          UserModel.currentUser!.name,
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColorsManager.white,
                          ),
                        ),
                        Text(
                          UserModel.currentUser!.email,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.white,
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
        SizedBox(height: 24.h),
        /// Theme DropDown
        CustomDropDown(
          label: AppLocalizations.of(context)!.theme,
          menuItems: [
            AppLocalizations.of(context)!.light,
            AppLocalizations.of(context)!.dark,
          ],
          selectedItems: configProvider.isDarkEnable
              ? AppLocalizations.of(context)!.dark
              : AppLocalizations.of(context)!.light,
          onChange: (newTheme) {
            configProvider.changeAppTheme(
              newTheme == AppLocalizations.of(context)!.light
                  ? ThemeMode.light
                  : ThemeMode.dark,
            );
          },
        ),
        SizedBox(height: 12.h),
        CustomDropDown(
          label: AppLocalizations.of(context)!.language,
          menuItems: [
            AppLocalizations.of(context)!.english,
            AppLocalizations.of(context)!.spanish,
            AppLocalizations.of(context)!.arabic,
            AppLocalizations.of(context)!.french,
            AppLocalizations.of(context)!.chinese,
            AppLocalizations.of(context)!.japanese,
            AppLocalizations.of(context)!.russian,
          ],
          selectedItems: _getSelectedLanguage(context, configProvider),
          onChange: (newLanguage) {
            configProvider.changeAppLanguage(_mapLanguageToCode(context, newLanguage!));
          },
        ),
        const Spacer(flex: 9),
        Padding(
          padding: EdgeInsets.all(10.0.sp),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.red,
              foregroundColor: ColorsManager.white,
            ),
            onPressed: _logout,
            child: Row(
              children: [
                const Icon(Icons.logout_outlined),
                SizedBox(width: 8.w),
                Text(AppLocalizations.of(context)!.logout),
              ],
            ),
          ),
        ),
        const Spacer(flex: 1),
      ],
    );
  }

  String _getSelectedLanguage(BuildContext context, ConfigProvider provider) {
    switch (provider.appLanguageCode) {
      case "en":
        return AppLocalizations.of(context)!.english;
      case "es":
        return AppLocalizations.of(context)!.spanish;
      case "ar":
        return AppLocalizations.of(context)!.arabic;
      case "fr":
        return AppLocalizations.of(context)!.french;
      case "zh":
        return AppLocalizations.of(context)!.chinese;
      case "ja":
        return AppLocalizations.of(context)!.japanese;
      case "ru":
        return AppLocalizations.of(context)!.russian;
      default:
        return AppLocalizations.of(context)!.english;
    }
  }

  String _mapLanguageToCode(BuildContext context, String lang) {
    if (lang == AppLocalizations.of(context)!.english) return "en";
    if (lang == AppLocalizations.of(context)!.spanish) return "es";
    if (lang == AppLocalizations.of(context)!.arabic) return "ar";
    if (lang == AppLocalizations.of(context)!.french) return "fr";
    if (lang == AppLocalizations.of(context)!.chinese) return "zh";
    if (lang == AppLocalizations.of(context)!.japanese) return "ja";
    if (lang == AppLocalizations.of(context)!.russian) return "ru";
    return "en";
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, RoutesManager.login);
  }
}
