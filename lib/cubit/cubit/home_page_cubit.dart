import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/babyTask.dart';
import 'package:momnotebook/services/database/database_helper.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial()) {
    // getBabyTasks();
  }
  void getBabyTasks() async {
    if (state is HomePageCompleted == false) {
      emit(HomePageInitial());
    }
    var user = await DatabaseHelper.instance.getUser();
    var response =
        await DatabaseHelper.instance.getBabyTasks(user.object!.babyId);
    print('ggggggggggggggggggggggggg ${response.length}');

    emit(HomePageCompleted(response));
  }

  void saveTasks(
      {Baby? baby,
      String? note,
      String? foodGroup,
      String? amount,
      String? amountScale,
      String? taskName,
      String? color,
      Duration? duration}) async {
    await DatabaseHelper.instance.addBabyTask(BabyTask(
        babyId: baby!.id!,
        taskName: taskName!,
        timeStamp: DateTime.now().toString(),
        note: note!,
        startTime: '',
        resumeTime: '',
        endTime: '',
        qtyFood: '$amount $amountScale',
        qtyLeft: '',
        qtyRight: '',
        qtyFeeder: '',
        leftBreast: 1,
        rightBreast: 1,
        groupFood: foodGroup!,
        pee: 1,
        poo: 1,
        durationH: duration!.inHours.toString(),
        durationM: duration.inMinutes.toString(),
        durationS: duration.inSeconds.toString(),
        color: color!));
    getBabyTasks();
  }

  void saveTasksBP(
      {Baby? baby,
      String? note,
      String? foodGroup,
      String? amount,
      String? amountScale,
      String? taskName,
      String? color,
      Duration? duration}) async {
    await DatabaseHelper.instance.addBabyTask(BabyTask(
        babyId: baby!.id!,
        taskName: taskName!,
        timeStamp: DateTime.now().toString(),
        note: note!,
        startTime: '',
        resumeTime: '',
        endTime: '',
        qtyFood: '$amount $amountScale',
        qtyLeft: '',
        qtyRight: '',
        qtyFeeder: '',
        leftBreast: 1,
        rightBreast: 1,
        groupFood: '',
        pee: 1,
        poo: 1,
        durationH: duration!.inHours.toString(),
        durationM: duration.inMinutes.toString(),
        durationS: duration.inSeconds.toString(),
        color: color!));
    getBabyTasks();
  }

  void saveTasksBF(
      {Baby? baby,
      String? note,
      String? foodGroup,
      String? amount,
      String? amountScale,
      String? taskName,
      bool? left,
      bool? right,
      String? color,
      Duration? duration}) async {
    await DatabaseHelper.instance.addBabyTask(BabyTask(
        babyId: baby!.id!,
        taskName: taskName!,
        timeStamp: DateTime.now().toString(),
        note: note!,
        startTime: '',
        resumeTime: '',
        endTime: '',
        qtyFood: '',
        qtyLeft: '',
        qtyRight: '',
        qtyFeeder: '',
        leftBreast: left! ? 0 : 1,
        rightBreast: right! ? 0 : 1,
        groupFood: '',
        pee: 1,
        poo: 1,
        durationH: duration!.inHours.toString(),
        durationM: duration.inMinutes.toString(),
        durationS: duration.inSeconds.toString(),
        color: color!));
    getBabyTasks();
  }

  void saveTasksDiaper(
      {Baby? baby,
      String? note,
      String? foodGroup,
      String? amount,
      String? amountScale,
      String? taskName,
      int? pee,
      int? poop,
      String? color,
      Duration? duration}) async {
    await DatabaseHelper.instance.addBabyTask(BabyTask(
        babyId: baby!.id!,
        taskName: taskName!,
        timeStamp: DateTime.now().toString(),
        note: note!,
        resumeTime: '',
        endTime: '',
        startTime: '',
        qtyFood: '',
        qtyLeft: '',
        qtyRight: '',
        qtyFeeder: '',
        leftBreast: 1,
        rightBreast: 1,
        groupFood: '',
        pee: pee!,
        poo: poop!,
        durationH: duration!.inHours.toString(),
        durationM: duration.inMinutes.toString(),
        durationS: duration.inSeconds.toString(),
        color: color!));
    getBabyTasks();
  }

  void saveTasksWalkingSleeping(
      {Baby? baby,
      String? note,
      String? foodGroup,
      String? amount,
      String? amountScale,
      String? taskName,
      String? startTime,
      String? endTime,
      int? pee,
      int? poop,
      String? color,
      Duration? duration}) async {
    await DatabaseHelper.instance.addBabyTask(BabyTask(
        babyId: baby!.id!,
        taskName: taskName!,
        timeStamp: DateTime.now().toString(),
        note: note!,
        resumeTime: '',
        endTime: endTime!,
        startTime: startTime!,
        qtyFood: '',
        qtyLeft: '',
        qtyRight: '',
        qtyFeeder: '',
        leftBreast: 1,
        rightBreast: 1,
        groupFood: '',
        pee: 1,
        poo: 1,
        durationH: duration!.inHours.toString(),
        durationM: duration.inMinutes.toString(),
        durationS: duration.inSeconds.toString(),
        color: color!));
    getBabyTasks();
  }
}
