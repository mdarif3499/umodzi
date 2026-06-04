import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/component/text_field/common_text_field.dart';
import '../controller/edit_dependent_controller.dart';

class EditDependentScreen extends StatelessWidget {
  const EditDependentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditDependentController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0x1AA53200),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Color(0xFFA53200), size: 18),
            ),
          ),
        ),
        title: CommonText(
          text: 'Edit Dependent Information',
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            
            CommonTextField(
              title: 'Full Name',
              controller: controller.nameController,
            ),
            SizedBox(height: 16.h),
            
            CommonTextField(
              title: 'Phone Number',
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16.h),
            
            const CommonText(text: 'Relationship to Member', fontWeight: FontWeight.w500),
            SizedBox(height: 8.h),
            Obx(() => Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.3),
                ),                color: Colors.white,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: controller.selectedRelationship.value,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: controller.relationships.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: CommonText(text: value),
                    );
                  }).toList(),
                  onChanged: (val) => controller.selectedRelationship.value = val!,
                ),
              ),
            )),
            
            SizedBox(height: 16.h),
            CommonTextField(
              title: 'Date of Birth',
              controller: controller.dobController,
              readOnly: true,
              onTap: () => controller.selectDate(context),
              suffixIcon: GestureDetector(
                onTap: () => controller.selectDate(context),
                child: const Icon(Icons.calendar_month_outlined, color: Colors.grey),
              ),
            ),
            
            SizedBox(height: 20.h),
            const CommonText(text: "Uploaded Files", fontWeight: FontWeight.w500),
            SizedBox(height: 12.h),

            // Uploaded Files List
            Obx(() => Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: List.generate(controller.uploadedFiles.length, (index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.picture_as_pdf, color: Colors.red, size: 20),
                      SizedBox(width: 8.w),
                      CommonText(text: controller.uploadedFiles[index], fontSize: 12),
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: () => controller.removeFile(index),
                        child: const Icon(Icons.close, size: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }),
            )),
            
            SizedBox(height: 20.h),
            
            // Dotted Border Upload Section - এখন পুরো বক্সটি ক্লিকেবল
            GestureDetector(
              onTap: () => controller.pickFile(),
              child: DottedBorder(
                color: Colors.grey.shade300,
                strokeWidth: 1,
                dashPattern: const [6, 3],
                borderType: BorderType.RRect,
                radius: Radius.circular(12.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.sp),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(Icons.cloud_upload_outlined,
                            color: Colors.grey),
                      ),
                      SizedBox(height: 12.h),
                      const CommonText(
                          text: "Upload ID / Document",
                          fontWeight: FontWeight.w600),
                      SizedBox(height: 4.h),
                      CommonText(
                        text:
                            "Verify their identity for full coverage benefits (PDF, JPG or PNG)",
                        fontSize: 11,
                        textAlign: TextAlign.center,
                        color: Colors.grey.shade500,
                      ),
                      SizedBox(height: 16.h),
        
                      // Choose File Button Style
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Obx(() => CommonText(
                          text: controller.selectedFileName.value.isEmpty
                              ? "Choose File"
                              : controller.selectedFileName.value,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 32.h),
            CommonButton(
              titleText: 'Save all Changes',
              buttonColor: Colors.black,
              onTap: () => Get.back(),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
