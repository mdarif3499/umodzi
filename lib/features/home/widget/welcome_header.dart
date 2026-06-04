import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeHeader extends StatefulWidget {
  const WelcomeHeader({super.key});

  @override
  State<WelcomeHeader> createState() => _WelcomeHeaderState();
}

class _WelcomeHeaderState extends State<WelcomeHeader> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Welcome back, Marcus',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        CompositedTransformTarget(
          link: _link,
          child: OverlayPortal(
            controller: _tooltipController,
            overlayChildBuilder: (context) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () => _tooltipController.hide(),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.3),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  CompositedTransformFollower(
                    link: _link,
                    targetAnchor: Alignment.bottomRight,
                    followerAnchor: Alignment.topRight,
                    offset: Offset(0, 10.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: _buildMembershipPopup(),
                    ),
                  ),
                ],
              );
            },
            child: GestureDetector(
              onTap: () => _tooltipController.show(),
              child: Icon(
                Icons.info_outline,
                color: const Color(0xFFD97706),
                size: 24.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildMembershipPopup() {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width-50,
        margin: EdgeInsets.only(right: 20.w),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16.r),
              bottomRight: Radius.circular(16.r),
          
          topLeft: Radius.circular(16.r)
          ),
          border: Border.all(color: const Color(0xFFF59E0B), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Membership Status",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.sp,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "Your membership is active. Next payment due: April 28, 2026",
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF475569),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
