import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/config/route/app_routes.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/app_icons.dart';
import 'package:get/get.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isEventPage;
  final String? title;
  final bool hasNotification;
  final bool showAddDependent;
  final bool isTransparent;

  const CustomHomeAppBar({
    super.key,
    this.isEventPage = false,
    this.title,
    this.hasNotification = true,
    this.showAddDependent = true,
    this.isTransparent = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 20.w,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: isTransparent ? Colors.white.withValues(alpha: 0.5) : const Color(0xFFE2E8F0), width: 1),
            ),
            child: CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.transparent,
              backgroundImage: const AssetImage(AppIcons.homeIcon),
            ),
          ),
          if (isEventPage)
            CommonText(
              text: title ?? 'Events',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: isTransparent ? Colors.white : Colors.black,
            ),
          Row(
            children: [
              if (!isEventPage && showAddDependent)
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.addDependentScreen),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 13.h),
                    decoration: BoxDecoration(
                      color: const Color(0x14A53200),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Image.asset(AppIcons.mans, height: 14.h, color: const Color(0xFF64748B)),
                        SizedBox(width: 6.w),
                        CommonText(
                          text: 'Add Dependent',
                          fontSize: 12.sp,
                          color: AppColors.color6A7282,
                        ),
                      ],
                    ),
                  ),
                ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.notificationScreen),
                child: Container(
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x0D000000),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    AppIcons.notification,
                    height: 20.h,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
