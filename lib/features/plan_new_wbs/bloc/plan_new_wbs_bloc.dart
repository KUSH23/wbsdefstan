import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wbsessential/constants.dart';
import 'package:wbsessential/controller/form_controller.dart';
import 'package:wbsessential/controller/new_wbs_data.dart';
import 'package:wbsessential/models/new_project_wbs.dart';
import 'package:wbsessential/models/project_items_wbs.dart';
import 'package:wbsessential/models/sub_sub_wbs.dart';
import 'package:wbsessential/models/wbs_main.dart';

part 'plan_new_wbs_event.dart';
part 'plan_new_wbs_state.dart';

class PlanNewWbsBloc extends Bloc<PlanNewWbsEvent, PlanNewWbsState> {
  PlanNewWbsBloc() : super(PlanNewWbsInitial()) {
    on<PlanNewWbsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<WbsNewInitialFetchEvent>(wbsInitialFetchEvent);
    on<WbsNewAddButtonClickedEvent>(wbsAddButtonClickedEvent);
    on<WbsNewProjectSaveButtonClickedEvent>(wbsNewProjectSaveButtonClickedEvent);
  }

  FutureOr<void> wbsInitialFetchEvent(
      WbsNewInitialFetchEvent event, Emitter<PlanNewWbsState> emit) async{
    emit(PlanNewWbsLoadingState());
    // await Future.delayed(const Duration(seconds: 3));
    List<WbsSubSubDataModel> subsubwbsList = wbsTempSubSubDataModel;
    emit(PlanNewSubSubWbsLoadedSuccessState(subsubwbsList: subsubwbsList));
  }

  FutureOr<void> wbsAddButtonClickedEvent(
      WbsNewAddButtonClickedEvent event, Emitter<PlanNewWbsState> emit) {
    tempprojectitemsList.add(WbsNewProjectItemDataModel(mssgroup: event.wbsSubSubDataModel.id));
    wbsTempSubSubDataModel.add(event.wbsSubSubDataModel);

    emit(PlanNewSubSubWbsLoadedSuccessState(subsubwbsList: wbsTempSubSubDataModel));
    // print(wbsTempSubSubDataModel);
  }

  FutureOr<void> wbsNewProjectSaveButtonClickedEvent(
      WbsNewProjectSaveButtonClickedEvent event, Emitter<PlanNewWbsState> emit) async{
    // bool status = await FormController().addNewProjects(product: WbsNewProjectDataModel(
    //     projectid: newProjectId, project_name: newProjectName, mssgroup_name: event.wbsSubSubDataModelList));

    bool status2 = await FormController().addNewWProjects(product: WbsNewProjectWDataModel(
        projectid: newProjectId, project_name: newProjectName, project_items: tempprojectitemsList));

    print(status2);
  }
}
