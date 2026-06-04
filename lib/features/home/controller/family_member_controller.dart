import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../../../config/api/api_end_point.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
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
}
