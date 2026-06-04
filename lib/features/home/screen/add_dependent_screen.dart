import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/common_appbar/common_appbar.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/component/text_field/common_text_field.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/app_images.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../component/text_field/common_phone_number_text_filed.dart';
import '../controller/add_dependent_controller.dart';



class AddDependentScreen extends StatelessWidget {
  AddDependentScreen({super.key});

  final controller = Get.put(AddDependentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CommonAppBar(
        title: controller.isEditing.value ? "Edit Dependent" : "Add Dependent",
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
        
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.sp),
                decoration: BoxDecoration(
                  color:  const Color(0xFFEEEEEB),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.r),
                      child: Image.asset(
                        AppImages.family,
                        height: 106.h,
                        width: 153.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CommonText(
                      text: controller.isEditing.value ? "Update Member Info" : "Expand Your Circle",
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    const CommonText(
                      text: "Register your family members to ensure they are covered by the community sanctuary.",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      color: AppColors.textSecondaryColor,
                    ),
                  ],
                ),
              ),
        
              SizedBox(height: 26.h),
        
              CommonTextField(
                title: "Full Name",
                hintText: "e.g, Tendal Mbeki",
                controller: controller.nameController,
              ),
              SizedBox(height: 12.h),
        
              const CommonText(text: "Phone Number", fontWeight: FontWeight.w500),
              SizedBox(height: 8.h),
              CommonPhoneNumberTextFiled(
                controller: controller.phoneController,
                countryChange: controller.onCountryChange,
                initialCountryCode: controller.initialISOCode,
              ),
              SizedBox(height: 12.h),

              CommonTextField(
                title: "Address",
                hintText: "Enter address",
                controller: controller.addressController,
              ),
              SizedBox(height: 16.h),
        
              const CommonText(text: "Relationship to Member", fontWeight: FontWeight.w500),
              SizedBox(height: 12.h),
              Obx(() => Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                      color: AppColors.white,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: controller.selectedRelationship.value.isEmpty
                            ? null
                            : controller.selectedRelationship.value,
                        hint: const CommonText(
                            text: "Select Connection",
                            fontSize: 14,
                            color: AppColors.textFiledColor),
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
        
              SizedBox(height: 24.h),

              const CommonText(text: "Profile Image", fontWeight: FontWeight.w500),
              SizedBox(height: 8.h),
              DottedBorder(
                color: Colors.grey.shade300,
                strokeWidth: 1,
                dashPattern: const [6, 3],
                borderType: BorderType.RRect,
                radius: Radius.circular(12.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.image_outlined, color: Colors.grey),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Obx(() => CommonText(
                          text: controller.selectedImageName.value.isEmpty
                              ? "Upload Profile Photo"
                              : controller.selectedImageName.value,
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        )),
                      ),
                      TextButton(
                        onPressed: () => controller.pickImage(),
                        child: const CommonText(text: "Choose", color: AppColors.green, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              const CommonText(text: "KYC / Document", fontWeight: FontWeight.w500),
              SizedBox(height: 8.h),
              DottedBorder(
                color: Colors.grey.shade300,
                strokeWidth: 1,
                dashPattern: const [6, 3],
                borderType: BorderType.RRect,
                radius: Radius.circular(12.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F6).withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.description_outlined, color: Colors.grey),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Obx(() => CommonText(
                          text: controller.selectedDocName.value.isEmpty
                              ? "Upload ID or Document"
                              : controller.selectedDocName.value,
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        )),
                      ),
                      TextButton(
                        onPressed: () => controller.pickDocument(),
                        child: const CommonText(text: "Choose", color: AppColors.green, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
              ),
        
              SizedBox(height: 40.h),
        
              Obx(() => CommonButton(
                titleText: controller.isEditing.value ? "Update Dependent" : "Add Dependent",
                isLoading: controller.isLoading.value,
                onTap: () => controller.submitMember(),
              )),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
