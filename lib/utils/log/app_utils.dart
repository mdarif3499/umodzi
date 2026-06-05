import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';

class Utils {
  static successSnackBar( String message) {
    Get.snackbar(
      "Success",
      message,
      colorText: AppColors.white,
      backgroundColor: AppColors.black,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static errorSnackBar(dynamic title, String message) {
    Get.snackbar(
      kDebugMode ? title.toString() : "Oops",
      message,
      colorText: AppColors.white,
      backgroundColor: AppColors.red,
      snackPosition: SnackPosition.TOP,
    );
  }
}
