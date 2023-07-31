part of 'project_home_bloc.dart';

@immutable
abstract class ProjectHomeState {}

abstract class ProjectHomeActionState extends ProjectHomeState {}

class ProjectHomeInitial extends ProjectHomeState {}

class ProjectHomeLoadingState extends ProjectHomeState {}

class ProjectHomeListLoadedSuccessState extends ProjectHomeState {
  List<WbsViewProjectItemDataModel> sprojectwbsList;
  ProjectHomeListLoadedSuccessState({required this.sprojectwbsList});
}

class ProjectHomeLoadingErrorState extends ProjectHomeState {}

class ProjectHomeAdditionSuccessState extends ProjectHomeActionState {}

class ProjectHomeAdditionErrorState extends ProjectHomeActionState {}