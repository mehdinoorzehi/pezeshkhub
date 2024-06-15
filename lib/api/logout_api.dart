import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pezeshkhub1/pages/check_mobile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/secure_storage_controller.dart';
import '../widgets/loading_widget.dart';
import '../widgets/manage_error/snackbar.dart';
import 'urls.dart';

final _dio = Dio(BaseOptions(
  headers: {
    'Content-Type': 'application/json',
  },
));

Future<void> logOutApi() async {
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
    final response = await _dio.get(
      logOutUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token', // افزودن توکن به هدر
        },
      ),
    );

    // بررسی پاسخ
    if (response.statusCode == 200) {
      // حذف لودینگ
      Get.back();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('loginTime'); // حذف زمان ورود
      await Get.find<SecureStorageController>().storage.delete(key: 'token');
      await Get.offAll(() => const CheckMobilePage());
    } else {
      // حذف لودینگ
      Get.back();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('loginTime'); // حذف زمان ورود
      await Future.delayed(const Duration(seconds: 1));
      try {
        await Get.offAll(() => const CheckMobilePage());
        // ignore: empty_catches
      } catch (e) {}
    }
  } catch (e) {
    // حذف لودینگ
    Get.back();
    MySnackBar.showCustomSnackBar(
      title: 'خطا !',
      message:
          "در برقراری ارتباط با سرور مشکلی پیش آمده است. لطفا دوباره تلاش کنید",
      Iconcolor: Colors.red,
    );
  }
}
