import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
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
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leadingWidth: 70.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Center(
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                height: 40.r,
                width: 40.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFFDF2F0),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.chevron_left, color: const Color(0xFF8B4513), size: 24.sp),
              ),
            ),
          ),
        ),
        title: CommonText(
          text: 'Payment Details',
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF423838),
        ),
      ),
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
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              letterSpacing: 0.5,
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
                          ...breakdownList.map((item) => _buildDueCard(item)),
                        
                        if (summary != null) ...[
                          _buildSummarySection(summary),
                        ],
                        
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Obx(() => CommonButton(
                  titleText: 'Next',
                  buttonColor: AppColors.green,
                  buttonRadius: 10,
                  titleSize: 16,
                  titleWeight: FontWeight.w600,
                  isLoading: controller.isLoading.value,
                  onTap: () {
                    controller.checkoutPenalties();
                  },
                )),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final bool isActive = status.toLowerCase() == 'active';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFF0FDF4) : const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isActive ? Icons.check_circle : Icons.error,
            color: isActive ? AppColors.green : const Color(0xFFEF4444),
            size: 18.sp,
          ),
          SizedBox(width: 8.w),
          CommonText(
            text: status.capitalizeFirst ?? 'Active',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isActive ? AppColors.green : const Color(0xFFEF4444),
          ),
        ],
      ),
    );
  }

  Widget _buildDueCard(BreakdownItem item) {
    final String formattedDate = item.deadlinePassed != null 
        ? DateFormat('MMMM dd, yyyy').format(item.deadlinePassed!) 
        : "N/A";

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 0.5),
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
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF423838),
                  maxLines: 1,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CommonText(
                  text: item.eventType ?? "N/A",
                  fontSize: 11.sp,
                  color: const Color(0xFFF59E0B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          
          Row(
            children: [
              Icon(Icons.calendar_month_outlined, size: 16.sp, color: Colors.grey),
              SizedBox(width: 8.w),
              const CommonText(
                text: 'Deadline Passed:',
                fontSize: 13,
                color: Colors.grey,
              ),
              const Spacer(),
              CommonText(
                text: formattedDate,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF423838),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey.shade100, thickness: 1),
          SizedBox(height: 12.h),
          
          Row(
            children: [
              CommonText(text: 'Minimum contribution ', fontSize: 11.sp, color: Colors.grey),
              CommonText(
                text: '\$${item.minContribution?.toStringAsFixed(2) ?? "0.00"}', 
                fontSize: 12.sp, 
                fontWeight: FontWeight.w600, 
                color: const Color(0xFFD32F2F)
              ),
              const Spacer(),
              CommonText(text: 'Penalty fee ', fontSize: 11.sp, color: Colors.grey),
              CommonText(
                text: '\$${item.penaltyFee?.toStringAsFixed(2) ?? "0.00"}', 
                fontSize: 12.sp, 
                fontWeight: FontWeight.w600, 
                color: const Color(0xFFD32F2F)
              ),
            ],
          ),
          SizedBox(height: 16.h),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                text: 'Total Due',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF423838),
              ),
              CommonText(
                text: '\$ ${item.totalDue?.toStringAsFixed(2) ?? "0.00"}',
                fontSize: 26.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFD32F2F),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection(Summary summary) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9F0),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        children: [
          _buildSummaryRow('Total Events Dues', '\$${summary.totalEventDues?.toStringAsFixed(2) ?? "0.00"}'),
          SizedBox(height: 12.h),
          _buildSummaryRow('Penalty Fee (Late Payment)', '\$${summary.totalPenaltyFee?.toStringAsFixed(2) ?? "0.00"}'),
          SizedBox(height: 12.h),
          Divider(color: Colors.grey.withOpacity(0.2), thickness: 1),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CommonText(
                text: 'Total Due',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFF423838),
              ),
              CommonText(
                text: '\$${summary.grandTotal?.toStringAsFixed(2) ?? "0.00"}',
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
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
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        CommonText(
          text: amount,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF423838),
        ),
      ],
    );
  }
}
