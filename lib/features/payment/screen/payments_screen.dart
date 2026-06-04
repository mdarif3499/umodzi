import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/config/route/app_routes.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/app_icons.dart';

import '../../home/controller/home_controller.dart';
import '../../home/widget/custom_home_appbar.dart';
import '../controller/payments_controller.dart';
import '../model/pending_payment_model.dart';
import '../widget/history_payment_item.dart';
import '../widget/pending_payment_card.dart';
import '../widget/section_header.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentsController());
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: const CustomHomeAppBar(
        hasNotification: true,
        isEventPage: true,
        title: 'Payments',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() {
              final notice = controller.paymentSummary.value.penaltyNotice;
              if (notice != null && notice.isNotEmpty) {
                return Column(
                  children: [
                    _buildSubHeader(notice),
                    SizedBox(height: 20.h),
                  ],
                );
              }
              return SizedBox(height: 16.h);
            }),
            Obx(() => _buildTotalPaidCard(controller.paymentSummary.value.totalPaid ?? 0.0)),
            SizedBox(height: 12.h),
            Obx(() => _buildStatGrid(
                controller.paymentSummary.value.pendingAmount ?? 0.0,
                controller.paymentSummary.value.penaltyAmount ?? 0.0)),
            SizedBox(height: 16.h),
            Obx(() {
              final summary = controller.paymentSummary.value;
              if (summary.penaltyNotice != null && summary.penaltyNotice!.isNotEmpty) {
                return Column(
                  children: [
                    _buildPenaltyNotice(summary.penaltyNotice!),
                    SizedBox(height: 12.h),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
            Obx(() => SectionHeader(
                  title: 'Pending Payments',
                  count: '${homeController.activeEvents.length} payments',
                )),
            SizedBox(height: 12.h),
            Obx(() {
              if (homeController.isEventsLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (homeController.activeEvents.isEmpty) {
                return Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: const Center(child: CommonText(text: "No pending payments found")),
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeController.activeEvents.length,
                itemBuilder: (context, index) {
                  final event = homeController.activeEvents[index];

                  // Calculate days remaining
                  int daysLeft = 0;
                  if (event.eventDeadline != null) {
                    daysLeft = event.eventDeadline!.difference(DateTime.now()).inDays;
                  }

                  final payment = PendingPaymentModel(
                    title: event.name ?? "N/A",
                    amount: '\$ ${event.minContribution?.toStringAsFixed(2) ?? "0.00"}',
                    date: event.eventDeadline != null 
                        ? 'Due: ${DateFormat('MMM d, yyyy').format(event.eventDeadline!)}' 
                        : "No deadline",
                    timeLeft: '${daysLeft < 0 ? 0 : daysLeft} days left',
                  );

                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: PendingPaymentCard(
                      payment: payment,
                      onPayTap: () {
                        // Navigate to payment details with event info
                        Get.toNamed(AppRoutes.eventDetailsScreen, arguments: {
                          'eventId': event.id,
                          'hasPenalty': false,
                          'category': event.eventType,
                          'minContribution': event.minContribution,
                          'daysRemaining': daysLeft < 0 ? 0 : daysLeft,
                        });
                      },
                    ),
                  );
                },
              );
            }),
            SizedBox(height: 12.h),
            Obx(() => SectionHeader(
                  title: 'Payment History',
                  count: '${controller.paymentHistory.length} payments',
                )),
            SizedBox(height: 12.h),
            Obx(() => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: const Color(0xFFF1F5F9)),
                  ),
                  child: controller.isLoading.value
                      ? Padding(
                          padding: EdgeInsets.all(20.sp),
                          child: const Center(child: CircularProgressIndicator()),
                        )
                      : controller.paymentHistory.isEmpty
                          ? Padding(
                              padding: EdgeInsets.all(20.sp),
                              child: const Center(child: Text("No history found")),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.paymentHistory.length,
                              itemBuilder: (context, index) {
                                final history = controller.paymentHistory[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                        AppRoutes.paymentHistoryDetailsScreen,
                                        arguments: {'transaction': history});
                                  },
                                  child: HistoryPaymentItem(
                                    history: history,
                                    showDivider: index <
                                        controller.paymentHistory.length - 1,
                                  ),
                                );
                              },
                            ),
                )),
            SizedBox(height: 40.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.chatScreen);
        },
        backgroundColor: const Color(0xFF31993B),
        elevation: 4,
        shape: const CircleBorder(),
        child: Image.asset(
          AppIcons.chat,
          height: 18.h,
          width: 18.w,
        ),
      ),
    );
  }

  Widget _buildSubHeader(String notice) {
    return Row(
      children: [
        Expanded(
          child: CommonText(
            text: 'Track contributions, dues, and payment history.',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondaryColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.dialog(
              AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                title: const CommonText(
                  text: 'Notice',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                content: CommonText(
                  text: notice,
                  fontSize: 14.sp,
                ),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
          child: Icon(Icons.info_outline, color: const Color(0xFFEAB308), size: 20.sp),
        ),
      ],
    );
  }

  Widget _buildTotalPaidCard(double totalPaid) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            text: 'Total Paid',
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondaryColor,
          ),
          SizedBox(height: 6.h),
          CommonText(
            text: '\$ ${totalPaid.toStringAsFixed(2)}',
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: AppColors.color333333,
          ),
        ],
      ),
    );
  }

  Widget _buildStatGrid(double pending, double penalties) {
    return Row(
      children: [
        _buildStatCard('Pending', '\$ ${pending.abs().toStringAsFixed(2)}', const Color(0xFFFFF085),
            const Color(0xFFFEFCE8), AppColors.color333333),
        SizedBox(width: 12.w),
        _buildStatCard('Penalties', '\$ ${penalties.toStringAsFixed(2)}', const Color(0xFFFFC9C9),
            const Color(0xFFFEF2F2), const Color(0xFFE11D48)),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color border, Color bgColor,
      Color textColor) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.sp),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
                text: title,
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w500),
            SizedBox(height: 6.h),
            CommonText(
                text: value,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildPenaltyNotice(String notice) {
    return Container(
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: const Color(0x0DE43730),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0x26E43730),
          width: 1.w,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline,
              color: const Color(0xFFE11D48), size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                    text: 'Penalty Notice',
                    color: Color(0xFFE43730),
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
                SizedBox(height: 8.h),
                CommonText(
                  text: notice,
                  fontSize: 12.sp,
                  color: const Color(0xCCE43730),
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
