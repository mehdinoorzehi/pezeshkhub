import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/check_login_time.dart';
import '../controllers/secure_storage_controller.dart';
import '../pages/check_mobile_page.dart';
import '../widgets/loading_widget.dart';
import '../widgets/manage_error/snackbar.dart';
import '../controllers/text_editing_controllers.dart';
import 'urls.dart';

final _dio = Dio(BaseOptions(
  headers: {
    'Content-Type': 'application/json',
  },
));

//! تابع ورود با کد پیامکی بعد از ثبت نام
Future<void> registerOtpApi() async {
  try {
    // خواندن توکن از Secure Storage
    var token =
        await Get.find<SecureStorageController>().storage.read(key: 'token');

    // نمایش لودینگ
    Get.dialog(
      barrierDismissible: false,
      transitionDuration: const Duration(seconds: 0),
      const LoadingWidget(),
    );

    // افزودن توکن به هدر
    final response = await _dio.post(
      registerOtpUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // افزودن توکن به هدر
        },
      ),
      data: {
        'otp': tempPassRegisterController.text,
      },
    );

    // بررسی پاسخ
    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        // حذف لودینگ
        Get.back();
        login();
      } else if (response.statusCode == 401) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('loginTime'); // حذف زمان ورود
        await Future.delayed(const Duration(seconds: 1));
        try {
          await Get.offAll(() => const CheckMobilePage());
          // ignore: empty_catches
        } catch (e) {}
        throw Exception('Failed to load posts');
      } else {
        // برای حالت‌های غیرمنتظره
        MySnackBar.showCustomSnackBar(
          title: 'خطا !',
          message: "مشکلی پیش آمده است. کد: ${response.statusCode.toString()}",
          Iconcolor: Colors.red,
        );
      }
    } else {
      // حذف لودینگ
      Get.back();
      MySnackBar.showCustomSnackBar(
        title: 'خطا !',
        message: "مشکلی پیش آمده است. کد: ${response.statusCode.toString()}",
        Iconcolor: Colors.red,
      );
    }
  } catch (e) {
    // حذف لودینگ
    Get.back();
    MySnackBar.showCustomSnackBar(
      title: 'خطا !',
      message:
          "لطفا اتصال اینترنت خود را چک کرده یا کد پیامک شده را به درستی وارد کنید",
      Iconcolor: Colors.red,
    );
  }
}
