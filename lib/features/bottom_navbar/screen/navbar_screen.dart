import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/features/home/screen/home_screen.dart';
import 'package:umodzi/utils/constants/app_colors.dart';
import 'package:umodzi/utils/constants/app_icons.dart';
import '../../event/screen/events_screen.dart';
import '../../payment/screen/payments_screen.dart';
import '../../profile/screen/profile_screen.dart';
import '../controller/navbar_controller.dart';

class NavbarScreen extends StatelessWidget {
  NavbarScreen({super.key});

  final NavbarController controller = Get.put(NavbarController());

  final List<Widget> screens = [
    const HomeScreen(),
     EventsScreen(),
     PaymentsScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() => screens[controller.selectedIndex.value]),

      bottomNavigationBar: Obx(
            () => Container(
          height: 110.h,

          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0x0D000000),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: controller.changeIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              _buildNavbarItem(
                iconPath: AppIcons.home,
                label: 'Home',
                index: 0,
              ),
              _buildNavbarItem(
                iconPath: AppIcons.event,
                label: 'Events',
                index: 1,
              ),
              _buildNavbarItem(
                iconPath: AppIcons.paymentN,
                label: 'Payments',
                index: 2,
              ),
              _buildNavbarItem(
                iconPath: AppIcons.profile,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavbarItem({
    required String iconPath,
    required String label,
    required int index,
  }) {
    bool isSvg = iconPath.endsWith('.svg');

    return BottomNavigationBarItem(
      icon: isSvg
          ? SvgPicture.asset(
        iconPath,
        height: 24.h,
        colorFilter: const ColorFilter.mode(Color(0xFF94A3B8), BlendMode.srcIn),
      )
          : Image.asset(
        iconPath,
        height: 24.h,
        color: const Color(0xFF99A1AF),
      ),

      activeIcon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CommonText(text:
            label,

              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color:  AppColors.logoutRed,

          ),
          SizedBox(height: 6.h),
          Container(
            height: 2.h,
            width: 18.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6D2100),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
      label: '',
    );
  }
}