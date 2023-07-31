part of 'plan_new_wbs_bloc.dart';

@immutable
abstract class PlanNewWbsState {}

abstract class PlanNewWbsActionState extends PlanNewWbsState {}

class PlanNewWbsInitial extends PlanNewWbsState {}

class PlanNewWbsLoadingState extends PlanNewWbsState {}

class PlanNewWbsLoadedSuccessState extends PlanNewWbsState {
  List<WbsMainDataModel> wbsList;
  PlanNewWbsLoadedSuccessState({required this.wbsList});
}

class PlanNewSubSubWbsLoadedSuccessState extends PlanNewWbsState {
  List<WbsSubSubDataModel> subsubwbsList;
  PlanNewSubSubWbsLoadedSuccessState({required this.subsubwbsList});
}

class PlanNewWbsLoadingErrorState extends PlanNewWbsState {}

class PlanNewWbsAdditionState extends PlanNewWbsActionState {}

class WbsNewAdditionErrorState extends PlanNewWbsActionState {}