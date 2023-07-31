import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbsessential/constants.dart';
import 'package:wbsessential/features/plan_new_wbs/bloc/plan_new_wbs_bloc.dart';
import 'package:wbsessential/features/plan_wbs/ui/wbs_tile_widget.dart';
import 'package:wbsessential/features/project_home/bloc/project_home_bloc.dart';
import 'package:wbsessential/models/new_project_wbs.dart';
import 'package:wbsessential/models/sub_sub_wbs.dart';
import 'package:wbsessential/models/sub_wbs.dart';

import '../../../models/project_items_wbs.dart';

class ViewProjectTab extends StatefulWidget {
  const ViewProjectTab({super.key, required this.projectHomeBloc,});
  final ProjectHomeBloc projectHomeBloc;

  @override
  State<ViewProjectTab> createState() => _ViewProjectTabState();
}

class _ViewProjectTabState extends State<ViewProjectTab> {

  @override
  void initState() {
    // TODO: implement initState
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
    return BlocConsumer<ProjectHomeBloc, ProjectHomeState>(
      bloc: widget.projectHomeBloc,
      listenWhen: (previous, current) => current is ProjectHomeActionState,
      buildWhen: (previous, current) => current is !ProjectHomeActionState,
      listener: (context, state) {
        // if(state is PostsAdditionState || state is PostsUpdateFormState || state is PostsTransactionFormState || state is PostsProductDataFormState){
        //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart(postsBloc: widget.postsBloc, homeBloc:widget.homeBloc)));
        // }
        // }else if(state is PostsAdditionErrorState){
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error!")));
        // }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case ProjectHomeLoadingState:
            return Scaffold(
              body: Column(
                children: [
                  Text(
                    "Loading...",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            );
          case ProjectHomeListLoadedSuccessState:
            final successState = state as ProjectHomeListLoadedSuccessState;
            List<WbsViewProjectItemDataModel> mainwbs = successState.sprojectwbsList;
            List<WbsSubSubDataModel> myssbl = List<WbsSubSubDataModel>.from(mainwbs.map((x) => x.mssgroup));
            // print(myssbl);
            myssbl?.sort((a, b) => a.msgroup_name.mgroup_name.dserialid.compareTo(b.msgroup_name.mgroup_name.dserialid));
            Map<dynamic, List<dynamic>> groupedItems = groupItemsByCategory(myssbl);
            return Scaffold(
              body: Padding(
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
              ),
            );
          case ProjectHomeLoadingErrorState:
            return Scaffold(body: const Center(child: Text ('Error 1') ));
          default:
            return  Scaffold(body: const Center(child: Text ('Error 2')));
        }
      },
    );
  }
}
