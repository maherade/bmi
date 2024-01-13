 import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/colors.dart';

ThemeData getApplicationTheme(BuildContext context) {
  return ThemeData(
//main colors
    primaryColor: ColorsManager.darkBlack,
    scaffoldBackgroundColor: ColorsManager.darkBlack,
    useMaterial3: true,
     // app bar theme
    appBarTheme: AppBarTheme(
        color: ColorsManager.greenBlue,

        titleTextStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
          color: Colors.white,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: ColorsManager.darkBlack,
          statusBarIconBrightness: Brightness.light,
        )),

    bottomNavigationBarTheme:  const BottomNavigationBarThemeData(
      type:  BottomNavigationBarType.fixed,
      backgroundColor: ColorsManager.darkBlack,
      selectedItemColor: ColorsManager.greenBlue,
      unselectedItemColor: Colors.grey,
    ),

  );
}
