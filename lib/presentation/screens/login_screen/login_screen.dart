import 'package:bmi/presentation/screens/home_screen/home_screen.dart';
import 'package:bmi/presentation/screens/register_screen/register_screen.dart';
import 'package:bmi/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/app_cubit.dart';
import '../../../business_logic/app_state.dart';
import '../../widgets/default_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
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
              title: const Text('Login'),
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
                        "assets/images/login.png",
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.8,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      DefaultTextField(
                        isPass: false,
                        prefixIcon: Icons.email_outlined,
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
                        prefixIcon: Icons.lock_outline,
                        hintText: "Enter your password",
                        controller: passwordController,
                        textInputType: TextInputType.text,
                        hintColor: Colors.white,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      state is LoginLoadingState
                          ? const Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.greenBlue,
                        ),
                      )
                          :  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.greenBlue),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.loginWithFirebaseAuth(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          },
                          child: const Text(
                            "Login",
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
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen(),
                                    ));
                              },
                              child: const Text("Sign Up",
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
      ),
    );
  }
}
