import 'package:safe_device/safe_device.dart';
import 'package:swypex_currency/core/models/security_issue.dart';

class SecurityUtils {
  static Future<List<SecurityIssue>> checkDeviceSecurity() async {
    List<SecurityIssue> issues = [];

    bool isJailBroken = await SafeDevice.isJailBroken;
    bool isRealDevice = await SafeDevice.isRealDevice;
    bool isMockLocation = await SafeDevice.isMockLocation;
    bool isDevelopmentMode = await SafeDevice.isDevelopmentModeEnable;
    bool hasMaliciousApps = await SafeDevice.isSafeDevice == false;

    if (!isRealDevice) {
      issues.add(SecurityIssue(
        title: "Emulator Detected",
        message:
            "This device is running on an emulator. The app cannot run for security reasons.",
      ));
    }

    if (isJailBroken) {
      issues.add(SecurityIssue(
        title: "Root/Jailbreak Detected",
        message:
            "This device is rooted or jailbroken, making it vulnerable. The app cannot run.",
      ));
    }

    if (isMockLocation) {
      issues.add(SecurityIssue(
        title: "Mock Location Detected",
        message: "Mock location is enabled. Disable it to use the app.",
      ));
    }

    if (isDevelopmentMode) {
      issues.add(SecurityIssue(
        title: "Developer Mode Enabled",
        message: "Developer mode is enabled. Disable it to proceed.",
      ));
    }

    if (hasMaliciousApps) {
      issues.add(SecurityIssue(
        title: "Malicious App Detected",
        message: "A suspicious app is installed. Remove it to use the app.",
      ));
    }

    return issues; // سيتم إرجاع قائمة بالمشاكل، وإن لم تكن هناك مشاكل ستعود فارغة
  }
}
