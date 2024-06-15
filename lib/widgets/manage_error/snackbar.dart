// ignore_for_file: non_constant_identifier_names

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class MySnackBar {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static Future<void> playSound() async {
    await _audioPlayer.play(AssetSource('sounds/bing.mp3'));
  }

  static void showCustomSnackBar({
    required String title,
    required String message,
    required Color Iconcolor,
    Duration? duration,
  }) {
    Get.snackbar(
      title,
      message,
      titleText: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textDirection: TextDirection.rtl,
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 13.sp, color: Colors.white),
        textDirection: TextDirection.rtl,
      ),
      icon: Icon(
        size: 10.0.w,
        Icons.error_outline,
        color: Iconcolor,
      ),
      duration: duration ?? const Duration(seconds: 2),
    );
    Future.delayed(const Duration(milliseconds: 10));
    playSound();
  }
}
