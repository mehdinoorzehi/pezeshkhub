import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../api/logout_api.dart';
import '../controllers/constant.dart';

AppBar myAppbar1() {
  return AppBar(
    actions: [
      IconButton(
          onPressed: () async {
            await logOutApi();
          },
          icon: Image.asset(
            'assets/images/exit.png',
            height: 7.5.w,
          )),
      const Spacer(),
      SizedBox(
          height: 6.h,
          child: Icon(
            Icons.hub_outlined,
            size: 10.w,
            color: Colors.white,
          )),
      const Spacer(),
      Builder(
        builder: (context) => IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/menu.png',
              height: 7.5.w,
            )),
      ),
    ],
    backgroundColor: KLightGreyColore,
  );
}
