import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/component/text_field/common_text_field.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../controller/report_event_controller.dart';

class ReportEventScreen extends StatelessWidget {
  const ReportEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportEventController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: 'Report an Urgent Event',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: CommonText(
                text: 'Fill in the details below and upload supporting documents.',
                fontSize: 14.sp,
                color: AppColors.color6A7282,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24.h),
            CommonTextField(
              title: 'Event Title',
              hintText: 'Enter event title',
              controller: controller.titleController,
            ),
            SizedBox(height: 16.h),
            const Align(
              alignment: Alignment.centerLeft,
              child: CommonText(text: 'Event Type', fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.h),
            Obx(() => Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedEventTypeId.value.isEmpty ? null : controller.selectedEventTypeId.value,
                  hint: controller.isFetchingTypes.value 
                      ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const CommonText(text: "Select Event Type", fontSize: 14, color: AppColors.textFiledColor),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: controller.fetchedEventTypes.map((dynamic type) {
                    return DropdownMenuItem<String>(
                      value: type['_id'].toString(),
                      child: CommonText(text: type['name'].toString()),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      controller.selectedEventTypeId.value = val;
                      final selected = controller.fetchedEventTypes.firstWhere((t) => t['_id'] == val);
                      controller.selectedEventTypeName.value = selected['name'];
                    }
                  },
                ),
              ),
            )),
            SizedBox(height: 16.h),
            CommonTextField(
              title: 'Event Description',
              hintText: 'Please enter event details',
              maxLines: 4,
              controller: controller.descriptionController,
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => controller.pickDate(context),
              child: AbsorbPointer(
                child: CommonTextField(
                  title: 'Event Date',
                  hintText: 'Select the deadline of the event e.g., mm/dd/yyyy',
                  controller: controller.dateController,
                  suffixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            const Align(
              alignment: Alignment.centerLeft,
              child: CommonText(text: 'Documents and Photos', fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.h),

            // --- Document Upload Section ---
            DottedBorder(
              color: Colors.grey.shade300,
              strokeWidth: 1,
              dashPattern: const [6, 3],
              borderType: BorderType.RRect,
              radius: Radius.circular(12.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.folder_open_outlined, color: Colors.grey, size: 30),
                    SizedBox(height: 12.h),
                    Obx(() => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: CommonText(
                        text: controller.selectedFileName.value.isEmpty
                            ? "Upload documents or photos"
                            : controller.selectedFileName.value,
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        textAlign: TextAlign.center,
                      ),
                    )),
                    GestureDetector(
                      onTap: () => controller.showFilePickerOptions(),
                      child: Container(
                        margin: EdgeInsets.only(top: 12.h),
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: const CommonText(
                            text: "Choose File",
                            fontSize: 13,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 32.h),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    titleText: 'Cancel',
                    buttonColor: Colors.white,
                    titleColor: Colors.black,
                    borderColor: Colors.grey.shade300,
                    onTap: () => Get.back(),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Obx(() => CommonButton(
                    titleText: 'Submit',
                    buttonColor: Colors.black,
                    isLoading: controller.isLoading.value,
                    onTap: () => controller.submitReport(),
                  )),
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
