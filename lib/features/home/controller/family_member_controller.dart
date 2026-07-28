import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../../../utils/constants/app_colors.dart';
import '../model/family_member_model.dart';

class FamilyMemberController extends GetxController {
  final ApiClient apiClient = DioApiClient();
  final RxList<FamilyMemberModel> familyMembers = <FamilyMemberModel>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getDependents();
  }

  Future<void> getDependents() async {
    try {
      isLoading.value = true;
      final response = await apiClient.get(ApiEndPoint.dependents);
      
      if (response.isSuccess) {
        final List<dynamic> data = response.data['data'] ?? [];
        familyMembers.assignAll(data.map((e) => FamilyMemberModel.fromJson(e)).toList());
      }
    } catch (e) {
      debugPrint("Error fetching dependents: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteDependent(String id) async {
    try {
      isLoading.value = true;
      final response = await apiClient.delete(ApiEndPoint.removeDependent(id));
      if (response.isSuccess) {
        Get.back();
        getDependents();
        Get.snackbar("Success", "Family member removed successfully",
            backgroundColor: AppColors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", response.message,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      debugPrint("Error deleting dependent: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
