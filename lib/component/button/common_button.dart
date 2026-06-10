import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/utils/constants/app_icons.dart';
import '../../utils/constants/app_colors.dart';
import '../text/common_text.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;
  final Color titleColor;
  final Color? buttonColor;
  final Color? borderColor;
  final double borderWidth;
  final double titleSize;
  final FontWeight titleWeight;
  final double buttonRadius;
  final double buttonHeight;
  final double? buttonWidth;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;
  final bool showIcon;
  final String? iconPath;

  const CommonButton({
    super.key,
    this.onTap,
    required this.titleText,
    this.titleColor = Colors.white,
    this.buttonColor,
    this.titleSize = 16,
    this.buttonRadius = 10,
    this.titleWeight = FontWeight.w700,
    this.buttonHeight = 48,
    this.borderWidth = 1,
    this.isLoading = false,
    this.buttonWidth = double.infinity,
    this.borderColor,
    this.padding,
    this.showIcon = false,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonWidth?.w,
      height: buttonHeight.h,
      child: ElevatedButton(
        onPressed: (isLoading || onTap == null) ? null : onTap,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: (buttonColor ?? AppColors.primaryColor).withValues(alpha: 0.5),
          backgroundColor: buttonColor ?? AppColors.primaryColor,
          foregroundColor: titleColor,
          elevation: 0,
          padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius.r),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth)
                : BorderSide.none,
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonText(
                    text: titleText,
                    color: titleColor,
                    fontSize: titleSize,
                    fontWeight: titleWeight,
                  ),
                  if (showIcon) ...[
                    SizedBox(width: 8.w),
                    Image.asset(
                      iconPath ?? AppIcons.arrowR,
                      height: 10.h,
                      width: 14.w,
                      color: AppColors.white,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
