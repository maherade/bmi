import 'package:bmi/business_logic/app_cubit.dart';
import 'package:bmi/presentation/screens/home_screen/home_screen.dart';
import 'package:bmi/presentation/screens/register_screen/register_screen.dart';
import 'package:bmi/presentation/screens/splash_screen/splash_screen.dart';
import 'package:bmi/styles/theme_manager/theme_manager.dart';
import 'package:bmi/utiles/local/cash_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'business_logic/app_state.dart';
import 'constants/constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();

  uId = CashHelper.getData(key: 'isUid');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit()
            ..getUser()
            ..getAnalysis(),
        )
      ],
      child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: getApplicationTheme(context),
              home: const SplashScreen(),
            );
          }),
    );
  }
}
