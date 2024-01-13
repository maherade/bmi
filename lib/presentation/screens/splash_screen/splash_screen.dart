import 'dart:async';

import 'package:bmi/business_logic/app_cubit.dart';
import 'package:bmi/business_logic/app_state.dart';
import 'package:bmi/presentation/screens/home_layout/home_layout.dart';
import 'package:bmi/presentation/screens/home_screen/home_screen.dart';
import 'package:bmi/presentation/screens/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      if (uId == null || uId == '') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeLayout()),
            (Route<dynamic> route) => false);
      }
      // else{
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
      //   const LoginScreen()
      //   ), (Route<dynamic> route) => false);
      //
      // }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Center(
          child: Image.asset(
            "assets/images/bmi.png",
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            fit: BoxFit.contain,
          ),
        ));
      },
    );
  }
}
