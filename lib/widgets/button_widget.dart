// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../controllers/constant.dart';

class MyButtonWidget extends StatelessWidget {
  final Future<Null> Function()? OnPressed;
  final int? activeCode;
  final String? text;
  final EdgeInsetsGeometry? margin;
  final double height_button;
  final double width_button;
  final double cercular_button;
  final double font_button;

  final Color backgroundColor;
  final Color textColor;
  final Color disabledColor; // اضافه کردن ویژگی رنگ غیرفعال

  const MyButtonWidget(
      {super.key,
      this.activeCode,
      required this.height_button,
      required this.width_button,
      required this.OnPressed,
      required this.cercular_button,
      required this.font_button,
      this.text,
      this.margin,
      required this.backgroundColor,
      required this.textColor,
      this.disabledColor = Colors.black26}); // مقدار پیش‌فرض برای رنگ غیرفعال

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width_button,
      height: height_button,
      margin: margin,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cercular_button)),
          backgroundColor: backgroundColor,
          foregroundColor: KWhiteColore,
        ).copyWith(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return disabledColor; // رنگ دکمه هنگام غیرفعال بودن
              }
              return backgroundColor; // رنگ پیش‌فرض دکمه
            },
          ),
        ),
        onPressed: OnPressed,
        child: Text(
          text!,
          style: TextStyle(
              color: textColor,
              fontSize: font_button,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
