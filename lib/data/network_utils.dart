import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager/data/auth_utils.dart';

import '/main.dart';
import '/ui/screens/login_screen.dart';

class NetworkUtils {
  /// get request
  static Future<dynamic> getMethod({
    required String url,
    VoidCallback? onUnAuthorized,
  }) async {
    try {
      final http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthUtils.token ?? ''
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorized != null) {
          onUnAuthorized();
        } else {
          moveToLogin();
        }
      } else {
        log('Something went wrong');
      }
    } catch (e) {
      log('Error: $e', stackTrace: StackTrace.current);
    }
  }

  /// post request
  static Future<dynamic> postMethod({
    required String url,
    required Map<String, String> body,
    VoidCallback? onUnAuthorized,
    String? token,
  }) async {
    try {
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'token': AuthUtils.token ?? ''
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        if (onUnAuthorized != null) {
          onUnAuthorized();
        } else {
          moveToLogin();
        }
      } else {
        log('Something went wrong');
      }
    } catch (e) {
      log('error: $e', stackTrace: StackTrace.current);
    }
  }
}

//
moveToLogin() async {
  //clear cache
  await AuthUtils.clearData();

  //
  Navigator.pushAndRemoveUntil(
      TaskManager.navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false);
}
