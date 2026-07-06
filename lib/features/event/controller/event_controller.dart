import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../model/completed_contribution_model.dart';
import '../model/pending_contribution_model.dart';

class EventController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  
  var pendingContributions = <PendingContribution>[].obs;
  var completedContributions = <CompletedContribution>[].obs;
  var isLoading = false.obs;
  var isPendingLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchPendingContributions();
    fetchCompletedContributions();
  }
  Future<void> fetchPendingContributions() async {
    isPendingLoading.value = true;
    try {
      final response = await _apiClient.get('/contributions/pending');
      if (response.statusCode == 200) {
        final model = PendingContributionModel.fromJson(response.data);
        if (model.data != null) {
          pendingContributions.assignAll(model.data!);
        }
      }
    } catch (e) {
      debugPrint('Error fetching pending contributions: $e');
    } finally {
      isPendingLoading.value = false;
    }
  }
  Future<void> fetchCompletedContributions() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get('/contributions/completed');
      if (response.statusCode == 200) {
        final model = CompletedContributionModel.fromJson(response.data);
        if (model.data != null) {
          completedContributions.assignAll(model.data!);
        }
      }
    } catch (e) {
      debugPrint('Error fetching completed contributions: $e');
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> refreshAll() async {
    await Future.wait([
      fetchPendingContributions(),
      fetchCompletedContributions(),
    ]);
  }
}
