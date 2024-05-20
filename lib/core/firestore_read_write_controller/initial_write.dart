// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:redqteam/auth/signup/controller/signup_controller.dart';

class InitialWrite {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

  static saveUser(User user, SignUpState state) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime?.millisecondsSinceEpoch,
        "build_number": buildNumber,
      });
    } else {
      Map<String, dynamic> userData = {
        "name": user.displayName ?? state.name.value,
        "email": user.email ?? state.email.value,
        "aadhar_number": state.aadhar.value,
        "last_login": user.metadata.lastSignInTime?.millisecondsSinceEpoch,
        "created_at": user.metadata.creationTime?.microsecondsSinceEpoch,
        "groups": [],
        "role": state.role,
        "build_number": buildNumber,
      };
      await userRef.set(userData);
    }
    await _saveDevice(user);
  }

  static _saveDevice(User user) async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    String deviceId = "unspecified${user.uid}";
    Map<String, dynamic> deviceData;
    if (Platform.isAndroid) {
      final deviceInfo = await deviceInfoPlugin.androidInfo;
      deviceId = deviceInfo.id;

      deviceData = {
        "os_version": deviceInfo.version.sdkInt.toString(),
        "platform": "android",
        "model": deviceInfo.model,
        "device": deviceInfo.device,
      };
    } else {
      final deviceInfo = await deviceInfoPlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor!;

      deviceData = {
        "os_version": deviceInfo..systemVersion,
        "platform": "IOS",
        "model": deviceInfo.model,
        "device": deviceInfo.name,
      };
    }
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    final deviceRef = _db
        .collection("users")
        .doc(user.uid)
        .collection("devices")
        .doc(deviceId);
    if ((await deviceRef.get()).exists) {
      await deviceRef.update({"updated_at": nowMs, "uninstalled": false});
    } else {
      await deviceRef.set({
        "created_at": nowMs,
        "updated_at": nowMs,
        "uninstalled": false,
        "id": deviceId,
        "device_info": deviceData,
      });
    }
  }
}
