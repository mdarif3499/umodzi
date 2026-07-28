import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../data/notification_model.dart';

class NotificationController extends GetxController {
  final ApiClient _apiClient = DioApiClient();

  var isLoading = false.obs;
  var isMoreLoading = false.obs;
  var notificationList = <NotificationItem>[].obs;
  var unreadCount = 0.obs;

  int _currentPage = 1;
  int _totalPages = 1;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  Future<void> getNotifications({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (_currentPage >= _totalPages) return;
      isMoreLoading.value = true;
      _currentPage++;
    } else {
      _currentPage = 1;
      isLoading.value = true;
    }

    try {
      final response = await _apiClient.get('/notifications?page=$_currentPage&limit=20');
      if (response.statusCode == 200) {
        final model = NotificationModel.fromJson(response.data);
        if (isLoadMore) {
          notificationList.addAll(model.data?.result ?? []);
        } else {
          notificationList.assignAll(model.data?.result ?? []);
        }
        unreadCount.value = model.data?.unreadCount ?? 0;
        _totalPages = model.meta?.totalPage ?? 1;
      }
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
    } finally {
      isLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  Future<void> markAsRead(String id) async {
    try {
      final response = await _apiClient.patch('/notifications/read/$id');
      if (response.statusCode == 200) {
        int index = notificationList.indexWhere((element) => element.id == id);
        if (index != -1 && notificationList[index].read == false) {
          notificationList[index].read = true;
          notificationList.refresh();
          if (unreadCount.value > 0) unreadCount.value--;
        }
      }
    } catch (e) {
      debugPrint("Error marking notification as read: $e");
    }
  }

  Future<void> markAllAsRead() async {
    try {
      final response = await _apiClient.patch('/notifications');
      if (response.statusCode == 200) {
        for (var item in notificationList) {
          item.read = true;
        }
        notificationList.refresh();
        unreadCount.value = 0;
      }
    } catch (e) {
      debugPrint("Error marking all notifications as read: $e");
    }
  }
}
