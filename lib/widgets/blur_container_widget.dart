import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:sizer/sizer.dart';

class MyBlurContainerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final String title;
  const MyBlurContainerWidget({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer.clearGlass(
      borderColor: Colors.transparent,
      blur: 15,
      color: Colors.transparent,
      shadowColor: Colors.black,
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(
        5.w,
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            margin: EdgeInsets.only(
              top: 3.h,
              right: 6.w,
            ),
            child: Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.5.sp,
                  color: Colors.white),
            ),
          ),
          child
        ],
      ),
    );
  }
}
