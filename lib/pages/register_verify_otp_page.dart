import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../api/register_otp_api.dart';
import '../controllers/constant.dart';
import '../controllers/text_editing_controllers.dart';
import '../controllers/validators.dart';
import '../widgets/background_widget.dart';
import '../widgets/blur_container_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/mytextfield.dart';

class RegisterVerifyOTPPage extends StatelessWidget {
  const RegisterVerifyOTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey1 = GlobalKey<FormState>();

    return Scaffold(
      body: BackgrounPicturedWidget(
        child: Center(
          child: SingleChildScrollView(
            child: MyBlurContainerWidget(
              title: 'کد ارسال شده توسط پیامک',
              width: 90.w,
              height: 32.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey1,
                      child: MyTextFied(
                        width: 76.w,
                        border_radius: 2.5.w,
                        height_error: 0.01.h,
                        font_size_error: 9.sp,
                        cursor_height: 3.h,
                        font_textfeild: 14.sp,
                        font_title: 10.5.sp,
                        leftMargin: 0,
                        rightMargin: 7.w,
                        titleColor: Colors.white,
                        maxLength: 4,
                        texteditingcontroller: tempPassRegisterController,
                        validator: (value) => validateTempPass(value),
                        title: 'رمز یکیار مصرف',
                        textDirection: TextDirection.ltr,
                        textInputType: TextInputType.number,
                        container: Container(),
                        onChange: (value) {
                          _formKey1.currentState!.validate();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyButtonWidget(
                      font_button: 13.sp,
                      cercular_button: 2.5.w,
                      height_button: 6.h,
                      width_button: 23.w,
                      textColor: Colors.white,
                      backgroundColor: KLightPurple,
                      text: "تایید",
                      OnPressed: () async {
                        if (_formKey1.currentState!.validate()) {
                          await registerOtpApi();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
