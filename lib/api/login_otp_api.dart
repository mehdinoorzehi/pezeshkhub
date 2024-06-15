import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pezeshkhub1/api/urls.dart';
import 'package:pezeshkhub1/widgets/loading_widget.dart';

import '../controllers/check_login_time.dart';
import '../controllers/secure_storage_controller.dart';
import '../widgets/manage_error/snackbar.dart';
import '../controllers/text_editing_controllers.dart';

final _dio = Dio();
//! تابع ورود با کد پیامکی
Future<void> loginOtpApi() async {
  try {
    // نمایش لودینگ
    Get.dialog(
        barrierDismissible: false,
        transitionDuration: const Duration(seconds: 0),
        const LoadingWidget());
    final response = await _dio.post(
      loginOtpUrl,
      data: {
        'country_code': '98',
        'mobile_number': phonnumberController.text,
        'otp': tempPassLoginController.text,
      },
    );

    //حذف لودینگ
    Get.back();
    if (response.statusCode == 200) {
      if (response.data['success'] == true) {
        await Get.find<SecureStorageController>()
            .storage
            .write(key: 'token', value: response.data['token']);

        login();
      } else {
        MySnackBar.showCustomSnackBar(
            title: 'خطا !',
            message:
                "مشکلی پیش آمده است. کد: ${response.statusCode.toString()}",
            Iconcolor: Colors.red);
      }
    } else {
      MySnackBar.showCustomSnackBar(
          title: 'خطا !',
          message: "مشکلی پیش آمده است. کد: ${response.statusCode.toString()}",
          Iconcolor: Colors.red);
    }
  } catch (e) {
    //حذف لودینگ
    Get.back();
    MySnackBar.showCustomSnackBar(
        title: 'خطا !',
        message:
            "لطفا اتصال اینترنت خود را چک کرده یا کد پیامک شده را به درستی وارد کنید",
        Iconcolor: Colors.red);
  }
}
