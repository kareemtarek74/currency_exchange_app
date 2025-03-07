import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swypex_currency/core/security/security_issue_card.dart';
import 'package:swypex_currency/core/security/security_issue_model.dart';

class SecurityWarningScreen extends StatelessWidget {
  final List<SecurityIssue> securityIssues;

  const SecurityWarningScreen({super.key, required this.securityIssues});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "🚨 Security Alert!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Your device has security risks. Please review the details below:",
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                SecurityIssueCard(securityIssues: securityIssues),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _exitApp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 3,
                    ),
                    child: const Text(
                      "Exit App",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _exitApp() {
    SystemNavigator.pop();
  }
}
