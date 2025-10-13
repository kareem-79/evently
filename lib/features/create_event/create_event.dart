import 'package:evently/core/extension/date_time_extension.dart';
import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/utils/ui_utils.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_tap_bar.dart';
import 'package:evently/core/widget/custom_text_button.dart';
import 'package:evently/core/widget/custom_text_form_filed.dart';
import 'package:evently/firebase/firebase_services.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/model/category_model.dart';
import 'package:evently/model/event_model.dart';
import 'package:evently/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime = TimeOfDay.now();
  late CategoryModel selectedCategory=CategoryModel.category(context)[0];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(AppLocalizations.of(context)!.create_event),
      ),
      body: Padding(
        padding: EdgeInsets.all(14.0.sp),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(16.r),
                  child: Image.asset(
                    selectedCategory.imagePath,
                    fit: BoxFit.fill,
                    width: 361.w,
                    height: 203.h,
                  ),
                ),
                SizedBox(height: 12.h),
                CustomTapBar(
                  onCategoryItemSelected: (category){
                    setState(() {
                      selectedCategory=category;
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
                  controller: titleController,
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
                  controller: descriptionController,
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
                      selectedDate.toFormatDate,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Spacer(),
                    CustomTextButton(
                      onPress: _selectedEventDay,
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
                      selectedDate.toFormatTime,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Spacer(),
                    CustomTextButton(
                      onPress: _selectEventTime,
                      text: AppLocalizations.of(context)!.choose_time,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  AppLocalizations.of(context)!.location,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: ColorsManager.blue),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.my_location_outlined,
                        color: ColorsManager.blue,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        AppLocalizations.of(context)!.choose_event_location,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                CustomElevatedButton(
                  onPress: _addEvent,
                  text: AppLocalizations.of(context)!.add_event,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addEvent() async {
    if (_formKey.currentState?.validate() == false) return;
    UiUtils.showLoadingDialog(context);
    EventModel event = EventModel(
      id: "",
      ownerId: UserModel.currentUser!.id,
      category: selectedCategory,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: selectedDate,
    );
    await FirebaseServices.addEventToFireStore(event, context);
    UiUtils.hideDialog(context);
    Navigator.pop(context);
    UiUtils.showToast(AppLocalizations.of(context)!.event_added, Colors.green);
  }

  void _selectEventTime() async {
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
        selectedTime;
    selectedDate = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );
    setState(() {});
  }

  void _selectedEventDay() async {
    selectedDate =
        await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        ) ??
        selectedDate;
    selectedDate = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );
    setState(() {});
  }
}
