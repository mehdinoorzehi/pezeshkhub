import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../api/register_check_mobile_api.dart';
import '../controllers/constant.dart';
import '../controllers/text_editing_controllers.dart';
import '../controllers/validators.dart';
import '../widgets/background_widget.dart';
import '../widgets/blur_container_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/mytextfield.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
    final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
    final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();

    return Scaffold(
      body: BackgrounPicturedWidget(
        child: //! کانتینر بلوری
            Center(
          child: SingleChildScrollView(
            child: MyBlurContainerWidget(
              title: 'ثبت نام',
              width: 89.w,
              height: 60.h,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //
                    //
                    //
                    //! فیلد شماره موبایل
                    Form(
                      key: _formKey3,
                      child: MyTextFied(
                        width: 76.w,
                        border_radius: 2.5.w,
                        height_error: 0.01.h,
                        font_size_error: 9.sp,
                        cursor_height: 3.h,
                        font_title: 10.5.sp,
                        font_textfeild: 14.sp,
                        leftMargin: 5.w,
                        rightMargin: 7.w,
                        titleColor: Colors.white,
                        hintText: 'مثال: 9123456789',
                        maxLength: 10,
                        texteditingcontroller: registerPhonNumberController,
                        validator: (value) => phoneValidator(value),
                        title: 'شماره موبایل',
                        textDirection: TextDirection.ltr,
                        textInputType: TextInputType.number,
                        container: Container(),
                        onChange: (value) {
                          _formKey3.currentState!.validate();
                        },
                      ),
                    ),

                    //! فیلد نام کاربری
                    Form(
                      key: _formKey1,
                      child: MyTextFied(
                        width: 76.w,
                        border_radius: 2.5.w,
                        height_error: 0.01.h,
                        font_size_error: 9.sp,
                        cursor_height: 3.h,
                        font_title: 10.5.sp,
                        font_textfeild: 14.sp,
                        leftMargin: 5.w,
                        rightMargin: 7.w,
                        titleColor: Colors.white,
                        texteditingcontroller: userNameController,
                        validator: (value) => usernameValidator(value),
                        title: 'نام کاربری',
                        textDirection: TextDirection.ltr,
                        textInputType: TextInputType.text,
                        container: Container(),
                        onChange: (value) {
                          _formKey1.currentState!.validate();
                        },
                      ),
                    ),
                    //! فیلد رمز عبور
                    Form(
                      key: _formKey2,
                      child: MyTextFied(
                        width: 76.w,
                        border_radius: 2.5.w,
                        height_error: 0.01.h,
                        font_size_error: 9.sp,
                        cursor_height: 3.h,
                        font_title: 10.5.sp,
                        font_textfeild: 14.sp,
                        leftMargin: 5.w,
                        rightMargin: 7.w,
                        titleColor: Colors.white,
                        texteditingcontroller: passwordController,
                        validator: (value) => validatePassword(value),
                        title: 'رمز عبور',
                        textDirection: TextDirection.ltr,
                        textInputType: TextInputType.text,
                        container: Container(),
                        onChange: (value) {
                          _formKey2.currentState!.validate();
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    //! دکمه ثبت نام
                    MyButtonWidget(
                      font_button: 13.sp,
                      cercular_button: 3.w,
                      height_button: 6.h,
                      width_button: 36.w,
                      textColor: Colors.white,
                      backgroundColor: KLightPurple,
                      text: 'ثبت نام',
                      OnPressed: () async {
                        if (_formKey1.currentState!.validate() &&
                            _formKey2.currentState!.validate() &&
                            _formKey3.currentState!.validate()) {
                          await registerCheckMobileApi();
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
