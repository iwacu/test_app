part of 'home_page_cubit.dart';

abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageCompleted extends HomePageState {
  final List<BabyTask> babyTasks;

  HomePageCompleted(this.babyTasks);
}
