import 'package:bmi/business_logic/app_cubit.dart';
import 'package:bmi/business_logic/app_state.dart';
import 'package:bmi/data/models/analysis_model/analysis_model.dart';
import 'package:bmi/styles/colors/colors.dart';
import 'package:bmi/utiles/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<dynamic> resultDialog({
  required BuildContext context,
  required String title,
  required String message,
}) {
  return showDialog(
    useSafeArea: true,
    context: context,
    builder: (context) {
      var cubit = AppCubit.get(context);
      return BlocConsumer<AppCubit, AppState>(
  listener: (context, state) {},
  builder: (context, state) {
    return AlertDialog(
        backgroundColor: ColorsManager.greenBlue,
        scrollable: true,
        titlePadding: EdgeInsets.zero,
        title: Align(
          alignment: Alignment.topLeft,
          child: CloseButton(
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              height: MediaQuery.sizeOf(context).height * 0.2,
              width: MediaQuery.sizeOf(context).width * 0.3,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Center(
                child: Text(title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.greenBlue,
                    )),
              ),
            ),
            Text(message,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                )),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
           state is AddAnalysisLoadingState?const Center(child: CircularProgressIndicator(
             color: Colors.white,
           )): ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () {
                AppCubit.get(context).addAnalysisToFireStore(
                  cubit.height.toInt(),
                  cubit.weight,
                  cubit.age,
                  CashHelper.getData(key: "gender")??"Male",
                  cubit.result,
                  cubit.stResult,
                  CashHelper.getData(key: "isUid"),
                ).then((value) {
                  cubit.getAnalysis();
                  Navigator.pop(context);
                });
              },
              child: const Text(
                'Save Reading',
                style: TextStyle(
                    color: ColorsManager.greenBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      );
  },
);
    },
  );
}
