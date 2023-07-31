import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wbsessential/controller/form_controller.dart';
import 'package:wbsessential/models/new_project_wbs.dart';
import 'package:wbsessential/models/project_items_wbs.dart';

part 'project_home_event.dart';
part 'project_home_state.dart';

class ProjectHomeBloc extends Bloc<ProjectHomeEvent, ProjectHomeState> {
  ProjectHomeBloc() : super(ProjectHomeInitial()) {
    on<ProjectHomeEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<ProjectHomeFetchEvent>(projectHomeFetchEvent);
  }

  FutureOr<void> projectHomeFetchEvent(
      ProjectHomeFetchEvent event, Emitter<ProjectHomeState> emit) async{
    emit(ProjectHomeLoadingState());
    List<WbsViewProjectItemDataModel> sWprojectwbsList = await FormController().getProjectViewWList(event.pid);
    // print(sWprojectwbsList);
    emit(ProjectHomeListLoadedSuccessState(sprojectwbsList: sWprojectwbsList));
  }
}
