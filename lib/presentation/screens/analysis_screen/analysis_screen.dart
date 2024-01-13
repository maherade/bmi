import 'package:bmi/business_logic/app_cubit.dart';
import 'package:bmi/business_logic/app_state.dart';
import 'package:bmi/presentation/widgets/analysis_container.dart';
import 'package:bmi/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Results',
            ),
          ),
          body: cubit.myAnalysisList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(
                  color: ColorsManager.greenBlue,
                ))
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    itemCount: cubit.myAnalysisList.length,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(
                      20,
                      ),
                      ),
                        child: Slidable(
                          startActionPane: ActionPane(
                              extentRatio: .29,
                              motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (buildContext) {
                                },
                                backgroundColor: Colors.red,
                                label: 'Delete',
                                icon: Icons.delete,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(18),
                                  bottomLeft: Radius.circular(18),
                                ),
                              ),
                            ],
                          ),
                          child: AnalysisContainer(
                            height:
                                "${cubit.myAnalysisList[index].height!.toInt()}",
                            weight: "${cubit.myAnalysisList[index].weight}",
                            age: "${cubit.myAnalysisList[index].age}",
                            stResult: "${cubit.myAnalysisList[index].stResult}",
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.03,
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
