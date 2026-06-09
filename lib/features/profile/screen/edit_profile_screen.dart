import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/component/text_field/common_text_field.dart';
import 'package:umodzi/config/api/api_end_point.dart';
import '../../../component/text_field/common_phone_number_text_filed.dart';
import '../controller/edit_profile_controller.dart';
import '../controller/profile_controller.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProfileController());
    final profileController = Get.find<ProfileController>();

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
                color: const Color(0xFFA53200).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.arrow_back_ios_new,
                  color: Color(0xFFA53200), size: 18),
            ),
          ),
        ),
        title: CommonText(
          text: 'Edit Profile Information',
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
            
            Center(
              child: Obx(() {
                final networkImage = profileController.profileData.value?.image;
                final localImage = controller.imagePath.value;
                
                Widget imageWidget;
                
                if (localImage.isNotEmpty) {
                  imageWidget = Image.file(
                    File(localImage),
                    width: 100.r,
                    height: 100.r,
                    fit: BoxFit.cover,
                  );
                } else if (networkImage != null && networkImage.isNotEmpty) {
                  final imageUrl = networkImage.startsWith('http')
                      ? networkImage 
                      : "${ApiEndPoint.imageUrl}${networkImage.startsWith('/') ? '' : '/'}$networkImage";
                  
                  imageWidget = CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 100.r,
                    height: 100.r,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      width: 100.r,
                      height: 100.r,
                      color: Colors.grey[100],
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 100.r,
                      height: 100.r,
                      color: Colors.grey[100],
                      child: Icon(Icons.person, size: 50.r, color: Colors.grey[400]),
                    ),
                  );
                } else {
                  imageWidget = Container(
                    width: 100.r,
                    height: 100.r,
                    color: Colors.grey[100],
                    child: Icon(Icons.person, size: 50.r, color: Colors.grey[400]),
                  );
                }

                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFA53200), width: 2),
                      ),
                      child: ClipOval(
                        child: imageWidget,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => controller.pickImage(),
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: const BoxDecoration(
                            color: Color(0xFFA53200),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.edit_outlined, color: Colors.white, size: 16.sp),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
            
            SizedBox(height: 32.h),
            
            CommonTextField(
              title: 'Name',
              controller: controller.nameController,
            ),
            SizedBox(height: 16.h),
            
            CommonTextField(
              title: 'Email',
              readOnly: true,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.h),
            
            CommonText(text: "Phone Number", fontSize: 16.sp, fontWeight: FontWeight.w500),
            SizedBox(height: 8.h),
            CommonPhoneNumberTextFiled(
              controller: controller.phoneController,
              countryChange: (country) {
                controller.selectedCountryCode.value = "+${country.dialCode}";
              },
            ),
            SizedBox(height: 16.h),
            
            CommonTextField(
              title: 'Location',
              controller: controller.locationController,
            ),
            
            SizedBox(height: 40.h),
            
            Obx(() => CommonButton(
              titleText: 'Save all Changes',
              buttonColor: Colors.black,
              isLoading: controller.isLoading.value,
              onTap: () => controller.updateProfile(),
            )),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
