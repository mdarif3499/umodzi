import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../model/single_event_model.dart';

class EventDetailsController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  
  var isLoading = false.obs;
  var eventData = Rxn<SingleEventData>();

  Future<void> fetchEventDetails(String eventId) async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get('/events/view-single-by/$eventId');
      if (response.statusCode == 200 && response.data != null) {
        final model = SingleEventModel.fromJson(response.data);
        eventData.value = model.data;
      }
    } catch (e) {
      debugPrint('Error fetching event details: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
