import 'package:evently/core/extension/date_time_extension.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_tap_bar.dart';
import 'package:evently/core/widget/custom_text_button.dart';
import 'package:evently/core/widget/custom_text_form_filed.dart';
import 'package:evently/features/layout/map/pick_location_button.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/category_model.dart';
import 'package:evently/provider/create_event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
@override
  void didChangeDependencies() {
  context.read<CreateEventProvider>().getSelectedCategory(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateEventProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text(AppLocalizations.of(context)!.create_event),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(14.0.sp),
            child: Form(
              key: provider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(16.r),
                    child: Image.asset(
                      provider.selectedCategory.imagePath,
                      fit: BoxFit.fill,
                      width: 361.w,
                      height: 203.h,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  CustomTapBar(
                    onCategoryItemSelected: (category) {
                      setState(() {
                        provider.selectedCategory = category;
                      });
                    },
                    categories: CategoryModel.category(context),
                    selectedBgColor: ColorsManager.blue,
                    selectedFgColor: ColorsManager.white,
                    unSelectedBgColor: Colors.transparent,
                    unSelectedFgColor: ColorsManager.blue,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormFiled(
                    label: AppLocalizations.of(context)!.event_title,
                    controller: provider.titleController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return AppLocalizations.of(context)!.title_required;
                      }
                      return null;
                    },
                    prefixIcon: Icons.edit_calendar_rounded,
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AppLocalizations.of(context)!.description,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormFiled(
                    label: AppLocalizations.of(context)!.event_description,
                    prefixIcon: Icons.description,
                    controller: provider.descriptionController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return AppLocalizations.of(context)!.email_required;
                      }
                      return null;
                    },
                    maxLine: 3,
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(Icons.date_range_outlined),
                      SizedBox(width: 4.h),
                      Text(
                        provider.selectedDate.toFormatDate,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Spacer(),
                      CustomTextButton(
                        onPress: (){
                          provider.selectedEventDay(context);
                        },
                        text: AppLocalizations.of(context)!.choose_date,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Icon(Icons.watch_later_outlined),
                      SizedBox(width: 4.h),
                      Text(
                        provider. selectedDate.toFormatTime,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Spacer(),
                      CustomTextButton(
                        onPress: (){
                          provider.selectEventTime(context);
                        },
                        text: AppLocalizations.of(context)!.choose_time,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    AppLocalizations.of(context)!.location,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 10.h),
                  PickLocationButton(provider: provider),
                  SizedBox(height: 10.h),
                  CustomElevatedButton(
                    onPress: (){
                      provider.addEvent(context);
                    },
                    text: AppLocalizations.of(context)!.add_event,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}
