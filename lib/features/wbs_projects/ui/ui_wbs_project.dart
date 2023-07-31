import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wbsessential/constants.dart';
import 'package:wbsessential/features/plan_new_wbs/bloc/plan_new_wbs_bloc.dart';
import 'package:wbsessential/features/plan_wbs/bloc/plan_wbs_bloc.dart';
import 'package:wbsessential/features/plan_wbs/ui/wbs_tile_widget.dart';
import 'package:wbsessential/features/project_home/bloc/project_home_bloc.dart';
import 'package:wbsessential/features/wbs_projects/bloc/wbs_project_bloc.dart';
import 'package:wbsessential/features/project_home/ui/view_project.dart';
import 'package:wbsessential/features/wbs_projects/ui/wbs_project_tile_widget.dart';
import 'package:wbsessential/screens/components/responsive.dart';

class ListProjectWbs extends StatefulWidget {
  const ListProjectWbs({super.key, required this.screenSize,});
  final Size screenSize;
  @override
  State<ListProjectWbs> createState() => _ListProjectWbsState();
}

class _ListProjectWbsState extends State<ListProjectWbs> {
  final WbsProjectBloc wbsProjectBloc = WbsProjectBloc();
  final ProjectHomeBloc projectHomeBloc = ProjectHomeBloc();

  final List<String> assets = [
    'assets/images/photography.jpeg',
  ];
  @override
  void initState() {
    // TODO: implement initState
    wbsProjectBloc.add(WbsProjectInitialFetchEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WbsProjectBloc, WbsProjectState>(
      bloc: wbsProjectBloc,
      listenWhen: (previous, current) => current is WbsProjectActionState,
      buildWhen: (previous, current) => current is !WbsProjectActionState,
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
          case WbsProjectLoadingState:
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
          case WbsProjectListLoadedSuccessState:
            num mywidth = MediaQuery.of(context).size.width;
            num myheight = MediaQuery.of(context).size.height;
            final successState = state as WbsProjectListLoadedSuccessState;
            return
              ResponsiveWidget.isSmallScreen(context)
                  ? Padding(
                padding: EdgeInsets.only(top: widget.screenSize.height / 50),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: widget.screenSize.width / 15),
                      ...Iterable<int>.generate(successState.sprojectwbsList.length).map(
                            (int pageIndex) => Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: widget.screenSize.width / 2.5,
                                  width: widget.screenSize.width / 1.5,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5.0),
                                    child: Image.asset(
                                      assets[0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: widget.screenSize.height / 70,
                                  ),
                                  child: TextButton(
                                    onPressed: (){
                                      projectHomeBloc.add(ProjectHomeFetchEvent(pid: successState.sprojectwbsList[pageIndex].id));
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewProjectTab(projectHomeBloc: projectHomeBloc)));
                                    },
                                    child: Text(
                                      successState.sprojectwbsList[pageIndex].project_name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle1!
                                            .color,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: widget.screenSize.width / 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : Padding(
                padding: EdgeInsets.only(
                  top: widget.screenSize.height * 0.06,
                  left: widget.screenSize.width / 15,
                  right: widget.screenSize.width / 15,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...Iterable<int>.generate(successState.sprojectwbsList.length).map(
                          (int pageIndex) => Column(
                        children: [
                          SizedBox(
                            height: widget.screenSize.width / 6,
                            width: widget.screenSize.width / 3.8,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.asset(
                                assets[0],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: widget.screenSize.height / 70,
                            ),
                            child: TextButton(
                              onPressed: (){
                                projectHomeBloc.add(ProjectHomeFetchEvent(pid: successState.sprojectwbsList[pageIndex].id));
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewProjectTab(projectHomeBloc: projectHomeBloc)));
                              },
                              child: Text(
                                successState.sprojectwbsList[pageIndex].project_name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context)
                                      .primaryTextTheme
                                      .subtitle1!
                                      .color,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
          case WbsProjectLoadingErrorState:
            return const Center(child: Text ('Error') );
          default:
            return  const Center(child: Text ('Error'));
        }
      },
    );
  }
}

