import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pezeshkhub1/api/urls.dart';
import 'package:pezeshkhub1/pages/login_verify_otp_page.dart';
import 'package:pezeshkhub1/pages/register_page.dart';
import 'package:pezeshkhub1/widgets/loading_widget.dart';

import '../widgets/manage_error/snackbar.dart';
import '../controllers/text_editing_controllers.dart';

final _dio = Dio();
//! تابع بررسی شماره موبایل
Future<void> checkMobileApi() async {
  try {
    // نمایش لودینگ
    Get.dialog(
        barrierDismissible: false,
        transitionDuration: const Duration(seconds: 0),
        const LoadingWidget());
//! ارسال اطلاعات
    final response = await _dio.post(
      checkMobileUrl,
      data: {
        'country_code': '98',
        'mobile_number': phonnumberController.text,
      },
    );

    if (response.statusCode == 200) {
      if (response.data['registered'] == false) {
        //حذف لودینگ
        Get.back();
        Get.to(() => const RegisterPage());
      } else if (response.data['registered'] == true) {
        //حذف لودینگ
        Get.back();
        Get.to(() => const LoginVerifyOTPPage());
      } else {
        //! برای حالت‌های غیرمنتظره
        MySnackBar.showCustomSnackBar(
          title: 'خطا !',
          message: "مشکلی پیش آمده است. کد: ${response.statusCode.toString()}",
          Iconcolor: Colors.red,
        );
      }
    } else {
      //حذف لودینگ
      Get.back();
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
            "در برقراری ارتباط با سرور مشکلی پیش آمده است. لطفا دوباره تلاش کنید",
        Iconcolor: Colors.red);
  }
}
