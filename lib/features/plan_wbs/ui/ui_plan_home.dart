import 'package:flutter/material.dart';
import 'package:wbsessential/constants.dart';
import 'package:wbsessential/controller/new_wbs_data.dart';
import 'package:wbsessential/features/plan_new_wbs/bloc/plan_new_wbs_bloc.dart';
import 'package:wbsessential/features/plan_new_wbs/ui/ui_plan_new_wbs.dart';
import 'package:wbsessential/features/plan_wbs/ui/ui_plan_wbs.dart';
import 'package:wbsessential/screens/components/responsive.dart';

class PlanWBSHomeScreen extends StatefulWidget {
  const PlanWBSHomeScreen({super.key});

  @override
  State<PlanWBSHomeScreen> createState() => _PlanWBSHomeScreenState();
}

class _PlanWBSHomeScreenState extends State<PlanWBSHomeScreen> {
  final PlanNewWbsBloc planNewWbsBloc = PlanNewWbsBloc();

  @override
  void initState() {
    planNewWbsBloc.add(WbsNewInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveWidget.isSmallScreen(context)?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: PlanWbsTab(planNewWbsBloc : planNewWbsBloc),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding),),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: PlanNewWbsTab(planNewWbsBloc: planNewWbsBloc),
            ),
          ],
        )
        :Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Expanded(
                  // It takes 5/6 part of the screen
                  flex: 5,
                  child: PlanWbsTab(planNewWbsBloc : planNewWbsBloc),
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: defaultPadding),),
                Expanded(
                  // It takes 5/6 part of the screen
                  flex: 5,
                  child: PlanNewWbsTab(planNewWbsBloc: planNewWbsBloc),
                ),
              ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          planNewWbsBloc.add(WbsNewProjectSaveButtonClickedEvent(
              wbsSubSubDataModelList: wbsTempSubSubDataModel));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.save),
      ),
    );
  }
}
