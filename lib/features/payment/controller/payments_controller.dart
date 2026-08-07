import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/api_service.dart';
import '../model/transaction_model.dart';
import '../model/pending_payment_model.dart';
import '../model/payment_summary_model.dart';

class PaymentsController extends GetxController {
  final ApiClient _apiClient = DioApiClient();
  
  var pendingPayments = <PendingPaymentModel>[].obs;
  var paymentHistory = <TransactionData>[].obs;
  var isLoading = false.obs;
  var isSummaryLoading = false.obs;
  var paymentSummary = PaymentSummaryData().obs;

  @override
  void onInit() {
    super.onInit();
    fetchPaymentSummary();
    fetchPaymentHistory();
  }
  Future<void> fetchPaymentSummary() async {
    isSummaryLoading.value = true;
    try {
      final response = await _apiClient.get('/wallet/payment-summary');
      if (response.statusCode == 200) {
        final model = PaymentSummaryModel.fromJson(response.data);
        if (model.data != null) {
          paymentSummary.value = model.data!;
        }
      }
    } catch (e) {
      debugPrint('Error fetching payment summary: $e');
    } finally {
      isSummaryLoading.value = false;
    }
  }
  Future<void> fetchPaymentHistory() async {
    isLoading.value = true;
    try {
      final response = await _apiClient.get('/transactions/my');
      if (response.statusCode == 200) {
        final model = TransactionModel.fromJson(response.data);
        if (model.data != null) {
          paymentHistory.assignAll(model.data!);
        }
      }
    } catch (e) {
      debugPrint('Error fetching payment history: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
