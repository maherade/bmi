import 'dart:math';

import 'package:bmi/presentation/screens/home_screen/home_screen.dart';
import 'package:bmi/styles/colors/colors.dart';
import 'package:bmi/utiles/local/cash_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/firebase_errors.dart';
import '../data/models/analysis_model/analysis_model.dart';
import '../data/models/user_model/user_model.dart';
import '../presentation/screens/analysis_screen/analysis_screen.dart';
import '../presentation/widgets/custom_toast.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);

  int currentIndex = 0;

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  List<Widget> screensLayout = [
    const HomeScreen(),
    const AnalysisScreen(),
  ];

  List<String> titlesLayout = [
    'Home',
    'Analysis',
  ];

  bool isMale = true;
  int height = 120;
  int weight = 40;
  int age = 20;
  double result = 0;
  String stResult = '';

  // Gender
  changeGender() {
    isMale = !isMale;
    emit(ChangeGenderStateSuccess());
  }

  // Age
  increaseAge() {
    age++;
    emit(ChangeAgeStateSuccess());
  }

  decreaseAge() {
    age--;
    emit(ChangeAgeStateSuccess());
  }

  // Weight
  increaseWeight() {
    weight++;
    emit(ChangeAgeStateSuccess());
  }

  decreaseWeight() {
    weight--;
    emit(ChangeAgeStateSuccess());
  }

  // Calculate BMI
  double calculateBMI() {
    result = weight / pow(height / 100, 2);
    debugPrint("${result.round()}");
    emit(CalculateBMIStateSuccess());
    return result;
  }

  String getBMIResult() {
    result = calculateBMI();
    if (result >= 30 && result <= 34.9) {
      emit(ChangeResultStringStateSuccess());
      print(stResult);
      return stResult = 'Obese';
    } else if (result >= 25 && result <= 29.9) {
      emit(ChangeResultStringStateSuccess());
      print(stResult);
      return stResult = 'Overweight';
    } else if (result >= 18.5 && result <= 24.9) {
      emit(ChangeResultStringStateSuccess());
      print(stResult);
      return stResult = 'Normal';
    } else {
      emit(ChangeResultStringStateSuccess());
      print(stResult);
      return stResult = 'Underweight';
    }
  }

  // Height
  changeHeight(int value) {
    height = value;
    print(height);
    emit(ChangeHeightStateSuccess());
  }

  void createAccountWithFirebaseAuth(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      emit(SignUpLoadingState());
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel user = UserModel(
        id: credential.user?.uid ?? "",
        userName: name,
        email: email,
      );
      await addUserToFireStore(user).then((value) {
        getUser();
        emit(SignUpSuccessState());
        CashHelper.saveData(key: 'isUid', value: credential.user?.uid);
        customToast(
          title: 'Account Created Successfully',
          color: Colors.blue,
        );
        print("--------------Account Created");
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrors.weakPassword) {
      } else if (e.code == FirebaseErrors.emailInUse) {
        emit(SignUpErrorState(e.toString()));
        customToast(
          title: 'This account already exists',
          color: Colors.red,
        );
        print("--------------Failed To Create Account");
      }
    }
  }

  Future<void> loginWithFirebaseAuth(
      {required String email, required String password}) async {
    try {
      emit(LoginLoadingState());
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel? user = await readUserFromFireStore(credential.user?.uid ?? "");
      if (user == null) {
        return customToast(
            title: '''This account doesn't exists''',
            color: Colors.red.shade700);
      }
      if (user != null) {
        CashHelper.saveData(key: 'isUid', value: credential.user?.uid);
        emit(LoginSuccessState());
        await getUser();
        print(CashHelper.getData(key: 'isUid'));
        print("-----------Login Successfully");
        return;
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginErrorState(e.toString()));
      print("-----------Login Failed");

      customToast(title: 'Invalid email or password', color: Colors.red);
    } catch (e) {
      customToast(title: 'Something went wrong $e', color: Colors.red);
    }
  }

  Future<void> saveUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String id,
  }) async {
    emit(SaveUserLoadingState());

    UserModel userModel = UserModel(
      userName: name,
      email: email,
      id: id,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.id)
        .set(userModel.toJson())
        .then((value) {
      debugPrint('Save User Success');
      emit(SaveUserSuccessState());
    }).catchError((error) {
      debugPrint('Error in userRegister is ${error.toString()}');
      emit(SaveUserErrorState());
    });
  }

  UserModel? userModel;

  Future<void> getUser() async {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc('${CashHelper.getData(key: 'isUid')}')
        .get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      print(userModel!.userName);
      print('here');
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error);
      emit(GetUserErrorState());
    });
  }

// User Reference

  CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.COLLECTION_NAME)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Future<void> addUserToFireStore(UserModel userModel) {
    return getUsersCollection().doc(userModel.id).set(userModel);
  }

  Future<UserModel?> readUserFromFireStore(String id) async {
    DocumentSnapshot<UserModel> user = await getUsersCollection().doc(id).get();
    var myUser = user.data();
    return myUser;
  }

  // AnalysisModel? analysisModel;

  Future<void> addAnalysisToFireStore(
    int height,
    int weight,
    int age,
    String gender,
    double result,
    String stResult,
    String userId,
  ) async {
    emit(AddAnalysisLoadingState());
    await FirebaseFirestore.instance
        .collection('MyAnalysis')
        .doc('${CashHelper.getData(key: 'isUid')}')
        .collection('Analysis')
        .add({
      "height": height,
      "weight": weight,
      "age": age,
      "gender": gender,
      "result": result,
      "stResult": stResult,
      "userId": userId,
    }).then((value) {
      emit(AddAnalysisSuccessState());
      customToast(
          title: "Your analysis added successfully ", color: ColorsManager.greenBlue);
    }).catchError((error) {
      emit(AddAnalysisErrorState());
    });
  }

  CollectionReference<AnalysisModel> getAnalysisCollection() {
    return FirebaseFirestore.instance
        .collection(AnalysisModel.COLLECTION_NAME)
        .withConverter(
      fromFirestore: (snapshot, options) =>
          AnalysisModel.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }

  List<AnalysisModel> myAnalysisList = [];

  Future<void> getAnalysis() async {
    emit(GetAnalysisLoadingState());
    var analysisRef = getAnalysisCollection();
    var docRef = analysisRef.doc('${CashHelper.getData(key: 'isUid')}');
     docRef.collection('Analysis')
        .get()
        .then((value) {
      debugPrint("${value.docs}");
      debugPrint(CashHelper.getData(key: "isUid"));

      for (var element in value.docs) {
        myAnalysisList.add(AnalysisModel.fromJson(element.data()));
      }
      debugPrint('Length of analysis ${myAnalysisList.length}');
      debugPrint('analysis Get Successfully');
      emit(GetAnalysisSuccessState());
    }).catchError((error) {
      debugPrint('Error in analysis is ${error.toString()}');
      emit(GetAnalysisErrorState());
    });
  }
}
