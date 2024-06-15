// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, avoid_print, avoid_unnecessary_containers, empty_catches

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../api/chech_mobile_api.dart';
import '../controllers/constant.dart';
import '../widgets/background_widget.dart';
import '../widgets/blur_container_widget.dart';
import '../widgets/button_widget.dart';
import '../controllers/text_editing_controllers.dart';
import '../controllers/validators.dart';
import '../widgets/mytextfield.dart';

// ignore: must_be_immutable
class CheckMobilePage extends StatelessWidget {
  const CheckMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
    //

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: BackgrounPicturedWidget(
        child: //! کانتینر بلوری
            Center(
          child: SingleChildScrollView(
            child: MyBlurContainerWidget(
              title: 'بررسی شماره موبایل',
              width: 89.w,
              height: 32.h,
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      //
                      //
                      //

                      //! فیلد شماره موبایل
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
                          hintText: 'مثال: 9123456789',
                          maxLength: 10,
                          texteditingcontroller: phonnumberController,
                          validator: (value) => phoneValidator(value),
                          title: 'شماره موبایل',
                          textDirection: TextDirection.ltr,
                          textInputType: TextInputType.number,
                          container: Container(),
                          onChange: (value) {
                            _formKey1.currentState!.validate();
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      //! دکمه بررسی
                      MyButtonWidget(
                        font_button: 13.sp,
                        cercular_button: 3.w,
                        height_button: 6.h,
                        width_button: 36.w,
                        textColor: Colors.white,
                        backgroundColor: KLightPurple,
                        text: 'تایید',
                        OnPressed: () async {
                          if (_formKey1.currentState!.validate()) {
                            await checkMobileApi();
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
      ),
    );
  }
}
