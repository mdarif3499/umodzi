import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../controller/payment_history_controller.dart';
import '../widget/history_payment_item.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentHistoryController());

    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Payment History',
        showBackButton: true,
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: TextField(
              onChanged: (value) => controller.searchPayment(value),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: AppColors.textSecondaryColor,
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondaryColor, size: 20.sp),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFF1F5F9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Color(0xFFF1F5F9)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.green),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => controller.fetchPaymentHistory(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: Obx(() {
                    if (controller.isLoading.value && controller.paymentHistory.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if (controller.filteredHistory.isEmpty) {
                      return const Center(child: CommonText(text: "No history found"));
                    }
                    
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.filteredHistory.length,
                      itemBuilder: (context, index) {
                        final history = controller.filteredHistory[index];
                        return HistoryPaymentItem(
                          history: history,
                          showDivider: index < controller.filteredHistory.length - 1,
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
