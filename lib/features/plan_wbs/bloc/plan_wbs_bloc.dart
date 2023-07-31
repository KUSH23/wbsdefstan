import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wbsessential/controller/form_controller.dart';
import 'package:wbsessential/controller/new_wbs_data.dart';
import 'package:wbsessential/models/sub_sub_wbs.dart';
import 'package:wbsessential/models/wbs_main.dart';

part 'plan_wbs_event.dart';
part 'plan_wbs_state.dart';

class PlanWbsBloc extends Bloc<PlanWbsEvent, PlanWbsState> {
  PlanWbsBloc() : super(PlanWbsInitial()) {
    on<PlanWbsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<WbsInitialFetchEvent>(wbsInitialFetchEvent);
    on<WbsAddButtonClickedEvent>(wbsAddButtonClickedEvent);
  }

  FutureOr<void> wbsInitialFetchEvent(
      WbsInitialFetchEvent event, Emitter<PlanWbsState> emit) async{
    emit(PlanWbsLoadingState());

    // List<WbsMainDataModel> mydata = await FormController().getWbsList("");
    // List<WbsSubDataModel> mysubdata = await FormController().getSubWbsList("");
    subsubwbsfetchedList = await FormController().getSubSubWbsList("");
    emit(PlanSubSubWbsLoadedSuccessState(subsubwbsList: subsubwbsfetchedList));
  }


  FutureOr<void> wbsAddButtonClickedEvent(
      WbsAddButtonClickedEvent event, Emitter<PlanWbsState> emit) {
    subsubwbsfetchedList.remove(event.wbsSubSubDataModel);
    emit(PlanSubSubWbsLoadedSuccessState(subsubwbsList: subsubwbsfetchedList));
  }
}
