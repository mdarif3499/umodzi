import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';

class AboutUsController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  RxString aboutUsContent = "".obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getAboutUs();
  }

  Future<void> getAboutUs() async {
    try {
      isLoading.value = true;
      final response = await apiClient.get(
        ApiEndPoint.settings,
        query: {"key": "aboutUs"},
      );

      if (response.isSuccess) {
        aboutUsContent.value = response.data['data'] ?? "";
      }
    } catch (e) {
      debugPrint("Error fetching About Us: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
