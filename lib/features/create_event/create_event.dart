import 'package:evently/core/resources/assets_manager.dart';
import 'package:evently/core/resources/colors_manager.dart';
import 'package:evently/core/resources/routes_manager.dart';
import 'package:evently/core/widget/custom_elevated_button.dart';
import 'package:evently/core/widget/custom_tap_bar.dart';
import 'package:evently/core/widget/custom_text_button.dart';
import 'package:evently/core/widget/custom_text_form_filed.dart';
import 'package:evently/model/category_model.dart';
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
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

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
      appBar: AppBar(elevation: 0, title: Text("Create Event")),
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
                    ImageAssets.workshop,
                    fit: BoxFit.fill,
                    width: 361.w,
                    height: 203.h,
                  ),
                ),
                SizedBox(height: 12.h),
                CustomTapBar(
                  categories: CategoryModel.category,
                  selectedBgColor: ColorsManager.blue,
                  selectedFgColor: ColorsManager.white,
                  unSelectedBgColor: Colors.transparent,
                  unSelectedFgColor: ColorsManager.blue,
                ),
                SizedBox(height: 12.h),
                Text("Title", style: Theme.of(context).textTheme.labelSmall),
                SizedBox(height: 8.h),
                CustomTextFormFiled(
                  label: "Event title",
                  controller: titleController,
                  validator: (input) {
                    if(input==null||input.trim().isEmpty){
                      return "Title is required";
                    }
                    return null;
                  },
                  prefixIcon: Icons.edit_calendar_rounded,
                ),
                SizedBox(height: 12.h),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 8.h),
                CustomTextFormFiled(
                  label: "Event Description",
                  controller: descriptionController,
                  validator: (input) {
                    if(input==null||input.trim().isEmpty){
                      return "Description is required";
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
                      "Event Date",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Spacer(),
                    CustomTextButton(
                      onPress: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                      },
                      text: "Choose Date",
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined),
                    SizedBox(width: 4.h),
                    Text(
                      "Event Time",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Spacer(),
                    CustomTextButton(
                      onPress: () {
                        showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
                      },
                      text: "Choose Time",
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text("Location", style: Theme.of(context).textTheme.labelSmall),
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
                      Icon(Icons.my_location_outlined, color: ColorsManager.blue),
                      SizedBox(width: 8.w),
                      Text(
                        "Choose Event Location",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios_outlined),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                CustomElevatedButton(onPress: _addEvent, text: "Add Event")
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addEvent() {
    if(_formKey.currentState?.validate()==false)return;
  }
}

