// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:sizer/sizer.dart';

import 'binding/bindings.dart';
import 'controllers/constant.dart';

import 'pages/splash_page.dart';

void main() {
  //! change status bar color
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  //
  //
  //
  //! lock auto rotation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          // home: const CheckMobilePage(),
          // home: RegisterPage(),
          // home: LoginVerifyOTPPage(),
          // home: RegisterVerifyOTPPage(),
          // home: HomePage(),
          home: const SplashScreen(),

          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.cupertinoDialog,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.black,
            fontFamily: 'vazir',
            inputDecorationTheme: const InputDecorationTheme(
                filled: true, fillColor: KWhiteColore),
          ),
          initialBinding: MyBindings(),
        );
      },
    );
  }
}
