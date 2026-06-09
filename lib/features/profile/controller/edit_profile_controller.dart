import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:umodzi/config/route/app_routes.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../services/api/multipart_helper.dart';
import '../../../utils/app_snackbar.dart';
import 'profile_controller.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  final ApiClient apiClient = DioApiClient();
  final ImagePicker _picker = ImagePicker();
  
  RxString imagePath = ''.obs;
  RxBool isLoading = false.obs;
  
  RxString selectedCountryCode = '+880'.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() {
    final profileController = Get.find<ProfileController>();
    final data = profileController.profileData.value;
    
    if (data != null) {
      nameController.text = data.name ?? '';
      emailController.text = data.email ?? '';
      phoneController.text = data.phone ?? '';
      locationController.text = data.address ?? '';
      selectedCountryCode.value = data.countryCode ?? '+880';
    }
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
    }
  }

  Future<void> updateProfile() async {
    try {
      isLoading.value = true;
      final profileController = Get.find<ProfileController>();

      // বেসিক ডাটা ম্যাপ
      Map<String, dynamic> dataMap = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'countryCode': selectedCountryCode.value,
        'phone': phoneController.text.trim(),
        'address': locationController.text.trim(),
      };

      List<MultipartFileItem> files = [];
      
      // ইমেজ লজিক:
      if (imagePath.value.isNotEmpty) {
        // ১. যদি নতুন ইমেজ সিলেক্ট করা হয়
        files.add(MultipartFileItem(
          filePath: imagePath.value,
          fileName: 'image',
        ));
      } else {
        // ২. যদি নতুন ইমেজ না থাকে, কিন্তু আগে থেকে ইমেজ থাকে
        final existingImage = profileController.profileData.value?.image;
        if (existingImage != null && existingImage.isNotEmpty) {
          dataMap['image'] = existingImage;
        }
        // ৩. যদি কোনো ইমেজই না থাকে, তবে 'image' কী-টি পাঠানো হবে না (dataMap-এ অটোমেটিক বাদ থাকবে)
      }

      final response = await apiClient.multipart(
        url: ApiEndPoint.profile,
        method: 'PATCH',
        files: files,
        body: {'data': jsonEncode(dataMap)},
      );

      if (response.isSuccess) {
        AppSnackbar.success(title: 'Success', message: 'Profile updated successfully');
        await profileController.getProfileData();
        Get.toNamed(AppRoutes.navBarScreen);
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    super.onClose();
  }
}
