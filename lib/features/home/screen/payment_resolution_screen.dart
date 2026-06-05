import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../../profile/controller/profile_controller.dart';
import '../../profile/data/payment_breakdown_model.dart';

class PaymentResolutionScreen extends StatelessWidget {
  const PaymentResolutionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    
    // Ensure we have the latest data
    controller.fetchPaymentBreakdown();

    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Payment Details',
        showBackButton: true,
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isStatsLoading.value) {
            return const Center(child: CircularProgressIndicator(color: AppColors.green));
          }

          final data = controller.paymentBreakdown.value;
          if (data == null) {
            return const Center(child: CommonText(text: "No data available"));
          }

          final String status = data.status ?? 'active';
          final breakdownList = data.breakdown ?? [];
          final summary = data.summary;

          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => controller.fetchPaymentBreakdown(),
                  color: AppColors.green,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonText(
                              text: 'BREAKDOWN OF DUES',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondaryColor,
                              letterSpacing: 1.1,
                            ),
                            _buildStatusBadge(status),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        
                        if (breakdownList.isEmpty)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(vertical: 40.h),
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Icon(Icons.info_outline, size: 48.sp, color: Colors.grey.shade300),
                                SizedBox(height: 12.h),
                                const CommonText(text: "No pending dues found"),
                              ],
                            ),
                          )
                        else
                          ...breakdownList.map((item) => Padding(
                            padding: EdgeInsets.only(bottom: 12.h),
                            child: _buildDueCard(item),
                          )),
                        
                        if (summary != null) ...[
                          SizedBox(height: 24.h),
                          _buildSummarySection(summary),
                        ],
                        
                        SizedBox(height: 30.h),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.r),
                child: CommonButton(
                  titleText: 'Proceed to Payment',
                  buttonColor: AppColors.green,
                  buttonRadius: 12,
                  titleSize: 16,
                  titleWeight: FontWeight.w600,
                  onTap: () {
                    // Navigate to checkout or specific payment flow
                    Get.back();
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final bool isSuspended = status.toLowerCase() != 'active';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isSuspended ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSuspended ? const Color(0xFFFEE2E2) : const Color(0xFFDCFCE7),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isSuspended ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded,
            color: isSuspended ? const Color(0xFFEF4444) : AppColors.green,
            size: 16.sp,
          ),
          SizedBox(width: 6.w),
          CommonText(
            text: status.capitalizeFirst ?? 'Active',
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: isSuspended ? const Color(0xFFEF4444) : AppColors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildDueCard(BreakdownItem item) {
    final String formattedDate = item.deadlinePassed != null 
        ? DateFormat('MMM dd, yyyy').format(item.deadlinePassed!) 
        : "N/A";

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CommonText(
                  text: item.eventName ?? "Event Name",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  maxLines: 1,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: CommonText(
                  text: item.eventType ?? "N/A",
                  fontSize: 10.sp,
                  color: const Color(0xFFF59E0B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          
          Row(
            children: [
              Icon(Icons.calendar_month_outlined, size: 14.sp, color: AppColors.textSecondaryColor),
              SizedBox(width: 8.w),
              CommonText(
                text: 'Deadline Passed:',
                fontSize: 12.sp,
                color: AppColors.textSecondaryColor,
              ),
              const Spacer(),
              CommonText(
                text: formattedDate,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Divider(color: Colors.grey.shade100, thickness: 1),
          SizedBox(height: 14.h),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAmountRow('Base Contribution', 'MWK ${item.minContribution?.toStringAsFixed(2) ?? "0.00"}'),
                  SizedBox(height: 6.h),
                  _buildAmountRow('Late Penalty Fee', 'MWK ${item.penaltyFee?.toStringAsFixed(2) ?? "0.00"}', isRed: true),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const CommonText(text: 'Total Due', fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textSecondaryColor),
                  SizedBox(height: 2.h),
                  CommonText(
                    text: 'MWK ${item.totalDue?.toStringAsFixed(2) ?? "0.00"}',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFD32F2F),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String amount, {bool isRed = false}) {
    return Row(
      children: [
        CommonText(text: '$label: ', fontSize: 11.sp, color: AppColors.textSecondaryColor),
        CommonText(
          text: amount, 
          fontSize: 11.sp, 
          fontWeight: FontWeight.w600, 
          color: isRed ? const Color(0xFFD32F2F) : AppColors.black
        ),
      ],
    );
  }

  Widget _buildSummarySection(Summary summary) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Total Base Dues', 'MWK ${summary.totalEventDues?.toStringAsFixed(2) ?? "0.00"}'),
          SizedBox(height: 12.h),
          _buildSummaryRow('Total Penalty Fees', 'MWK ${summary.totalPenaltyFee?.toStringAsFixed(2) ?? "0.00"}'),
          if ((summary.reactivationAmount ?? 0) > 0) ...[
            SizedBox(height: 12.h),
            _buildSummaryRow('Reactivation Fee', 'MWK ${summary.reactivationAmount?.toStringAsFixed(2) ?? "0.00"}'),
          ],
          SizedBox(height: 16.h),
          const Divider(color: Color(0xFFE2E8F0), thickness: 1.5),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonText(
                text: 'Grand Total',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
              CommonText(
                text: 'MWK ${summary.grandTotal?.toStringAsFixed(2) ?? "0.00"}',
                fontSize: 24.sp,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFD32F2F),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonText(
          text: title,
          fontSize: 14.sp,
          color: AppColors.textSecondaryColor,
          fontWeight: FontWeight.w500,
        ),
        CommonText(
          text: amount,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      ],
    );
  }
}
