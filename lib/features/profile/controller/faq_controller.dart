import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../data/faq_model.dart';

class FaqController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  
  var isLoading = false.obs;
  var faqList = <FaqData>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaqs();
  }

  Future<void> fetchFaqs() async {
    try {
      isLoading.value = true;
      final response = await _apiClient.get(ApiEndPoint.faqsPublic);
      if (response.statusCode == 200) {
        final model = FaqModel.fromJson(response.data);
        if (model.data != null) {
          faqList.assignAll(model.data!);
        }
      }
    } catch (e) {
      debugPrint('Error fetching FAQs: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
