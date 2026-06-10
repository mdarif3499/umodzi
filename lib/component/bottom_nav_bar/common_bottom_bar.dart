import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/log/app_log.dart';

final List<Widget> _unselectedIcons = [
  const Icon(Icons.settings_outlined, color: AppColors.black),
  const Icon(Icons.notifications_outlined, color: AppColors.black),
  const Icon(Icons.chat, color: AppColors.black),
  const Icon(Icons.person_2_outlined, color: AppColors.black),
];

final List<Widget> _selectedIcons = [
  const Icon(Icons.settings_outlined, color: AppColors.primaryColor),
  const Icon(Icons.notifications, color: AppColors.primaryColor),
  const Icon(Icons.chat, color: AppColors.primaryColor),
  const Icon(Icons.person, color: AppColors.primaryColor),
];

class CommonBottomNavBar extends StatelessWidget {
  const CommonBottomNavBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.blueLight,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_unselectedIcons.length, (index) {
            return InkWell(
              onTap: () => onTap(index),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                child: index == currentIndex
                    ? _selectedIcons[index]
                    : _unselectedIcons[index],
              ),
            );
          }),
        ),
      ),
    );
  }

  Future<void> onTap(int index) async {
    appLog(currentIndex, source: 'common bottom bar');

    if (index == currentIndex) return;
    switch (index) {
      case 0:
      // Get.toNamed(AppRoutes.setting);
        break;

      case 1:
      // Get.toNamed(AppRoutes.notifications);
        break;

      case 2:
      // Get.toNamed(AppRoutes.chat);
        break;

      case 3:
      // Get.toNamed(AppRoutes.profile);
        break;

      default:
        appLog('Invalid bottom bar index: $index');
    }
  }
}