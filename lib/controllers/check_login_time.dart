import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/home_page.dart';

//! تابع چک کردن لاگین بودن برای اینکه کاربر اگر دوباره وارد برنامه شد دوباره لاگین نکند

Future<bool> checkLoginTime() async {
  final prefs = await SharedPreferences.getInstance();
  final loginTime = prefs.getInt('loginTime');

  if (loginTime == null) {
    return false;
  }

  return true;
}

Future<void> login() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('loginTime', DateTime.now().millisecondsSinceEpoch);

  Get.offAll(HomePage());
}
