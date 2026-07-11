import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../component/button/common_button.dart';
import '../component/text/common_text.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_images.dart';
import '../config/route/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Map<String, String>> _onboardingData = [
    {
      'image': AppImages.onboarding1,
      'title': 'Support Your Community',
      'subtitle': 'Come together to help members during difficult times through simple and meaningful contributions.',
    },
    {
      'image': AppImages.onboarding2,
      'title': 'Contribute with Ease',
      'subtitle': 'Make quick payments, stay on track, and manage your contributions effortlessly in one place.',
    },
    {
      'image': AppImages.onboarding3,
      'title': 'Stay Informed & Secure',
      'subtitle': 'Get timely reminders, track your status, and never miss an important update or deadline.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            height: 540.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFA53200).withValues(alpha: 0.04),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
            ),
          ),
          
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       CommonText(
                        text: 'MMU',
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFA53200),
                      ),
                      GestureDetector(
                        onTap: () => Get.offAllNamed(AppRoutes.signIn), // Go to SignIn
                        child: CommonText(
                          text: 'SKIP',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) => setState(() => _currentPage = index),
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 400.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              child: Image.asset(
                                _onboardingData[index]['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 50.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: CommonText(
                              text: _onboardingData[index]['title']!,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.w),
                            child: CommonText(
                              text: _onboardingData[index]['subtitle']!,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade600,
                              textAlign: TextAlign.center,
                              height: 1.5,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(bottom: 60.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _onboardingData.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            height: 6.h,
                            width: _currentPage == index ? 24.w : 6.w,
                            decoration: BoxDecoration(
                              color: _currentPage == index ? Colors.black : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 80.w),
                        child: CommonButton(
                          buttonWidth:_currentPage == _onboardingData.length - 1?165.w: 140.w,
                          showIcon: true,
                          buttonColor: AppColors.color333333,
                          titleText: _currentPage == _onboardingData.length - 1
                              ? 'Get Started'
                              : 'Next',
                          onTap: () {
                            if (_currentPage < _onboardingData.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              Get.offAllNamed(AppRoutes.signIn);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
