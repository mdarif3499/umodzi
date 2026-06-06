import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../utils/app_snackbar.dart';
import '../../payment/screen/webview_screen.dart';
import '../data/profile_model.dart';
import '../data/payment_breakdown_model.dart';

class ProfileController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  
  RxBool isLoading = false.obs;
  RxBool isStatsLoading = false.obs;
  RxBool isNotificationLoading = false.obs;
  Rx<ProfileData?> profileData = Rx<ProfileData?>(null);
  Rx<PaymentBreakdownData?> paymentBreakdown = Rx<PaymentBreakdownData?>(null);

  RxBool isNotificationEnabled = true.obs;
  final deletePasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getProfileData();
    fetchPaymentBreakdown();
    fetchNotificationPreferences();
  }

  Future<void> getProfileData() async {
    try {
      isLoading.value = true;
      final response = await apiClient.get(ApiEndPoint.profile);

      if (response.statusCode == 200) {
        final profileModel = ProfileModel.fromJson(response.data);
        profileData.value = profileModel.data;
      } else {
        AppSnackbar.error(title: 'Error', message: response.message);
      }
    } catch (e) {
      AppSnackbar.error(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPaymentBreakdown() async {
    try {
      isStatsLoading.value = true;
      final response = await apiClient.get(ApiEndPoint.paymentBreakdown);

      if (response.statusCode == 200) {
        final model = PaymentBreakdownModel.fromJson(response.data);
        paymentBreakdown.value = model.data;
      }
    } catch (e) {
      debugPrint('Error fetching payment breakdown: $e');
    } finally {
      isStatsLoading.value = false;
    }
  }

  Future<void> checkoutPenalties() async {
    try {
      isLoading.value = true;
      final response = await apiClient.post(ApiEndPoint.checkoutPenalties, body: {});

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
      isLoading.value = false;
    }
  }

  Future<void> fetchNotificationPreferences() async {
    try {
      final response = await apiClient.get(ApiEndPoint.notificationPreferences);
      if (response.statusCode == 200 && response.data != null) {
        final data = response.data['data'];
        if (data != null && data['enabled'] != null) {
          isNotificationEnabled.value = data['enabled'];
        }
      }
    } catch (e) {
      debugPrint('Error fetching notification preferences: $e');
    }
  }

  Future<void> toggleNotification(bool value) async {
    // Optimistic update
    final previousValue = isNotificationEnabled.value;
    isNotificationEnabled.value = value;
    
    try {
      final response = await apiClient.patch(
        ApiEndPoint.notificationPreferences,
        body: {'enabled': value},
      );

      if (response.statusCode != 200) {
        // Revert if failed
        isNotificationEnabled.value = previousValue;
        AppSnackbar.error(title: 'Error', message: 'Failed to update notification settings');
      } else {
        AppSnackbar.success(
          title: 'Success', 
          message: 'Notification ${value ? 'enabled' : 'disabled'} successfully'
        );
      }
    } catch (e) {
      // Revert if exception
      isNotificationEnabled.value = previousValue;
      AppSnackbar.error(title: 'Error', message: 'Something went wrong');
    }
  }

  @override
  void onClose() {
    deletePasswordController.dispose();
    super.onClose();
  }
}
