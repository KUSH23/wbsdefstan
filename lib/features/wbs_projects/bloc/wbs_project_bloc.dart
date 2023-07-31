import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wbsessential/controller/form_controller.dart';
import 'package:wbsessential/models/new_project_wbs.dart';

part 'wbs_project_event.dart';
part 'wbs_project_state.dart';

class WbsProjectBloc extends Bloc<WbsProjectEvent, WbsProjectState> {
  WbsProjectBloc() : super(WbsProjectInitial()) {
    on<WbsProjectEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<WbsProjectInitialFetchEvent>(wbsProjectInitialFetchEvent);
  }

  FutureOr<void> wbsProjectInitialFetchEvent(
      WbsProjectInitialFetchEvent event, Emitter<WbsProjectState> emit) async{
    emit(WbsProjectLoadingState());
    // await Future.delayed(const Duration(seconds: 3));
    // List<WbsNewProjectDataModel> sprojectwbsList = await FormController().getProjectWbsList("");
    List<WbsNewProjectDataModel> sWprojectwbsList = await FormController().getProjectWList("");
    // print(sWprojectwbsList);
    emit(WbsProjectListLoadedSuccessState(sprojectwbsList: sWprojectwbsList));
  }
}
