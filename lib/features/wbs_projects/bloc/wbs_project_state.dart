part of 'wbs_project_bloc.dart';

@immutable
abstract class WbsProjectState {}

abstract class WbsProjectActionState extends WbsProjectState {}

class WbsProjectInitial extends WbsProjectState {}

class WbsProjectLoadingState extends WbsProjectState {}

class WbsProjectListLoadedSuccessState extends WbsProjectState {
  List<WbsNewProjectDataModel> sprojectwbsList;
  WbsProjectListLoadedSuccessState({required this.sprojectwbsList});
}

class WbsProjectLoadingErrorState extends WbsProjectState {}

class WbsProjectAdditionState extends WbsProjectActionState {}

class WbsProjectAdditionErrorState extends WbsProjectActionState {}