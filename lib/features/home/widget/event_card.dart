import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/component/image/common_image.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String amount;
  final String category;
  final String timeLeft;
  final String imagePath;
  final bool isUrgent;
  final String actionText;

  const EventCard({
    super.key,
    required this.title,
    required this.amount,
    required this.category,
    required this.timeLeft,
    required this.imagePath,
    this.isUrgent = false,
    this.actionText = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                bottomLeft: Radius.circular(8.r),
              ),
              child: CommonImage(
                imageSrc: imagePath,
                width: 100.w,
                fill: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CommonText(
                              text: title, maxLines: 1, fontSize: 14.sp),
                        ),
                        CommonText(
                            text: amount,
                            fontSize: 14.sp,
                            color: AppColors.green),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: CommonText(
                          text: category,
                          fontSize: 11,
                          color: const Color(0xFFE29D19)),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.access_time,
                                size: 14.sp, color: Colors.grey),
                            SizedBox(width: 4.w),
                            Text(timeLeft,
                                style: TextStyle(
                                    fontSize: 11.sp, color: Colors.grey)),
                          ],
                        ),
                        if (actionText == 'Urgent')
                          _buildBadge(const Color(0xFFFEE2E2),
                              const Color(0xFFB91C1C), 'Urgent')
                        else if (actionText == 'Action Needed')
                          _buildBadge(const Color(0xFFFEF3C7),
                              Color(0xFFE29D19), 'Action Needed'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(Color bgColor, Color textColor, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: CommonText(text: text, fontSize: 10.sp, color: textColor),
    );
  }
}
