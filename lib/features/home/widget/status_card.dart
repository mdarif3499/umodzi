import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:umodzi/component/button/common_button.dart';
import 'package:umodzi/component/text/common_text.dart';
import 'package:umodzi/utils/constants/app_colors.dart';

class StatusCard extends StatefulWidget {
  final bool isSuspended;
  final String amount;
  final String dueDate;
  final VoidCallback onPaymentTap;
  final String? reason;
  final String? reactivation;
  final String? lastPaymentAmount;
  final String? lastPaymentDate;
  final String? activeWarning;

  const StatusCard({
    super.key,
    required this.isSuspended,
    required this.amount,
    required this.dueDate,
    required this.onPaymentTap,
    this.reason,
    this.reactivation,
    this.lastPaymentAmount,
    this.lastPaymentDate,
    this.activeWarning,
  });

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final _link = LayerLink();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: widget.isSuspended
              ? const Color(0xFFFEE2E2)
              : const Color(0xFFF1F5F9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CommonText(
                            text: 'STATUS',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.text121212,
                          ),
                          widget.isSuspended
                              ? CompositedTransformTarget(
                                  link: _link,
                                  child: OverlayPortal(
                                    controller: _tooltipController,
                                    overlayChildBuilder: (context) {
                                      final cardWidth =
                                          MediaQuery.of(context).size.width -
                                              40.w;
                                      final contentAreaWidth =
                                          cardWidth - 32.r - 24.w;
                                      final leftColWidth =
                                          contentAreaWidth * 5 / 11;
                                      final iconCenterX =
                                          16.r + leftColWidth - 9.sp;
                                      final dx = (cardWidth / 2) - iconCenterX;
                                      return Stack(
                                        children: [
                                          GestureDetector(
                                            onTap: () =>
                                                _tooltipController.hide(),
                                            child: Container(
                                              color: Colors.black
                                                  .withValues(alpha: 0.1),
                                              width: double.infinity,
                                              height: double.infinity,
                                            ),
                                          ),
                                          CompositedTransformFollower(
                                            link: _link,
                                            targetAnchor:
                                                Alignment.bottomCenter,
                                            followerAnchor: Alignment.topCenter,
                                            offset: Offset(dx, 8.h),
                                            child: _buildMembershipPopup(
                                                cardWidth, iconCenterX),
                                          ),

                                          // Windows PowerShell
                                          // Copyright (C) Microsoft Corporation. All rights reserved.
                                          //
                                          // PS C:\Users\mdyou\StudioProjects\umodzi>
                                          ///Windows PowerShell
                                         // // Copyright (C) Microsoft Corporation. All rights reserved.
                                        // //
                                       // // PS C:\Users\mdyou\StudioProjects\umodzi>
                                        ],
                                      );
                                    },
                                    child: GestureDetector(
                                      onTap: () => _tooltipController.show(),
                                      child: Icon(
                                        Icons.info_outline,
                                        color: const Color(0xFFD97706),
                                        size: 18.sp,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                              color: widget.isSuspended
                                  ? const Color(0xFFFEE2E2)
                                  : const Color(0xFFE8F5E9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              widget.isSuspended
                                  ? Icons.warning_rounded
                                  : Icons.check_circle,
                              color: widget.isSuspended
                                  ? Colors.red
                                  : AppColors.green,
                              size: 14.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          CommonText(
                            text: widget.isSuspended ? 'Suspended' : 'Active',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: widget.isSuspended
                                ? Colors.red
                                : AppColors.green,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      CommonText(
                        text: 'PENDING DUES',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text121212,
                      ),
                      CommonText(
                        text: widget.amount,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondaryColor,
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.access_time,
                                color: AppColors.textSecondaryColor,
                                size: 14.sp),
                            SizedBox(width: 4.w),
                            CommonText(
                              text: 'Due ${widget.dueDate}',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.color333333,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Vertical Divider
                VerticalDivider(
                  color: const Color(0xFFF1F5F9),
                  thickness: 1.5,
                  width: 24.w,
                ),
                // Right Column (Flex 6)
                Expanded(
                  flex: 6,
                  child: widget.isSuspended
                      ? _buildSuspendedInfo()
                      : _buildActiveInfo(),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: CommonButton(
              onTap: widget.onPaymentTap,
              titleText: 'Make Payment',
              buttonColor: widget.isSuspended
                  ? const Color(0xFFEF4444)
                  : AppColors.green,
              titleColor: AppColors.white,
              buttonRadius: 12,
              buttonHeight: 40,
              titleSize: 16,
              titleWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuspendedInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonText(
            text: 'Reason:',
            fontSize: 11.sp,
            color: AppColors.textSecondaryColor),
        CommonText(
            text: widget.reason ?? 'N/A',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500),
        SizedBox(height: 8.h),
        CommonText(
            text: 'Reactivation:',
            fontSize: 11.sp,
            color: AppColors.textSecondaryColor),
        CommonText(
            text: widget.reactivation ?? 'N/A',
            fontSize: 12.sp,
            fontWeight: FontWeight.w500),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.payments_outlined, color: Colors.white, size: 14.sp),
              SizedBox(width: 4.w),
              CommonText(
                text: 'Reinstatement fee',
                fontSize: 10.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
        SizedBox(height: 12.h),
        CommonText(
            text: 'Last Payment',
            fontSize: 11.sp,
            color: AppColors.textSecondaryColor),
        CommonText(
            text:
                '${widget.lastPaymentAmount ?? "N/A"} - on ${widget.lastPaymentDate ?? "N/A"}',
            fontSize: 11.sp,
            fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget _buildActiveInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.campaign_outlined, color: Colors.red, size: 24.sp),
        SizedBox(height: 4.h),
        CommonText(
          text: widget.activeWarning ??
              'To enjoy your full community benefits, please settle any pending dues. Unpaid dues may restrict access to certain features.',
          fontSize: 12.sp,
          color: AppColors.red,
          fontWeight: FontWeight.w400,
          maxLines: 5,
        ),
        SizedBox(height: 5.h),
        CommonText(
            text: 'Last Payment',
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: AppColors.textSecondaryColor),
        SizedBox(height: 3.h),
        CommonText(
            text:
                '${widget.lastPaymentAmount ?? "N/A"} - on ${widget.lastPaymentDate ?? "N/A"}',
            fontSize: 11.sp,
            fontWeight: FontWeight.w500),
      ],
    );
  }

  Widget _buildMembershipPopup(double width, double arrowX) {
    return Material(
      color: Colors.transparent,
      child: CustomPaint(
        painter: TooltipPainter(arrowX: arrowX),
        child: Container(
          width: width,
          padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Suspension Policy",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "Suspended members lose access to all benefits until reactivated.",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFFEF4444),
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                "When Suspended",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              _buildPopupItem("No access to member benefits"),
              SizedBox(height: 10.h),
              _buildPopupItem("Features and privileges will be disabled"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPopupItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.remove_circle_outline,
          color: const Color(0xFFEF4444),
          size: 18.sp,
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black.withValues(alpha: 0.8),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class TooltipPainter extends CustomPainter {
  final double arrowX;

  TooltipPainter({required this.arrowX});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFFFFBEB)
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = const Color(0xFFF59E0B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    const double arrowWidth = 18.0;
    const double arrowHeight = 12.0;
    const double borderRadius = 12.0;

    final Path path = Path();
    path.moveTo(borderRadius, arrowHeight);

    // Arrow pointing to info icon center
    path.lineTo(arrowX - arrowWidth / 2, arrowHeight);
    path.lineTo(arrowX, 0);
    path.lineTo(arrowX + arrowWidth / 2, arrowHeight);

    path.lineTo(size.width - borderRadius, arrowHeight);
    path.quadraticBezierTo(
        size.width, arrowHeight, size.width, arrowHeight + borderRadius);
    path.lineTo(size.width, size.height - borderRadius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - borderRadius, size.height);
    path.lineTo(borderRadius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - borderRadius);
    path.lineTo(0, arrowHeight + borderRadius);
    path.quadraticBezierTo(0, arrowHeight, borderRadius, arrowHeight);
    path.close();

    // Shadow
    canvas.drawShadow(path.shift(const Offset(0, 4)),
        Colors.black.withValues(alpha: 0.1), 8, true);

    // Fill and Stroke
    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant TooltipPainter oldDelegate) =>
      oldDelegate.arrowX != arrowX;
}
