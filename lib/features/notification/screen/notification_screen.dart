import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../component/common_appbar/common_appbar.dart';
import '../../../component/text/common_text.dart';
import '../../../utils/constants/app_colors.dart';
import '../controller/notification_controller.dart';
import 'package:get/get.dart';
import '../../../component/other_widgets/common_skeleton.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CommonAppBar(
        title: 'Notifications',
        showBackButton: true,
        actions: [
          Obx(() => _NotificationBadge(count: "${controller.unreadCount.value} new")),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(
                    text: 'New',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color333333,
                  ),
                  GestureDetector(
                    onTap: () => controller.markAllAsRead(),
                    child: CommonText(
                      text: 'Mark all as read',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.green,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: 6,
                    itemBuilder: (context, index) => _buildSkeletonItem(),
                  );
                }
                if (controller.notificationList.isEmpty) {
                  return const Center(child: CommonText(text: "No notifications found"));
                }
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: controller.notificationList.length,
                  itemBuilder: (context, index) {
                    final item = controller.notificationList[index];

                    String formattedTime = item.createdAt != null
                        ? DateFormat('dd MMM, yyyy').format(item.createdAt!)
                        : "";bool isRead = item.read ?? true;
                    return GestureDetector(
                      onTap: () {
                        if (item.id != null) {
                          controller.markAsRead(item.id!);
                        }
                      },
                      child: _buildNotificationItem(
                        title: item.title ?? "",
                        subtitle: item.message ?? "",
                        time: formattedTime,
                        icon: Icons.notifications_none_rounded,
                        iconColor: isRead ? Colors.grey : AppColors.green,
                        bgColor: isRead
                            ? Colors.grey.withValues(alpha: 0.1)
                            : AppColors.green.withValues(alpha: 0.1),
                        hasIndicator: !isRead,
                        hasBorder: !isRead,
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonItem() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonSkeleton(height: 40.r, width: 40.r, borderRadius: 20),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonSkeleton(height: 16.h, width: 150.w),
                    CommonSkeleton(height: 8.h, width: 8.h, borderRadius: 4),
                  ],
                ),
                SizedBox(height: 8.h),
                CommonSkeleton(height: 12.h, width: double.infinity),
                SizedBox(height: 6.h),
                CommonSkeleton(height: 12.h, width: 200.w),
                SizedBox(height: 12.h),
                CommonSkeleton(height: 10.h, width: 80.w),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    bool hasIndicator = false,
    bool hasBorder = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: hasBorder
            ? Border(left: BorderSide(color: AppColors.green, width: 3.w))
            : Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CommonText(
                        text: title,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.color333333,
                      ),
                    ),
                    if (hasIndicator)
                      Container(
                        height: 8.h,
                        width: 8.h,
                        decoration:  BoxDecoration(
                          color: Color(0xFF27AE60),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                CommonText(
                  text: subtitle,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondaryColor,
                ),
                SizedBox(height: 8.h),
                CommonText(
                  text: time,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationBadge extends StatelessWidget {
  final String count;
  const _NotificationBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20.w, top: 12.h, bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color:  Color(0xFFE43730),
        borderRadius: BorderRadius.circular(20.r),
      ),

      child: CommonText(
        text: count,
        color: AppColors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),

    );
  }
}

///   >>>>>>>>>>>>>>>>>>>>>>>>>>>6a643e05da7a187d37bed04f>>>>>>>>>>>>>>>>>>>>>>>>>>>>6a643e05da7a187d37bed04f>>>>>>>>>>>>>>>>>>>>>>>>>>>>6a643e05da7a187d37bed04f>>>>>>>>>>>>>>>>>>>>>>>>>>