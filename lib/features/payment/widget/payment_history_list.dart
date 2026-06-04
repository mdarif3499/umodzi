import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controller/payments_controller.dart';
import 'history_payment_item.dart';

class PaymentHistoryList extends StatelessWidget {
  const PaymentHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PaymentsController>();
    return Obx(() => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: const Color(0xFFF1F5F9)),

          ),
          child:

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.paymentHistory.length,
            itemBuilder: (context, index) {
              final history = controller.paymentHistory[index];
              return HistoryPaymentItem(
                history: history,
                showDivider: index < controller.paymentHistory.length - 1,
              );
            },
          ),


        ));
  }
}
