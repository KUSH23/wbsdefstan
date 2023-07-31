import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbsessential/constants.dart';
import 'package:wbsessential/features/plan_new_wbs/bloc/plan_new_wbs_bloc.dart';
import 'package:wbsessential/models/sub_sub_wbs.dart';
import 'package:wbsessential/screens/main/main_screen.dart';

class PlanNewWbsTab extends StatefulWidget {
  const PlanNewWbsTab({super.key, required this.planNewWbsBloc});
  final PlanNewWbsBloc planNewWbsBloc;
  @override
  State<PlanNewWbsTab> createState() => _PlanNewWbsTabState();
}

class _PlanNewWbsTabState extends State<PlanNewWbsTab> {
  // final PlanNewWbsBloc planNewWbsBloc = PlanNewWbsBloc();

  @override
  void initState() {
    // TODO: implement initState
    widget.planNewWbsBloc.add(WbsNewInitialFetchEvent());
    super.initState();
  }

  Map<dynamic, List> groupItemsByCategory(List<WbsSubSubDataModel> items) {
    return groupBy(items, (item) => item.msgroup_name.mgroup_name.mgroup_name);
  }

  Map<dynamic, List> groupItemsBySubCategory(List<dynamic> items) {
    return groupBy(items, (item) => item.msgroup_name.msgroup_name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlanNewWbsBloc, PlanNewWbsState>(
      bloc: widget.planNewWbsBloc,
      listenWhen: (previous, current) => current is PlanNewWbsActionState,
      buildWhen: (previous, current) => current is !PlanNewWbsActionState,
      listener: (context, state) {
        if(state is PlanNewWbsAdditionSuccessState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added!")));
          Navigator.push(context, MaterialPageRoute(builder: (context)=> MainScreen()));
        } else if(state is PlanNewWbsAdditionErrorState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error!")));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case PlanNewWbsLoadingState:
            return Column(
              children: [
                Text(
                  "Loading...",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          case PlanNewSubSubWbsLoadedSuccessState:
            final successState = state as PlanNewSubSubWbsLoadedSuccessState;
            List<WbsSubSubDataModel> mainwbs = successState.subsubwbsList;
            mainwbs?.sort((a, b) => a.msgroup_name.mgroup_name.dserialid.compareTo(b.msgroup_name.mgroup_name.dserialid));
            Map<dynamic, List<dynamic>> groupedItems = groupItemsByCategory(mainwbs);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(defaultPadding),
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: ListView.builder(
                  itemCount: groupedItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    String category = groupedItems.keys.elementAt(index);
                    List itemsInCategory = groupedItems[category]!;
                    itemsInCategory?.sort((a, b) => a.msgroup_name.dserialid.compareTo(b.msgroup_name.dserialid));
                    // print(groupedItems);
                    Map<dynamic, List<dynamic>> groupedSubItems = groupItemsBySubCategory(itemsInCategory);
                    // Return a widget representing the category and its items
                    return Column(
                      children: [
                      Row(children: [Text(category,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))],),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: groupedSubItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          String subCategory = groupedSubItems.keys.elementAt(index);
                          List? subItems = groupedSubItems[subCategory];
                          subItems?.sort((a, b) => a.dserialid.compareTo(b.dserialid));
                          // Return a widget representing the item
                          return Column(
                            children: [
                              Row(children: [Text(subCategory,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))],),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                itemCount: subItems?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  WbsSubSubDataModel item = subItems?[index];
                                  // Return a widget representing the item
                                  return ListTile(
                                    title: Text(item.mssgroup_name, style: const TextStyle(fontSize: 14), ));
                                }, ),
                            ], );
                        }, ),
                      ], );
                    },
                  ),
              ),
            );
          case PlanNewWbsLoadingErrorState:
            return const Center(child: Text ('Error 1') );
          default:
            return  const Center(child: Text ('Error 2'));
        }
      },
    );
  }
}
