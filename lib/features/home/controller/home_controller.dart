import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/socket/socket_service.dart';
import '../../../services/storage/storage_services.dart';
import '../../../services/storage/storage_keys.dart';
import '../../../config/route/app_routes.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../model/quick_action_model.dart';
import '../model/active_event_model.dart';
import '../model/recent_transaction_model.dart';
import '../model/wallet_summary_model.dart';

class HomeController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  
  var unreadMessageCount = 0.obs;
  var isLoading = false.obs;
  var isEventsLoading = false.obs;
  var isTransactionsLoading = false.obs;
  var isWalletLoading = false.obs;
  var isMoreLoading = false.obs;
  
  var quickActionData = QuickActionData().obs;
  var walletSummary = WalletSummaryData().obs;
  
  var activeEvents = <ActiveEvent>[].obs;
  var recentTransactions = <RecentTransaction>[].obs;
  
  var allActiveEvents = <ActiveEvent>[].obs;
  var currentPage = 1;
  var totalPages = 1;

  @override
  void onInit() {
    super.onInit();
    _fetchInitialCounts();
    _fetchQuickActions();
    fetchActiveEvents();
    fetchRecentTransactions();
    fetchWalletSummary();
    _fetchAdminId(); 
    _listenToSocketUpdates();
  }

  Future<void> _fetchAdminId() async {
    if (LocalStorage.adminId.isNotEmpty) return;
    try {
      final response = await _apiClient.get('/users/admin/');
      if (response.statusCode == 200) {
        String id = response.data['data']['_id'];
        await LocalStorage.setString(LocalStorageKeys.adminId, id);
      }
    } catch (e) {
      debugPrint('Error fetching admin id: $e');
    }
  }

  Future<void> createChatAndNavigate() async {
    isLoading.value = true;
    try {
      if (LocalStorage.adminId.isEmpty) await _fetchAdminId();
      if (LocalStorage.adminId.isEmpty) return;

      final chatListResponse = await _apiClient.get('/chats/');
      String? existingChatId;

      if (chatListResponse.statusCode == 200) {
        List chats = chatListResponse.data['data']['chats'] ?? [];
        for (var chat in chats) {
          List participants = chat['participants'] ?? [];
          bool hasAdmin = participants.any((p) => p['_id'] == LocalStorage.adminId);
          if (hasAdmin) {
            existingChatId = chat['_id'];
            break;
          }
        }
      }

      if (existingChatId != null) {
        Get.toNamed(AppRoutes.chatScreen, arguments: {'chatId': existingChatId})?.then((_) {
          _fetchInitialCounts();
        });
      } else {
        final createResponse = await _apiClient.post('/chats/create', body: {
          "participant": LocalStorage.adminId,
        });
        if (createResponse.statusCode == 200 || createResponse.statusCode == 201) {
          String newChatId = createResponse.data['data']['_id'];
          Get.toNamed(AppRoutes.chatScreen, arguments: {'chatId': newChatId});
        }
      }
    } catch (e) {
      debugPrint('Error in chat navigation: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchInitialCounts() async {
     try {
      final response = await _apiClient.get('/chats/');
      if (response.statusCode == 200) {
        unreadMessageCount.value = response.data['data']['totalUnreadMessages'] ?? 0;
        debugPrint("HOME_LOG: Updated unread count to: ${unreadMessageCount.value}");
      }
    } catch (e) {
      debugPrint('Error fetching initial counts: $e');
    }
  }

  Future<void> _fetchQuickActions() async {
    try {
      final response = await _apiClient.get('/quick-actions/');
      if (response.statusCode == 200) {
        final quickActionModel = QuickActionModel.fromJson(response.data);
        if (quickActionModel.data != null) {
          quickActionData.value = quickActionModel.data!;
        }
      }
    } catch (e) {
      debugPrint('Error fetching quick actions: $e');
    }
  }

  // Fetch only first few for Home
  Future<void> fetchActiveEvents() async {
    isEventsLoading.value = true;
    try {
      final response = await _apiClient.get('/events/public?limit=5');
      if (response.statusCode == 200) {
        final model = ActiveEventModel.fromJson(response.data);
        if (model.data != null) {
          activeEvents.assignAll(model.data!);
        }
      }
    } catch (e) {
      debugPrint('Error fetching active events: $e');
    } finally {
      isEventsLoading.value = false;
    }
  }

  Future<void> fetchRecentTransactions() async {
    isTransactionsLoading.value = true;
    try {
      final response = await _apiClient.get('/transactions/recent-transactions');
      if (response.statusCode == 200) {
        final model = RecentTransactionModel.fromJson(response.data);
        if (model.data != null) {
          recentTransactions.assignAll(model.data!);
        }
      }
    } catch (e) {
      debugPrint('Error fetching recent transactions: $e');
    } finally {
      isTransactionsLoading.value = false;
    }
  }

  Future<void> fetchWalletSummary() async {
    isWalletLoading.value = true;
    try {
      final response = await _apiClient.get('/wallet/summary');
      if (response.statusCode == 200) {
        final model = WalletSummaryModel.fromJson(response.data);
        if (model.data != null) {
          walletSummary.value = model.data!;
        }
      }
    } catch (e) {
      debugPrint('Error fetching wallet summary: $e');
    } finally {
      isWalletLoading.value = false;
    }
  }

  // Paginated fetch for "View All" screen
  Future<void> fetchAllActiveEvents({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      currentPage = 1;
      isEventsLoading.value = true;
      allActiveEvents.clear();
    } else {
      if (currentPage >= totalPages) return;
      isMoreLoading.value = true;
      currentPage++;
    }

    try {
      final response = await _apiClient.get('/events/public?page=$currentPage&limit=10');
      if (response.statusCode == 200) {
        final model = ActiveEventModel.fromJson(response.data);
        if (model.data != null) {
          allActiveEvents.addAll(model.data!);
          totalPages = model.meta?.totalPage ?? 1;
        }
      }
    } catch (e) {
      debugPrint('Error fetching all active events: $e');
    } finally {
      isEventsLoading.value = false;
      isMoreLoading.value = false;
    }
  }

  void _listenToSocketUpdates() {
    final userId = LocalStorage.userId.trim();
    
    if (userId.isEmpty) {
      Future.delayed(const Duration(seconds: 1), _listenToSocketUpdates);
      return;
    }

    debugPrint("HOME_LOG: Socket Listening started for UserId: $userId");

    SocketService.on('chatListUpdate::$userId', (data) {
      debugPrint("HOME_SOCKET: Received chatListUpdate event");
      if (data != null && data['totalUnreadMessages'] != null) {
        unreadMessageCount.value = data['totalUnreadMessages'];
      } else {
        _fetchInitialCounts(); 
      }
    });

    SocketService.on('newMessage::$userId', (data) {
      debugPrint("HOME_SOCKET: New message received! Updating count...");
      unreadMessageCount.value++;
      _fetchInitialCounts();
    });

    SocketService.on('user-notification::$userId', (data) {
      debugPrint("HOME_SOCKET: User notification received");
      _fetchInitialCounts();
    });
  }
}
