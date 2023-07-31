import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbsessential/constants.dart';
import 'package:wbsessential/features/plan_new_wbs/bloc/plan_new_wbs_bloc.dart';
import 'package:wbsessential/features/plan_wbs/bloc/plan_wbs_bloc.dart';
import 'package:wbsessential/features/plan_wbs/ui/wbs_tile_widget.dart';
import 'package:wbsessential/screens/components/search_bar.dart';

class PlanWbsTab extends StatefulWidget {
  const PlanWbsTab({super.key, required this.planNewWbsBloc});
  final PlanNewWbsBloc planNewWbsBloc;
  @override
  State<PlanWbsTab> createState() => _PlanWbsTabState();
}

class _PlanWbsTabState extends State<PlanWbsTab> {
  final PlanWbsBloc planWbsBloc = PlanWbsBloc();

  @override
  void initState() {
    // TODO: implement initState
    planWbsBloc.add(WbsInitialFetchEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlanWbsBloc, PlanWbsState>(
      bloc: planWbsBloc,
      listenWhen: (previous, current) => current is PlanWbsActionState,
      buildWhen: (previous, current) => current is !PlanWbsActionState,
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
          case PlanWbsLoadingState:
            return Column(
              children: [
                const SearchBar(),
                Text(
                  "Loading...",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          case PlanSubSubWbsLoadedSuccessState:
            num mywidth = MediaQuery.of(context).size.width;
            num myheight = MediaQuery.of(context).size.height;
            final successState = state as PlanSubSubWbsLoadedSuccessState;
            return Container(
              padding: const EdgeInsets.all(defaultPadding),
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView(
                children: [
                  Text(
                    "WBS List $mywidth x $myheight",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SearchBar(),
                  DataTable(
                    columnSpacing: 5,
                    // minWidth: 600,
                    columns: const [
                      DataColumn(
                        label: Text("WBS Name"),
                      ),
                      DataColumn(
                        label: Text("Action"),
                      ),
                    ],
                    rows: List.generate(
                        successState.subsubwbsList.length,
                            (index) => productFileDataRow(
                            productDataModel: successState.subsubwbsList[index],
                                planNewWbsBloc: widget.planNewWbsBloc,
                                planWbsBloc: planWbsBloc
                            )
                    ),
                  ),
                ],
              ),
            );
          case PlanWbsLoadingErrorState:
            return const Center(child: Text ('Error') );
          default:
            return  const Center(child: Text ('Error'));
        }
      },
    );
  }
}
