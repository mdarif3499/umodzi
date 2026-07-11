import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/config/route/app_routes.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/app_icons.dart';

import '../../home/controller/home_controller.dart';
import '../../home/widget/custom_home_appbar.dart';
import '../controller/profile_controller.dart';
import '../widget/profile_menu_item.dart';
import '../widget/user_info_card.dart';
import '../widget/user_stats_card.dart';
import '../widget/logout_dialog.dart';
import '../widget/delete_account_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor:  Color(0xFFFDFDFD),
      appBar:  CustomHomeAppBar(
        hasNotification: true,
        isEventPage: true,
        title: 'Profile',
      ),
      body: SingleChildScrollView(
        physics:  ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.h),
            _buildSubHeader(),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color:  Color(0xFFF1F5F9)),
              ),
              child: Column(
                children: [
                   UserInfoCard(),
                  SizedBox(height: 16.h),
                   UserStatsCard(),
                ],
              ),
            ),
            Obx(() => ProfileMenuItem(
              icon: Icons.notifications_none_outlined,
              title: 'Notification',
              isSwitch: true,
              switchValue: controller.isNotificationEnabled.value,
              onSwitchChanged: controller.toggleNotification,
              showArrow: false,
            )),
            Container(
              padding: EdgeInsets.all(0.sp),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color:  Color(0xFFF1F5F9)),
              ),
              child: Column(
                children: [
                  ProfileMenuItem(
                    backArrowColor:  Color(0xFFA53200),
                    icon: Icons.notification_important_outlined,
                    title: 'Report an Event',
                    subtitle: 'Notify us for Urgent Event',
                    bgColor:  Color(0x1AA53200),
                    iconColor:  Color(0xFFA53200),
                    titleColor:  Color(0xFFA53200),
                    subtitleColor:  Color(0xFFA53200).withValues(alpha: 0.6),
                    showArrow: true,
                    onTap: () => Get.toNamed(AppRoutes.reportEvent),
                  ),
                  SizedBox(height: 8.h),
                  Obx(() => ProfileMenuItem(
                    icon: Icons.people_outline,
                    title: 'Dependents',
                    subtitle: '${homeController.quickActionData.value.dependenceCount ?? 0} registered',
                    onTap: () => Get.toNamed(AppRoutes.myFamilyScreen),
                  )),
                  ProfileMenuItem(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    subtitle: 'Update your current password',
                    onTap: () => Get.toNamed(AppRoutes.changePassword),
                  ),
                  ProfileMenuItem(
                    icon: Icons.description_outlined,
                    title: 'Terms of Service',
                    subtitle: 'See details of terms of service',
                    onTap: () => Get.toNamed(AppRoutes.termsOfService),
                  ),
                  ProfileMenuItem(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    subtitle: 'See details of privacy policy',
                    onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                  ),
                  ProfileMenuItem(
                    icon: Icons.chat_bubble_outline,
                    title: 'FAQ\'s',
                    subtitle: 'See details of FAQ\'s',
                    onTap: () => Get.toNamed(AppRoutes.faq),
                  ),
                  ProfileMenuItem(
                    icon: Icons.info_outline,
                    title: 'About Us',
                    subtitle: 'Know about the platform',
                    onTap: () => Get.toNamed(AppRoutes.aboutUs),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            
            _buildActionButton(
              text: 'Edit Profile',
              onTap: () => Get.toNamed(AppRoutes.editProfile),
              isOutline: true,
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    text: 'Delete Account',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => DeleteAccountDialog(
                          controller: controller.deletePasswordController,
                          onDelete: () {
                            Get.back();
                            Get.toNamed(AppRoutes.signIn);
                          },
                        ),
                      );
                    },
                    isOutline: true,
                    textColor: AppColors.logoutRed,
                    borderColor: AppColors.logoutRed,
                    icon: Icons.delete_outline,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildActionButton(
                    text: 'Sign Out',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>  LogoutDialog(),
                      );
                    },
                    color: AppColors.logoutRed,
                  ),
                ),
              ],
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeController.createChatAndNavigate();
        },
        backgroundColor:  Color(0xFF31993B),
        elevation: 4,
        shape:  CircleBorder(),
        child: Image.asset(
          AppIcons.chat,
          height: 18.h,
          width: 18.w,
        ),
      ),
    );
  }
  Widget _buildSubHeader() {
    return Row(
      children: [
        Expanded(
          child: CommonText(
            text: 'Manage your account and membership status.',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onTap,
    bool isOutline = false,
    Color? color,
    Color? textColor,
    Color? borderColor,
    IconData? icon,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutline ? Colors.transparent : (color ?? Colors.black),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
            side: isOutline
                ? BorderSide(color: borderColor ?? const Color(0xFFE2E8F0))
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor ?? (isOutline ? Colors.black : Colors.white), size: 20.sp),
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: TextStyle(
                color: textColor ?? (isOutline ? Colors.black : Colors.white),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
