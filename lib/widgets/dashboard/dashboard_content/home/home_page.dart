import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/models/babyTask.dart';
import 'chart_painter/chartPainter.dart';

class HomePage extends StatefulWidget {
  final List<Map<String, dynamic>> splashData;
  // final ui.Image? img;
  HomePage({
    Key? key,
    required this.splashData,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _todayDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 12),
                child: Container(
                  height: SizeConfig.heightMultiplier * 16,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.splashData.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Column(
                            children: [
                              Container(
                                height: SizeConfig.heightMultiplier * 8,
                                width: SizeConfig.widthMultiplier * 18,
                                decoration: BoxDecoration(
                                    color: widget.splashData[index]['color'],
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: SvgPicture.asset(
                                    widget.splashData[index]['image']!,
                                    height: SizeConfig.heightMultiplier * 4,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: SizeConfig.heightMultiplier * 1.5,
                              ),
                              Text(
                                widget.splashData[index]['title']!,
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    color: Colors.black38,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  'Today ${Jiffy(_todayDate).MMMEd}',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2,
                      color: buttonBGColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              BlocBuilder<HomePageCubit, HomePageState>(
                builder: (context, state) {
                  if (state is HomePageInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is HomePageCompleted) {
                    return Container(
                      height: SizeConfig.heightMultiplier * 18,
                      decoration: BoxDecoration(color: bluewhite),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            child: SizedBox(
                              width: SizeConfig.widthMultiplier * 73,
                              child: CustomPaint(
                                child: Container(),
                                painter: TimelinePainter(state.babyTasks
                                    .where((element) =>
                                        DateTime.parse(element.timeStamp).day ==
                                            _todayDate.day &&
                                        DateTime.parse(element.timeStamp)
                                                .month ==
                                            _todayDate.month &&
                                        DateTime.parse(element.timeStamp)
                                                .year ==
                                            _todayDate.year)
                                    .toList()),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              _babyTasks(),
            ],
          ),
        ),
      ),
    );
  }

  _babyTasks() {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        if (state is HomePageInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomePageCompleted) {
          var babyTasks = state.babyTasks
              .where((element) =>
                  DateTime.parse(element.timeStamp).day == _todayDate.day &&
                  DateTime.parse(element.timeStamp).month == _todayDate.month &&
                  DateTime.parse(element.timeStamp).year == _todayDate.year)
              .toList();
          return babyTasks.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: SvgPicture.asset(
                      "assets/icons/carrirage.svg",
                      height: SizeConfig.imageSizeMultiplier * 30,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: babyTasks.length,
                        itemBuilder: (_, index) {
                          if (babyTasks[index].taskName == 'sleeping') {
                            return _sleeping(
                                babyTasks[index], index, babyTasks.length);
                          } else if (babyTasks[index].taskName == 'food') {
                            return _food(
                                babyTasks[index], index, babyTasks.length);
                          } else if (babyTasks[index].taskName == 'feeder') {
                            return _feeder(
                                babyTasks[index], index, babyTasks.length);
                          } else if (babyTasks[index].taskName == 'diaper') {
                            return _diaper(
                                babyTasks[index], index, babyTasks.length);
                          } else if (babyTasks[index].taskName == 'walking') {
                            return _walking(
                                babyTasks[index], index, babyTasks.length);
                          } else if (babyTasks[index].taskName ==
                              'breast-pumping') {
                            return _breastPumping(
                                babyTasks[index], index, babyTasks.length);
                          } else if (babyTasks[index].taskName ==
                              'breast-feed') {
                            return _breastFeeding(
                                babyTasks[index], index, babyTasks.length);
                          }
                          return Container();
                        }),
                  ),
                );
        }
        return Container();
      },
    );
  }

  _sleeping(BabyTask baby, int index, int length) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${baby.taskName[0].toUpperCase()}${baby.taskName.substring(1)}",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 26,
                      ),
                      Text(
                        DateFormat('hh:mm a')
                            .format(DateTime.parse(baby.timeStamp)),
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1.2,
                          ),
                          Text(
                            DateFormat('hh:mm a')
                                .format(DateTime.parse(baby.startTime)),
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                // fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 3,
                          ),
                          Text(
                            DateFormat('hh:mm a')
                                .format(DateTime.parse(baby.endTime)),
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                // fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 1.4,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duration',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.3,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 3,
                      ),
                      Text(
                        '${baby.durationH}H ${baby.durationM}M ${baby.durationS}S',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.3,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  SizedBox(
                    width: 190,
                    child: Text("${baby.note}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300,
                            color: Colors.black38)),
                  ),
                ],
              ),
            ],
          ),
        ),
        index + 1 == length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.4,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _food(BabyTask baby, int index, int length) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${baby.taskName[0].toUpperCase()}${baby.taskName.substring(1)}",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 34,
                      ),
                      Text(
                        DateFormat('hh:mm a')
                            .format(DateTime.parse(baby.timeStamp)),
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/group.svg",
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1.2,
                          ),
                          Text(
                            'Food Group',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1.2,
                          ),
                          Text(
                            '${baby.groupFood}',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                // fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.widthMultiplier * 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/amount.svg",
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1.2,
                          ),
                          Text(
                            'Amount',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1.2,
                          ),
                          Text(
                            '${baby.qtyFood}',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                // fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 1.4,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  SizedBox(
                    width: 190,
                    child: Text("${baby.note}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300,
                            color: Colors.black38)),
                  ),
                ],
              ),
            ],
          ),
        ),
        index + 1 == length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _feeder(BabyTask baby, int index, int length) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${baby.taskName[0].toUpperCase()}${baby.taskName.substring(1)}",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 30,
                      ),
                      Text(
                        DateFormat('hh:mm a')
                            .format(DateTime.parse(baby.timeStamp)),
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ml.svg",
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1.2,
                          ),
                          Text(
                            '${baby.qtyFood}',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                // fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 1.4,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  SizedBox(
                    width: 190,
                    child: Text("${baby.note}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w300,
                            color: Colors.black38)),
                  ),
                ],
              ),
            ],
          ),
        ),
        index + 1 == length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _diaper(BabyTask baby, int index, int length) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${baby.taskName[0].toUpperCase()}${baby.taskName.substring(1)}",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 30,
                      ),
                      Text(
                        DateFormat('hh:mm a')
                            .format(DateTime.parse(baby.timeStamp)),
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          baby.pee == 1
                              ? Container()
                              : SvgPicture.asset(
                                  "assets/icons/pee.svg",
                                  height: SizeConfig.heightMultiplier * 2,
                                ),
                          baby.pee == 1
                              ? Container()
                              : SizedBox(
                                  width: SizeConfig.widthMultiplier * 1.2,
                                ),
                          baby.pee == 1
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    'Pee',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.3,
                                        fontFamily: 'Montserrat',
                                        // fontWeight: FontWeight.w700,
                                        color: Colors.black38),
                                  ),
                                ),
                          baby.pee == 1
                              ? Container()
                              : SizedBox(
                                  width: SizeConfig.widthMultiplier * 8,
                                ),
                          baby.poo == 1
                              ? Container()
                              : SvgPicture.asset(
                                  "assets/icons/poop.svg",
                                  height: SizeConfig.heightMultiplier * 2,
                                ),
                          baby.poo == 1
                              ? Container()
                              : SizedBox(
                                  width: SizeConfig.widthMultiplier * 1.2,
                                ),
                          baby.poo == 1
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(top: 3.0),
                                  child: Text(
                                    'Poop',
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.3,
                                        fontFamily: 'Montserrat',
                                        // fontWeight: FontWeight.w700,
                                        color: Colors.black38),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 1.4,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  SizedBox(
                    width: 190,
                    child: Text("${baby.note}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300,
                            color: Colors.black38)),
                  ),
                ],
              ),
            ],
          ),
        ),
        index + 1 == length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _walking(BabyTask baby, int index, int length) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${baby.taskName[0].toUpperCase()}${baby.taskName.substring(1)}",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 26,
                      ),
                      Text(
                        DateFormat('hh:mm a')
                            .format(DateTime.parse(baby.timeStamp)),
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Start',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1.2,
                          ),
                          Text(
                            DateFormat('hh:mm a')
                                .format(DateTime.parse(baby.startTime)),
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                // fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'End',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 3,
                          ),
                          Text(
                            DateFormat('hh:mm a')
                                .format(DateTime.parse(baby.endTime)),
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                // fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 1.4,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 1.3,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Duration',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.3,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 3,
                      ),
                      Text(
                        '${baby.durationH}H ${baby.durationM}M ${baby.durationS}S',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.3,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  SizedBox(
                    width: 190,
                    child: Text("${baby.note}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w300,
                            color: Colors.black38)),
                  ),
                ],
              ),
            ],
          ),
        ),
        index + 1 == length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _breastPumping(BabyTask baby, int index, int length) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Breast Pumping",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 15,
                      ),
                      Text(
                        DateFormat('hh:mm a')
                            .format(DateTime.parse(baby.timeStamp)),
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            "assets/icons/ml.svg",
                            height: SizeConfig.heightMultiplier * 2,
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1.2,
                          ),
                          Text(
                            '${baby.qtyFood}',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                // fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 1.4,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  SizedBox(
                    width: 190,
                    child: Text("${baby.note}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w300,
                            color: Colors.black38)),
                  ),
                ],
              ),
            ],
          ),
        ),
        index + 1 == length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _breastFeeding(BabyTask baby, int index, int length) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.heightMultiplier * 8,
                width: SizeConfig.widthMultiplier * 18,
                decoration: BoxDecoration(
                    color: Color(int.parse(baby.color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${baby.taskName}.svg",
                    height: SizeConfig.heightMultiplier * 4,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Breast Feeding",
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 15,
                      ),
                      Text(
                        DateFormat('hh:mm a')
                            .format(DateTime.parse(baby.timeStamp)),
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 2,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w700,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 1.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Last Breast To feed on : ',
                            style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 1.3,
                                fontFamily: 'Montserrat',
                                // fontWeight: FontWeight.w700,
                                color: Colors.black38),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 1.2,
                          ),
                          baby.leftBreast == 0
                              ? Text(
                                  'Left',
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 1.3,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black38),
                                )
                              : Container(),
                          baby.rightBreast == 0
                              ? Text(
                                  'Right',
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 1.3,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black38),
                                )
                              : Container(),
                        ],
                      ),
                      SizedBox(
                        width: SizeConfig.widthMultiplier * 1.4,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  SizedBox(
                    width: 190,
                    child: Text("${baby.note}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.8,
                            fontFamily: 'Montserrat',
                            // fontWeight: FontWeight.w300,
                            color: Colors.black38)),
                  ),
                ],
              ),
            ],
          ),
        ),
        index + 1 == length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.2,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }
}
