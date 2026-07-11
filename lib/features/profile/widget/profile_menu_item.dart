import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool isSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final Color? bgColor;
  final Color? iconColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? backArrowColor;
  final bool showArrow;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.isSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.bgColor,
    this.iconColor,
    this.titleColor,
    this.subtitleColor,
    this.showArrow = true, this.backArrowColor,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSwitch ? null : onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: (bgColor ?? Colors.white).withValues(alpha: 0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r ),
        ),),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.sp),
              decoration: BoxDecoration(
                color: (bgColor ?? Colors.white).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor ?? const Color(0xFF64748B), size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: title,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: titleColor ?? AppColors.color333333,
                  ),
                  if (subtitle != null)
                    CommonText(
                      text: subtitle!,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: subtitleColor ?? AppColors.textSecondaryColor,
                    ),
                ],
              ),
            ),
            if (isSwitch)
              SizedBox(
                width: 34.w,
                height: 16.h,
                child: Switch(
                  padding: EdgeInsets.zero,
                  value: switchValue,
                  onChanged: onSwitchChanged,
                  activeThumbColor: Colors.white,
                  activeTrackColor: const Color(0xFFA53200),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: const Color(0xFFCBD5E1),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              )
            else if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color:backArrowColor??  Color(0xFF94A3B8),
              ),
          ],
        ),
      ),
    );
  }
}
