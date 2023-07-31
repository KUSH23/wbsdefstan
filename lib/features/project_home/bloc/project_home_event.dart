part of 'project_home_bloc.dart';

@immutable
abstract class ProjectHomeEvent {}

class ProjectHomeFetchEvent extends ProjectHomeEvent {
  num pid;
  ProjectHomeFetchEvent({required this.pid});
}