part of 'plan_wbs_bloc.dart';

@immutable
abstract class PlanWbsEvent {}

class WbsInitialFetchEvent extends PlanWbsEvent {}

class WbsAddButtonClickedEvent extends PlanWbsEvent {
  final WbsSubSubDataModel wbsSubSubDataModel;
  WbsAddButtonClickedEvent({required this.wbsSubSubDataModel});
}