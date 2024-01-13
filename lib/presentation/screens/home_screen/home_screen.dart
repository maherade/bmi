import 'dart:math';

import 'package:bmi/business_logic/app_cubit.dart';
import 'package:bmi/business_logic/app_state.dart';
import 'package:bmi/styles/colors/colors.dart';
import 'package:bmi/utiles/local/cash_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/result_dialog.dart';
import '../login_screen/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('BMI Calculator'),
              actions: [
                const Text("Logout", style: TextStyle(color: Colors.white, fontSize: 15),),
                IconButton(onPressed: () {
                  FirebaseAuth.instance.signOut().then((value){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  });
                }, icon: const Icon(Icons.logout_outlined,
                ),),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              cubit.changeGender();
                              CashHelper.saveData(key: "gender", value: "Male");
                              print(CashHelper.getData(key: 'gender'));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(colors: [
                                    cubit.isMale == true
                                        ? Colors.blue
                                        : ColorsManager.greenBlue,
                                    cubit.isMale == true
                                        ? Colors.blue
                                        : ColorsManager.greenBlue,
                                  ])),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: const AssetImage(
                                      'assets/images/boy.png',
                                    ),
                                    height: MediaQuery.sizeOf(context).height *
                                        0.1,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.33,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.02,
                                  ),
                                  const Text(
                                    'Male',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.05,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              cubit.changeGender();
                              CashHelper.saveData(key: "gender", value: "Female");
                              print(CashHelper.getData(key: 'gender'));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(colors: [
                                    cubit.isMale == true
                                        ? ColorsManager.greenBlue
                                        : Colors.red,
                                    cubit.isMale == true
                                        ? ColorsManager.lightBlack
                                        : Colors.red,
                                  ])),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                    image: const AssetImage(
                                      'assets/images/girl.png',
                                    ),
                                    height: MediaQuery.sizeOf(context).height *
                                        0.1,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.33,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.02,
                                  ),
                                  const Text(
                                    'Female',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(colors: [
                          ColorsManager.greenBlue,
                          ColorsManager.lightBlack,
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Height',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '${cubit.height.round()}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.02,
                            ),
                            const Text(
                              'Cm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        Slider(
                            max: 270.0,
                            min: 50.0,
                            inactiveColor: ColorsManager.lightBlack,
                            activeColor: Colors.white,
                            value: cubit.height.toDouble(),
                            onChanged: (value) {
                              cubit.changeHeight(value.toInt());
                              CashHelper.saveData(key: 'height', value: value);
                            }),
                      ],
                    ),
                  ),
                )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(colors: [
                                  ColorsManager.greenBlue,
                                  ColorsManager.lightBlack,
                                ])),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Age',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${cubit.age}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FloatingActionButton(
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          cubit.decreaseAge();
                                          CashHelper.saveData(key: "age", value: cubit.age);
                                        },
                                        heroTag: 'age-',
                                        mini: true,
                                        child: const Icon(Icons.remove),
                                      ),
                                      FloatingActionButton(
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          cubit.increaseAge();
                                          CashHelper.saveData(key: "age", value: cubit.age);
                                        },
                                        heroTag: 'age+',
                                        mini: true,
                                        child: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.05,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(colors: [
                                  ColorsManager.greenBlue,
                                  ColorsManager.lightBlack,
                                ])),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Weight',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${cubit.weight}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FloatingActionButton(
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          cubit.decreaseWeight();
                                          CashHelper.saveData(key: "weight", value: cubit.weight);
                                        },
                                        heroTag: 'weight-',
                                        mini: true,
                                        child: const Icon(Icons.remove),
                                      ),
                                      FloatingActionButton(
                                        backgroundColor: Colors.white,
                                        onPressed: () {
                                          cubit.increaseWeight();
                                          CashHelper.saveData(key: "weight", value: cubit.weight);
                                        },
                                        heroTag: 'weight+',
                                        mini: true,
                                        child: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          ColorsManager.greenBlue,
                        ),
                      ),
                      onPressed: () {
                        cubit.calculateBMI();
                        cubit.getBMIResult();
                        resultDialog(
                            context: context,
                            message: cubit.stResult,
                            title: cubit.result.round().toString());
                      },
                      child: const Text(
                        'Calculate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
