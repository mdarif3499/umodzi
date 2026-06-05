import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/log/app_utils.dart';
import '../../home/screen/home_screen.dart';


class StripeWebViewPage extends StatelessWidget {
  final String checkoutUrl;

  const StripeWebViewPage({super.key, required this.checkoutUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller:
              WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setNavigationDelegate(
                  NavigationDelegate(
                    onNavigationRequest: (request) {
                      return NavigationDecision.navigate;
                    },
                    onPageStarted: (url) {
                    },
                    onPageFinished: (url) {
                      if (url.contains("success")) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );

                        if (url.contains("payment/account")) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }

                        if (url.contains("failure")) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                        if (url.contains("cancel")) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }
                        Utils.successSnackBar("Payment successful");
                      } else if (url.contains("cancel")) {
                        Navigator.pop(context);
                        Utils.errorSnackBar("Cancel", "Payment cancelled");
                      }
                    },
                    onWebResourceError: (error) {},
                  ),
                )
                ..loadRequest(Uri.parse(checkoutUrl)),
        ),
      ),
    );
  }
}
