import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/features/on_boarding/page_widget.dart';
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
                  "Personalize Your Experience",
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                SizedBox(height: 20.h),
                Text(
                  "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
                  style: Theme.of(context).textTheme.labelSmall,
                ),

                SizedBox(height: 20.h),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text("Language",
                //         style: Theme.of(context).textTheme.titleMedium),
                //     ToggleSwitch(
                //       initialLabelIndex:
                //       configProvider.appLanguageCode == "ar" ? 1 : 0,
                //       totalSwitches: 2,
                //       customWidgets: [
                //         Image.asset(ImageAssets.lr, width: 30),
                //         Image.asset(ImageAssets.eg, width: 30), ],
                //       activeBgColor: [Theme.of(context).secondaryHeaderColor],
                //       inactiveBgColor: Theme.of(context).shadowColor,
                //       onToggle: (index) {
                //         if (index == 0) {
                //           configProvider.changeAppLanguage("en");
                //         } else {
                //           configProvider.changeAppLanguage("ar");
                //         }
                //       },
                //     ),
                //   ],
                // ),
                SizedBox(height: 50.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Theme",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    ToggleSwitch(
                      initialLabelIndex: configProvider.isDarkEnable ? 1 : 0,
                      totalSwitches: 2,
                      labels: const ["Light", "Dark"],
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
              text1: "Find Events That Inspire You",
              text2:
                  "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
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
              text1: "Effortless Event Planning",
              text2:
                  "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
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
              text1: "Connect with Friends & Share Moments",
              text2:
                  "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
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
        "Finish",
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
