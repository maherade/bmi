import 'package:bmi/business_logic/app_cubit.dart';
import 'package:bmi/business_logic/app_state.dart';
import 'package:bmi/presentation/screens/home_screen/home_screen.dart';
import 'package:bmi/presentation/screens/login_screen/login_screen.dart';
import 'package:bmi/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/default_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is SignUpSuccessState) {
          emailController.clear();
          passwordController.clear();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorsManager.darkBlack,
            title: const Text('Sign Up'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      "assets/images/sign_up.png",
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.8,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    DefaultTextField(
                      isPass: false,
                      prefixIcon:Icons.person_outline ,
                      hintText: "Enter your name",
                      controller: nameController,
                      textInputType: TextInputType.text,
                      hintColor: Colors.white,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    DefaultTextField(
                      isPass: false,
                      prefixIcon:Icons.email_outlined ,
                      hintText: "Enter your e-mail address",
                      controller: emailController,
                      textInputType: TextInputType.text,
                      hintColor: Colors.white,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    DefaultTextField(
                      isPass: true,
                      prefixIcon:Icons.lock_outline ,
                      hintText: "Enter your password",
                      controller: passwordController,
                      textInputType: TextInputType.text,
                      hintColor: Colors.white,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    state is SignUpLoadingState
                        ? const Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.greenBlue,
                      ),
                    )
                        : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsManager.greenBlue),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.createAccountWithFirebaseAuth(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                context: context);
                          }
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>const  LoginScreen(),));
                            },
                            child: const Text("Sign In",
                                style: TextStyle(
                                  color: ColorsManager.lightGreen,
                                )))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
