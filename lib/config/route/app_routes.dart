import 'package:get/get.dart';
import '../../features/chat/screen/chat_screen.dart';
import '../../features/event/screen/event_details_screen.dart';
import '../../features/home/screen/add_dependent_screen.dart';
import '../../features/home/screen/all_active_event_screen.dart';
import '../../features/home/screen/due_details_screen.dart';
import '../../features/home/screen/my_family_screen.dart';
import '../../features/home/screen/status_activity_screen.dart';
import '../../features/notification/screen/notification_screen.dart';
import '../../features/payment/screen/pay_pending_details_screen.dart';
import '../../features/payment/screen/payment_history_details_screen.dart';
import '../../features/payment/screen/payment_history_screen.dart';
import '../../splash/mmu_bylaws_screen.dart';
import '../../splash/splash_screen.dart';
import '../../onboarding/onboarding_screen.dart';
import '../../landing/landing_screen.dart';
import '../../features/auth/sign_in/screen/sign_in_screen.dart';
import '../../features/auth/sign_up/screen/sign_up_screen.dart';
import '../../features/auth/sign_in/screen/otp_screen.dart';
import '../../features/auth/forgot_password/screen/forgot_password_screen.dart';
import '../../features/auth/forgot_password/screen/forgot_otp_screen.dart';
import '../../features/auth/forgot_password/screen/reset_password_screen.dart';
import '../../features/bottom_navbar/screen/navbar_screen.dart';
import '../../features/home/screen/payment_resolution_screen.dart';
import '../../features/profile/screen/profile_screen.dart';
import '../../features/profile/screen/report_event_screen.dart';
import '../../features/profile/screen/edit_profile_screen.dart';
import '../../features/profile/screen/edit_dependent_screen.dart';
import '../../features/profile/screen/change_password_screen.dart';
import '../../features/profile/screen/faq_screen.dart';
import '../../features/profile/screen/about_us_screen.dart';
import '../../features/profile/screen/terms_of_service_screen.dart';
import '../../features/profile/screen/privacy_policy_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String landing = '/landing';
  static const String navBarScreen = '/navBarScreen'; 
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgotPassword';
  static const String forgotOtp = '/forgotOtp';
  static const String resetPassword = '/resetPassword';
  static const String paymentResolution = '/paymentResolution';
  static const String dueDetailsScreen = '/dueDetailsScreen';
  static const String statusActivityScreen = '/statusActivityScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String addDependentScreen = '/addDependentScreen';
  static const String myFamilyScreen = '/myFamilyScreen';
  static const String eventDetailsScreen = '/eventDetailsScreen';
  static const String payPendingDetailsScreen = '/payPendingDetailsScreen';
  static const String paymentHistoryDetailsScreen = '/PaymentHistoryDetailsScreen';
  static const String paymentHistory = '/paymentHistory';
  static const String chatScreen = '/chatScreen';
  static const String profileScreen = '/profileScreen';
  static const String reportEvent = '/reportEvent';
  static const String editProfile = '/editProfile';
  static const String editDependent = '/editDependent';
  static const String changePassword = '/changePassword';
  static const String faq = '/faq';
  static const String aboutUs = '/aboutUs';
  static const String termsOfService = '/termsOfService';
  static const String privacyPolicy = '/privacyPolicy';
  static const String allActiveEventScreen = '/allActiveEventScreen';
  static const String mmuBylawsScreen = '/mmuBylawsScreen';

  static List<GetPage<String>> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () => const OnboardingScreen()),
    GetPage(name: landing, page: () => const LandingScreen()),
    GetPage(name: signIn, page: () => const SignInScreen()),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: navBarScreen, page: () => NavbarScreen()),
    GetPage(name: paymentResolution, page: () => const PaymentResolutionScreen()),
    GetPage(name: otp, page: () => const OtpScreen()),
    GetPage(name: forgotPassword, page: () => const ForgotPasswordScreen()),
    GetPage(name: forgotOtp, page: () => const ForgotOtpScreen()),
    GetPage(name: resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(name: dueDetailsScreen, page: () => const DueDetailsScreen()),
    GetPage(name: statusActivityScreen, page: () => const StatusActivityScreen()),
    GetPage(name: notificationScreen, page: () =>  NotificationScreen()),
    GetPage(name: addDependentScreen, page: () =>  AddDependentScreen()),
    GetPage(name: myFamilyScreen, page: () => const MyFamilyScreen()),
    GetPage(name: eventDetailsScreen, page: () =>  EventDetailsScreen()),
    GetPage(name: payPendingDetailsScreen, page: () =>  PayPendingDetailsScreen()),
    GetPage(name: paymentHistoryDetailsScreen, page: () =>  PaymentHistoryDetailsScreen()),
    GetPage(name: paymentHistory, page: () => const PaymentHistoryScreen()),
    GetPage(name: chatScreen, page: () =>  const ChatScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: reportEvent, page: () => const ReportEventScreen()),
    GetPage(name: editProfile, page: () => const EditProfileScreen()),
    GetPage(name: editDependent, page: () => const EditDependentScreen()),
    GetPage(name: changePassword, page: () => const ChangePasswordScreen()),
    GetPage(name: faq, page: () => const FAQScreen()),
    GetPage(name: aboutUs, page: () => const AboutUsScreen()),
    GetPage(name: termsOfService, page: () => const TermsOfServiceScreen()),
    GetPage(name: privacyPolicy, page: () => const PrivacyPolicyScreen()),
    GetPage(name: allActiveEventScreen, page: () => const AllActiveEventScreen()),
    GetPage(name: mmuBylawsScreen, page: () => const MmuBylawsScreen()),
  ];
}
