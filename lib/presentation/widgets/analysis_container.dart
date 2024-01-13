import 'package:flutter/material.dart';

import '../../styles/colors/colors.dart';

class AnalysisContainer extends StatelessWidget {
  String height;
  String weight;
  String age;
  String stResult;
    AnalysisContainer({ required this.height, required this.weight, required this.age, required this.stResult,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height * 0.14,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: const LinearGradient(
          colors: [
            ColorsManager.greenBlue,
            ColorsManager.lightBlack,
          ]
        )
      ) ,
      child:   Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Weight : $weight Kg",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,

              )
              ),
              Text("Height : $height Cm",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,

              )
              ),
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Age : $age y.o",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,

              )
              ),
              Text("Your BMI is $stResult",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold

              )
              ),
            ]
          ),
        ],
        
      )
    );
  }
}
