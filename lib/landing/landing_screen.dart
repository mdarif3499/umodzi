import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../component/text/common_text.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_images.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

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
                SizedBox(height: 20.h),

                const CommonText(
                  text: "Welcome to Mphamvu Mu Umodzi",
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimaryColor,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                 CommonText(
                  text: "Your Trusted Partner in Difficult Times",
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text6BD45,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),
                _buildActionCard(
                  image: AppImages.signIn,
                  title: "Sign In",
                  subtitle: "Access your account and stay connected",
                  onTap: () {
                    // Get.toNamed(AppRoutes.signIn);
                  },
                ),
                SizedBox(height: 16.h),

                _buildActionCard(
                  image: AppImages.signUp,
                  title: "Contribute",
                  subtitle: "Be part of something meaningful",
                  onTap: () {},
                ),
                SizedBox(height: 16.h),

                _buildActionCard(
                  image: AppImages.mmu,
                  title: "MMU Bylaws",
                  subtitle: "Understand our rules and guiding principles",
                  onTap: () {},
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF7A06),
              Color(0xFFAA7E55),
              Color(0xFFFF7A06),
            ],
          ),
        ),
        child: Container(
          margin: EdgeInsets.all(1.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2a0d01), 
            borderRadius: BorderRadius.circular(11.r),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(11.r),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    height: 52.h,
                    width: 52.w,
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFF7A06), width: 1.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(26.r),
                      child: Image.asset(image, fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: title,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                        SizedBox(height: 2.h),
                        CommonText(
                          text: subtitle,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.color6B6B6B.withValues(alpha: 0.8),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
