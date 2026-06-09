import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:umodzi/component/text/common_text.dart';
import '../controller/profile_controller.dart';
import '../../../component/other_widgets/common_skeleton.dart';

class UserStatsCard extends StatelessWidget {
  const UserStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();

    return Obx(() {
      if (controller.isStatsLoading.value) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF9EDE9),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSkeletonStat(),
              _buildSkeletonStat(),
              _buildSkeletonStat(),
            ],
          ),
        );
      }

      // API Data mapping
      final summary = controller.paymentBreakdown.value?.summary;
      
      // Formatting Member Since Date
      String memberSince = 'N/A';
      if (controller.profileData.value?.createdAt != null) {
        try {
          DateTime date = DateTime.parse(controller.profileData.value!.createdAt!);
          memberSince = DateFormat('MMM yyyy').format(date);
        } catch (e) {
          memberSince = 'N/A';
        }
      }

      return Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: const Color(0xFFF9EDE9),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildStatItem(
              '\$${summary?.grandTotal?.toStringAsFixed(0) ?? '0'}',
              'Total\nContributions'
            ),
            _buildStatItem(
              summary?.totalParticipatedEvents ?.toStringAsFixed(0) ?? '0',
              'Events\nParticipated'
            ),
            _buildStatItem(
              memberSince, 
              'Member\nSince'
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSkeletonStat() {
    return Expanded(
      child: Column(
        children: [
          CommonSkeleton(height: 20.h, width: 50.w),
          SizedBox(height: 8.h),
          CommonSkeleton(height: 12.h, width: 60.w),
          SizedBox(height: 4.h),
          CommonSkeleton(height: 12.h, width: 40.w),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          CommonText(
            text: value,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFA53200),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6.h),
          CommonText(
            text: label,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF64748B),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
