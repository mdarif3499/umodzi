import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../utils/app_snackbar.dart';
import '../../payment/screen/webview_screen.dart';
import '../model/single_event_model.dart';

class EventDetailsController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  
  var isLoading = false.obs;
  var isPaymentLoading = false.obs;
  var eventData = Rxn<SingleEventData>();
  Future<void> fetchEventDetails(String eventId) async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get('/events/view-single-by/$eventId');
      if (response.statusCode == 200) {
        final model = SingleEventModel.fromJson(response.data);
        eventData.value = model.data;
      }
    } catch (e) {
      debugPrint('Error fetching event details: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> createCheckoutSession(String eventId) async {
    try {
      isPaymentLoading.value = true;
      final response = await _apiClient.post(
        ApiEndPoint.checkoutContributions,
        body: {'eventId': eventId},
      );
      if (response.statusCode == 200) {
        final checkoutUrl = response.data['data']['url'];
        if (checkoutUrl != null) {
          Get.to(() => StripeWebViewPage(checkoutUrl: checkoutUrl));
        }
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isPaymentLoading.value = false;
    }
  }
}
