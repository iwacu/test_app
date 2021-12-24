import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/bloc/bloc/form_saving_bloc.dart';
import 'package:momnotebook/bloc/form_submission/form_sub.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/customAppBar.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/show_snackBar.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/models/baby.dart';
import 'package:momnotebook/models/babyTask.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeUpdateSleep extends StatefulWidget {
  final Baby baby;
  final BabyTask babyTask;
  HomeUpdateSleep({Key? key, required this.baby, required this.babyTask})
      : super(key: key);

  @override
  State<HomeUpdateSleep> createState() => _HomeUpdateSleepState();
}

class _HomeUpdateSleepState extends State<HomeUpdateSleep> {
  DateTime? _nowDate;
  Duration? duration;
  final _text = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nowDate = DateTime.parse(widget.babyTask.timeStamp);
    _text.text = widget.babyTask.note;
    duration = Duration(
        hours: DateTime.parse(widget.babyTask.endTime).hour -
            DateTime.parse(widget.babyTask.startTime).hour,
        minutes: DateTime.parse(widget.babyTask.endTime).minute -
            DateTime.parse(widget.babyTask.startTime).minute,
        seconds: DateTime.parse(widget.babyTask.endTime).second -
            DateTime.parse(widget.babyTask.startTime).second);
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration!.inMinutes.remainder(60));
    final seconds = twoDigits(duration!.inSeconds.remainder(60));
    final hours = twoDigits(duration!.inHours.remainder(60));

    return BlocProvider(
      create: (context) => FormSavingBloc(),
      child: Scaffold(
        backgroundColor: bluewhite,
        appBar: CustomAppBar(
            height: SizeConfig.heightMultiplier * 9,
            child: appBarDashboardUD(widget.baby, context, () {
              BlocProvider.of<HomePageCubit>(context)
                  .removeBabyTask(widget.babyTask.id!);
              Navigator.pop(context);
            })),
        body: BlocListener<FormSavingBloc, FormSavingState>(
          listener: (context, state) {
            final formStatus = state.formSubmissionStatus;
            if (formStatus is SubmissionSuccess) {
              showSnackBar(context, formStatus.message);
              Navigator.pop(context);
            }
          },
          child: Container(
            color: Colors.white,
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: bluewhite,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(30.0),
                    topRight: const Radius.circular(30.0),
                  )),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          height: SizeConfig.heightMultiplier * 12,
                          width: SizeConfig.widthMultiplier * 22,
                          decoration: BoxDecoration(
                              color: greenGray, shape: BoxShape.circle),
                          child: Center(
                            child: SvgPicture.asset('assets/icons/sleeping.svg',
                                height: SizeConfig.heightMultiplier * 6),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Center(
                      child: Text(
                        'Sleeping',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2.5,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    BlocBuilder<HomePageCubit, HomePageState>(
                      builder: (context, state) {
                        if (state is HomePageInitial) {
                          return Center(
                            child: Text('loading'),
                          );
                        } else if (state is HomePageCompleted) {
                          var lastWalk = state.babyTasks
                              .where(
                                  (element) => element.taskName == 'sleeping')
                              .toList();
                          var lastwlk = lastWalk.isEmpty
                              ? 'Start'
                              : 'Last: ${timeago.format(DateTime.parse(lastWalk[0].timeStamp))}';

                          return Center(
                            child: Text(
                              lastwlk,
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black38),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          '$hours',
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black38),
                                        ),
                                        Text(
                                          ' :',
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black38),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Hours',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.7,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          color: greenGray),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          '$minutes',
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black38),
                                        ),
                                        Text(
                                          ' :',
                                          style: TextStyle(
                                              fontSize: 32,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w700,
                                              color: Colors.black38),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Minutes',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.7,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          color: greenGray),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: Text(
                                      '$seconds',
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black38),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Seconds',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 1.7,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w300,
                                          color: greenGray),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/time.svg',
                                height: SizeConfig.heightMultiplier * 3,
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 2,
                              ),
                              Text(
                                'Time',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38),
                              ),
                              Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: greyColor)),
                                child: Text(
                                  Jiffy(_nowDate).yMMMMd,
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 2,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 2,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: greyColor)),
                                child: Text(
                                  DateFormat('hh:mm a').format(_nowDate!),
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 2,
                                      fontFamily: 'Montserrat',
                                      color: Colors.black38,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: TextFormField(
                            controller: _text,
                            maxLength: 1000,
                            decoration: InputDecoration(
                              labelText: 'Notes',
                              labelStyle: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black38),
                              enabledBorder: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: almostGrey, width: 0.8)),
                            ))),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 4,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 8),
                        child: DefaultButtonBsz(
                          text: 'Update',
                          press: () {
                            BlocProvider.of<HomePageCubit>(context)
                                .updateBabyTask(BabyTask(
                                    id: widget.babyTask.id,
                                    babyId: widget.babyTask.babyId,
                                    taskName: widget.babyTask.taskName,
                                    timeStamp: widget.babyTask.timeStamp,
                                    note: _text.text,
                                    startTime: widget.babyTask.startTime,
                                    endTime: widget.babyTask.endTime,
                                    resumeTime: '',
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
                                    durationM: duration!.inMinutes.toString(),
                                    durationS: duration!.inSeconds.toString(),
                                    color: widget.babyTask.color,
                                    onTaskCompleted:
                                        widget.babyTask.onTaskCompleted));
                            Navigator.pop(context);
                          },
                        )),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _showDatePicker(ctx) {
  //   // showCupertinoModalPopup is a built-in function of the cupertino library
  //   showCupertinoModalPopup(
  //       context: ctx,
  //       builder: (_) => Container(
  //             height: 500,
  //             color: Color.fromARGB(255, 255, 255, 255),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   height: 400,
  //                   child: CupertinoDatePicker(
  //                       mode: CupertinoDatePickerMode.date,
  //                       initialDateTime: _nowDate,
  //                       onDateTimeChanged: (val) {
  //                         setState(() {
  //                           _nowDate = DateTime(
  //                               val.year,
  //                               val.month,
  //                               val.day,
  //                               _nowDate!.hour,
  //                               _nowDate!.minute,
  //                               _nowDate!.second);
  //                         });
  //                       }),
  //                 ),

  //                 // Close the modal
  //                 CupertinoButton(
  //                   child: Text('OK'),
  //                   onPressed: () => Navigator.of(ctx).pop(),
  //                 )
  //               ],
  //             ),
  //           ));
  // }

  // void _showTimePicker(ctx) {
  //   // showCupertinoModalPopup is a built-in function of the cupertino library
  //   showCupertinoModalPopup(
  //       context: ctx,
  //       builder: (_) => Container(
  //             height: 500,
  //             color: Color.fromARGB(255, 255, 255, 255),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   height: 400,
  //                   child: CupertinoDatePicker(
  //                       mode: CupertinoDatePickerMode.time,
  //                       initialDateTime: _nowDate,
  //                       onDateTimeChanged: (val) {
  //                         setState(() {
  //                           _nowDate = val;
  //                         });
  //                       }),
  //                 ),

  //                 // Close the modal
  //                 CupertinoButton(
  //                   child: Text('OK'),
  //                   onPressed: () => Navigator.of(ctx).pop(),
  //                 )
  //               ],
  //             ),
  //           ));
  // }

}
