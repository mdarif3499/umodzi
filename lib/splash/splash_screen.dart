import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/services/storage/storage_services.dart';
import '../component/text/common_text.dart';
import 'package:get/get.dart';
import '../config/route/app_routes.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    
    try {
      if (LocalStorage.isLogIn) {
        Get.offAllNamed(AppRoutes.navBarScreen);
      } else {

      }
    } catch (e) {
      debugPrint("Navigation Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 60.h),

                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        AppImages.bag,
                        height: 380.h,
                        width: 380.w,
                        fit: BoxFit.contain,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.yellow.withValues(alpha: 0.2),
                              blurRadius: 70,
                              spreadRadius: 25,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          AppImages.appLogoP,
                          height: 220.h,
                          width: 220.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 0.h),

                const CommonText(
                  text: "Welcome to Mphamvu Mu Umodzi",
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimaryColor,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                const CommonText(
                  text: "Your Trusted Partner in Difficult Times",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text6BD45,
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 50.h),

                _buildActionCard(
                  image: AppImages.signIn,
                  title: "Sign In",
                  subtitle: "Access your account and stay connected",
                  onTap: () {
                    Get.toNamed(AppRoutes.signIn);
                  },
                ),
                SizedBox(height: 12.h),

                _buildActionCard(
                  image: AppImages.mmu,
                  title: "MMU Bylaws",
                  subtitle: "Understand our rules and guiding principles",
                  onTap: () {
                    Get.toNamed(AppRoutes.mmuBylawsScreen);
                  },
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required String title,
    required String image,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF2a0d01),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.yellow.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 48.h,
              width: 50.w,
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.yellow, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.r),
                child: Image.asset(image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 6.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                  SizedBox(height: 2.h),
                  CommonText(
                    text: subtitle,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.colorFFB2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
