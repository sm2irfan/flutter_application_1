import 'dart:developer' as developer;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

class PermissionUtils {
  // Request storage permission and handle accordingly
  static Future<bool> requestStoragePermission(BuildContext context) async {
    developer.log("Requesting storage permission...");

    PermissionStatus permissionStatus = await Permission.storage.request();
    developer.log("Permission status: ${permissionStatus.toString()}");

    if (permissionStatus.isGranted) {
      developer.log("Storage permission granted");
      return true;
    } else if (permissionStatus.isPermanentlyDenied) {
      developer.log("Storage permission permanently denied");
      showPermissionDialog(context);
      return false;
    } else {
      developer.log("Storage permission denied");
      return false;
    }
  }

  // Show dialog to guide user to app settings
  static void showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Storage Permission Required'),
          content: const Text('This app requires storage access to function properly. Please enable storage permission in the app settings.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                developer.log("Opening app settings...");
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
