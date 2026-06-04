import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../model/transaction_model.dart';

class PaymentHistoryController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  
  final RxList<TransactionData> paymentHistory = <TransactionData>[].obs;
  final RxList<TransactionData> filteredHistory = <TransactionData>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPaymentHistory();
  }

  Future<void> fetchPaymentHistory({String searchTerm = ''}) async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get('/transactions/my', query: {
        if (searchTerm.isNotEmpty) 'searchTerm': searchTerm,
      });
      
      if (response.statusCode == 200 && response.data != null) {
        final model = TransactionModel.fromJson(response.data);
        if (model.data != null) {
          paymentHistory.assignAll(model.data!);
          filteredHistory.assignAll(model.data!);
        }
      }
    } catch (e) {
      debugPrint('Error fetching payment history: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void searchPayment(String query) {
    if (query.isEmpty) {
      filteredHistory.assignAll(paymentHistory);
    } else {
      // We can also call the API with searchTerm if the backend supports it better
      // For now, doing local filtering or you can call fetchPaymentHistory(searchTerm: query)
      filteredHistory.assignAll(
        paymentHistory.where((element) {
          final eventName = element.eventId?.name?.toLowerCase() ?? '';
          return eventName.contains(query.toLowerCase());
        }).toList(),
      );
    }
  }
}
