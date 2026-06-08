import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';

class DynamicContentController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  RxString content = "".obs;
  RxBool isLoading = false.obs;

  Future<void> getContent(String key) async {
    try {
      isLoading.value = true;
      content.value = ""; // Clear old content
      final response = await apiClient.get(
        ApiEndPoint.settings,
        query: {"key": key},
      );

      if (response.isSuccess && response.data != null) {
        // Based on the image, the content is likely in response.data['data']
        content.value = response.data['data'] ?? "";
      }
    } catch (e) {
      debugPrint("Error fetching $key content: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
