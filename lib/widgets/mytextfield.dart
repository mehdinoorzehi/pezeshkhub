// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

import '../controllers/constant.dart';

//! ویجت تکست فیلد اختصاصی

class MyTextFied extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final title;
  final TextDirection textDirection;
  final double? width;
  final TextInputType textInputType;
  final Container container;
  final FormFieldValidator validator;
  final TextEditingController? texteditingcontroller;
  final String? hintText;
  final double cursor_height;
  final double? rightMargin;
  final double leftMargin;
  final double font_title;
  final double font_size_error;
  final double height_error;
  final double border_radius;
  final double font_textfeild;
  final int? maxLength;
  final Color titleColor;
  final bool? enabled;
  final Function(String)? onChange;

  const MyTextFied({
    super.key,
    required this.width,
    required this.font_title,
    required this.border_radius,
    required this.height_error,
    required this.font_size_error,
    required this.font_textfeild,
    required this.title,
    required this.cursor_height,
    required this.textInputType,
    required this.textDirection,
    required this.container,
    this.texteditingcontroller,
    required this.validator,
    this.hintText,
    this.rightMargin = 0,
    required this.leftMargin,
    this.maxLength,
    required this.titleColor,
    this.enabled,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            container,
            Container(
              margin: EdgeInsets.only(
                top: 25.0,
                left: leftMargin,
                right: rightMargin!,
                // bottom: 3.0,
              ),
              child: Text(
                title,
                style: TextStyle(
                  color: titleColor,
                  fontSize: font_title,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 50,
          width: width,
          child: TextFormField(
            autocorrect: true,
            style: TextStyle(
              fontSize: font_textfeild,
              fontFamily: 'iransans',
            ),
            controller: texteditingcontroller,
            enabled: enabled,
            keyboardType: textInputType,
            validator: validator,
            textDirection: textDirection,
            textInputAction: TextInputAction.next,
            cursorColor: Colors.black,
            maxLength: maxLength,
            cursorHeight: cursor_height,
            onChanged: (value) {
              if (onChange != null) {
                onChange!(value);
              }
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintTextDirection: TextDirection.rtl,
              hintStyle: const TextStyle(fontSize: 15.0, height: 4.5),
              errorStyle: TextStyle(
                  fontSize: font_size_error,
                  fontWeight: FontWeight.bold,
                  height: height_error),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              counter: const SizedBox(),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(border_radius)),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: KLightPurple, width: 2.5),
                borderRadius: BorderRadius.circular(border_radius),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(border_radius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
