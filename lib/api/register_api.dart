import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pezeshkhub1/api/urls.dart';
import 'package:pezeshkhub1/pages/register_verify_otp_page.dart';
import 'package:pezeshkhub1/widgets/loading_widget.dart';

import '../controllers/secure_storage_controller.dart';
import '../widgets/manage_error/snackbar.dart';
import '../controllers/text_editing_controllers.dart';

final _dio = Dio();
//! تابع ثبت نام
Future<void> registerApi() async {
  try {
    // نمایش لودینگ
    Get.dialog(
        barrierDismissible: false,
        transitionDuration: const Duration(seconds: 0),
        const LoadingWidget());
    final response = await _dio.post(
      registerUrl,
      data: {
        'username': userNameController.text,
        'country_code': '98',
        'mobile_number': registerPhonNumberController.text,
        'password': passwordController.text,
      },
    );
    if (response.data['success'] == true && response.statusCode == 200) {
      //حذف لودینگ
      Get.back();
      await Get.find<SecureStorageController>()
          .storage
          .write(key: 'token', value: response.data['token']);

      Get.off(() => const RegisterVerifyOTPPage());
    } else {
      //حذف لودینگ
      Get.back();
      MySnackBar.showCustomSnackBar(
          title: 'خطا !',
          message: " مشکلی پیش آمده است. کد: ${response.statusCode.toString()}",
          Iconcolor: Colors.red);
    }
  } catch (e) {
    //حذف لودینگ
    Get.back();
    MySnackBar.showCustomSnackBar(
        title: 'خطا !',
        message:
            "لطفا اتصال اینترنت خود را چک کرده یا یک نام کاربری دیگری را وارد کنید",
        Iconcolor: Colors.red);
  }
}
