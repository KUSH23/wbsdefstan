part of 'plan_new_wbs_bloc.dart';

@immutable
abstract class PlanNewWbsEvent {}

class WbsNewInitialFetchEvent extends PlanNewWbsEvent {}

class WbsNewAddButtonClickedEvent extends PlanNewWbsEvent {
  final WbsSubSubDataModel wbsSubSubDataModel;
  WbsNewAddButtonClickedEvent({required this.wbsSubSubDataModel});
}

class WbsNewProjectSaveButtonClickedEvent extends PlanNewWbsEvent {
  final List<WbsSubSubDataModel> wbsSubSubDataModelList;
  WbsNewProjectSaveButtonClickedEvent({required this.wbsSubSubDataModelList});
}