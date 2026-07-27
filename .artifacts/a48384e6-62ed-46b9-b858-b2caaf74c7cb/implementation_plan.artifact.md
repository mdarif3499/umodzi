# Implementation Plan - Fix OTP Resend and Screen Duplicate

Address the issue where the identity (email/phone) might be empty during resend, and clean up the duplicate code in the OTP screen.

## Proposed Changes

### Features - Auth - OTP

#### [MODIFY] [otp_controller.dart](file:///C:/Users/mdyou/StudioProjects/umodzi/lib/features/auth/sign_in/controller/otp_controller.dart)
- Change `identity` and `type` to `RxString` to ensure reactivity and better state persistence.
- Update `onInit` to handle `Get.arguments` more robustly (handle `null` or different `Map` types).
- Fix `startTimer` to consistently use 90 seconds.
- Add a safety check in `resendOtp` to verify `identity` is not empty before making the API call.
- Use `trim()` on `type` and `identity` to avoid whitespace issues.

#### [MODIFY] [otp_screen.dart](file:///C:/Users/mdyou/StudioProjects/umodzi/lib/features/auth/sign_in/screen/otp_screen.dart)
- Remove the duplicate `_showSuccessDialog` method at the end of the file.
- Update UI references to `controller.identity.value` and `controller.type.value`.

## Verification Plan

### Manual Verification
1. Perform registration and proceed to the OTP screen.
2. Verify the email is displayed correctly on the screen.
3. Wait for the timer to expire.
4. Click "Resend" and verify that the request is sent with the correct email/phone key and value.
5. Check if the "Email or phone is required" error still occurs.
