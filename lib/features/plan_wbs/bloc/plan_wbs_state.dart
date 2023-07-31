part of 'plan_wbs_bloc.dart';

@immutable
abstract class PlanWbsState {}

abstract class PlanWbsActionState extends PlanWbsState {}

class PlanWbsInitial extends PlanWbsState {}

class PlanWbsLoadingState extends PlanWbsState {}

class PlanWbsLoadedSuccessState extends PlanWbsState {
  List<WbsMainDataModel> wbsList;
  PlanWbsLoadedSuccessState({required this.wbsList});
}

class PlanSubSubWbsLoadedSuccessState extends PlanWbsState {
  List<WbsSubSubDataModel> subsubwbsList;
  PlanSubSubWbsLoadedSuccessState({required this.subsubwbsList});
}

class PlanWbsLoadingErrorState extends PlanWbsState {}

class PlanWbsAdditionState extends PlanWbsActionState {}

class WbsAdditionErrorState extends PlanWbsActionState {}