import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../component/button/common_button.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../../../component/text/common_text.dart';
import '../../../config/route/app_routes.dart';
import '../../../utils/constants/app_colors.dart';


class StatusActivityScreen extends StatelessWidget {
  const StatusActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CommonAppBar(
        title: 'Status Activity',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(20.sp),
              child: Container(
                padding: EdgeInsets.all(24.sp),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF1F1),

                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color:Color(0x33FF4D4F)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.sp),
                          decoration: BoxDecoration(
                            color: Color(0x1AE43730),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: const Icon(
                            Icons.block_flipped,
                            color: Color(0xFFE43730),
                            size: 28,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFA53200),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: CommonText(
                            text: 'SUSPENDED',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    CommonText(
                      text: 'Account Suspension Policy',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.color333333,
                    ),
                    SizedBox(height: 8.h),
                    CommonText(
                      text: 'Suspended members lose access to all benefits until reactivated.',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondaryColor,

                    ),
                    SizedBox(height: 24.h),

                    CommonText(
                      text: 'WHEN SUSPENDED',
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      letterSpacing: 0.55,
                    ),
                    SizedBox(height: 16.h),
                    _buildPolicyItem(Icons.remove_circle_outline, 'No access to member benefits'),
                    SizedBox(height: 12.h),
                    _buildPolicyItem(Icons.remove_circle_outline, 'Features and privileges will be disabled'),

                    SizedBox(height: 32.h),

                    Container(
                      padding: EdgeInsets.all(20.sp),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: 'To Reactivate Your Account:',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.color333333,
                          ),
                          SizedBox(height: 16.h),
                          _buildCheckItem('Pay all outstanding dues'),
                          SizedBox(height: 12.h),
                          _buildCheckItem('Pay \$30 reinstatement fee'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.h),

            Padding(
              padding: EdgeInsets.all(20.sp),
              child: CommonButton(
                titleText: 'Reactivate Account',
                buttonColor: AppColors.green,
                buttonRadius: 12,
                onTap: () {
                  Get.toNamed(AppRoutes.paymentResolution, arguments: {'dueDays': '0'});                },


              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.red, size: 20.w),
        SizedBox(width: 12.w),
        Expanded(
          child: CommonText(
            text: text,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.color333333,
          ),
        ),
      ],
    );
  }

  Widget _buildCheckItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 20),
        SizedBox(width: 12.w),
        Expanded(
          child: CommonText(
            text: text,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.color333333,
          ),
        ),
      ],
    );
  }
}