import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pezeshkhub1/api/urls.dart';
import 'package:pezeshkhub1/widgets/loading_widget.dart';
import '../widgets/manage_error/snackbar.dart';
import '../controllers/text_editing_controllers.dart';
import 'register_api.dart';

final _dio = Dio();

//! تابع چک کردن شماره موبایل که قبلا در دیتابیس ثبت نشده باشد
Future<void> registerCheckMobileApi() async {
  try {
    // نمایش لودینگ
    Get.dialog(
      barrierDismissible: false,
      transitionDuration: const Duration(seconds: 0),
      const LoadingWidget(),
    );

    // ارسال درخواست POST به سرور
    final response = await _dio.post(
      checkMobileUrl,
      data: {
        'country_code': '98',
        'mobile_number': registerPhonNumberController.text,
      },
    );

    // حذف لودینگ
    Get.back();

    if (response.statusCode == 200) {
      if (response.data['registered'] == false) {
        await registerApi();
      } else if (response.data['registered'] == true) {
        MySnackBar.showCustomSnackBar(
          title: 'خطا !',
          message: "این شماره قبلا در سامانه ثبت نام شده است",
          Iconcolor: Colors.red,
        );
      } else {
        // برای حالت‌های غیرمنتظره
        MySnackBar.showCustomSnackBar(
          title: 'خطا !',
          message: "مشکلی پیش آمده است. کد: ${response.statusCode.toString()}",
          Iconcolor: Colors.red,
        );
      }
    } else {
      // اگر وضعیت پاسخ غیر از 200 باشد
      MySnackBar.showCustomSnackBar(
        title: 'خطا !',
        message: "مشکلی پیش آمده است. کد: ${response.statusCode.toString()}",
        Iconcolor: Colors.red,
      );
    }
  } catch (e) {
    // مدیریت خطا در صورت بروز مشکل در درخواست
    Get.back();
    MySnackBar.showCustomSnackBar(
      title: 'خطا !',
      message:
          "در برقراری ارتباط با سرور مشکلی پیش آمده است. لطفا دوباره تلاش کنید",
      Iconcolor: Colors.red,
    );
  }
}
