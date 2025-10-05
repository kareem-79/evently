import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/features/on_boarding/page_widget.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/provider/config_provider.dart';
import 'package:evently/features/on_boarding/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../layout/main_layout.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => MainLayout()));
  }

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);

    return IntroductionScreen(
      key: introKey,
      autoScrollDuration: 20000,
      allowImplicitScrolling: false,
      globalBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      pages: [
        PageViewModel(
          titleWidget: const TitleWidget(),
          bodyWidget: Padding(
            padding: EdgeInsets.all(12.0.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.h),
                Image.asset(ImageAssets.onBoarding1),
                SizedBox(height: 20.h),

                Text(
                  AppLocalizations.of(context)!.personalize_title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                SizedBox(height: 20.h),
                Text(
                  AppLocalizations.of(context)!.personalize_description,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppLocalizations.of(context)!.language,
                        style: Theme.of(context).textTheme.titleMedium),
                    ToggleSwitch(
                      curve:Curves.easeOutQuart ,
                      animate: true,
                      initialLabelIndex:
                      configProvider.appLanguageCode == "ar" ? 1 : 0,
                      totalSwitches: 2,
                      customWidgets: [
                        Image.asset(ImageAssets.lr, width: 30),
                        Image.asset(ImageAssets.eg, width: 30), ],
                      activeBgColor: [Theme.of(context).secondaryHeaderColor],
                      inactiveBgColor: Theme.of(context).shadowColor,
                      onToggle: (index) {
                        if (index == 0) {
                          configProvider.changeAppLanguage("en");
                        } else {
                          configProvider.changeAppLanguage("ar");
                        }
                        setState(() {

                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ToggleSwitch(
                      curve:Curves.easeOutQuart ,
                      animate: true,
                      initialLabelIndex: configProvider.isDarkEnable ? 1 : 0,
                      totalSwitches: 2,
                      labels:  [AppLocalizations.of(context)!.light, AppLocalizations.of(context)!.dark],
                      activeBgColor: [Theme.of(context).secondaryHeaderColor],
                      inactiveBgColor: Theme.of(context).shadowColor,
                      inactiveFgColor: Theme.of(context).focusColor,
                      onToggle: (index) {
                        if (index == 0) {
                          configProvider.changeAppTheme(ThemeMode.light);
                        } else {
                          configProvider.changeAppTheme(ThemeMode.dark);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          decoration: PageDecoration(
            pageColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        PageViewModel(
          titleWidget: const TitleWidget(),
          bodyWidget: Padding(
            padding: EdgeInsets.all(12.0.sp),
            child: PageWidget(
              text1: AppLocalizations.of(context)!.find_events_title,
              text2:
              AppLocalizations.of(context)!.find_events_description,
              image: ImageAssets.onBoarding2,
            ),
          ),
          decoration: PageDecoration(
            pageColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        PageViewModel(
          titleWidget: const TitleWidget(),
          bodyWidget: Padding(
            padding: EdgeInsets.all(12.0.sp),
            child: PageWidget(
              text1: AppLocalizations.of(context)!.event_planning_title,
              text2:
              AppLocalizations.of(context)!.event_planning_description,
              image: ImageAssets.onBoarding3,
            ),
          ),
          decoration: PageDecoration(
            pageColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        PageViewModel(
          titleWidget: const TitleWidget(),
          bodyWidget: Padding(
            padding: EdgeInsets.all(12.0.sp),
            child: PageWidget(
              text1: AppLocalizations.of(context)!.connect_friends_title,
              text2:
              AppLocalizations.of(context)!.connect_friends_description,
              image: ImageAssets.onBoarding4,
            ),
          ),
          decoration: PageDecoration(
            pageColor: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      showBackButton: true,
      showNextButton: true,
      back: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).focusColor),
      next: Icon(
        Icons.arrow_forward_ios_outlined,
        color: Theme.of(context).focusColor,
      ),
      done: Text(
        AppLocalizations.of(context)!.finish,
        style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
      ),
      dotsDecorator: DotsDecorator(
        size: const Size(10.0, 10.0),
        activeColor: Theme.of(context).secondaryHeaderColor,
        activeSize: const Size(10.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
