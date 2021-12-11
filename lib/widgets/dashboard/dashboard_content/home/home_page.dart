import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'dart:ui' as ui;
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

  List<Map<String, Object>> get mapValues {
    return List.generate(23, (index) {
      var list = new List<int>.generate(23, (i) => i + 1);

      return {'hour': list[index]};
    });
  }

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
                  height: SizeConfig.heightMultiplier * 18,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.splashData.length,
                      itemBuilder: (context, index) {
                        return Column(
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
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  color: Colors.black38,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
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
                            color: primaryColor,
                            child: SizedBox(
                              width: SizeConfig.widthMultiplier * 73,
                              child: CustomPaint(
                                child: Container(),
                                painter: TimelinePainter(state.babyTasks),
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.babyTasks.length,
                  itemBuilder: (_, index) {
                    if (state.babyTasks[index].taskName == 'sleeping') {
                      return _sleeping(state, index);
                    } else if (state.babyTasks[index].taskName == 'food') {
                      return _food(state, index);
                    } else if (state.babyTasks[index].taskName == 'feeder') {
                      return _feeder(state, index);
                    } else if (state.babyTasks[index].taskName == 'diaper') {
                      return _diaper(state, index);
                    } else if (state.babyTasks[index].taskName == 'walking') {
                      return _walking(state, index);
                    } else if (state.babyTasks[index].taskName ==
                        'breast-pumping') {
                      return _breastPumping(state, index);
                    } else if (state.babyTasks[index].taskName ==
                        'breast-feed') {
                      return _breastFeeding(state, index);
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

  _sleeping(HomePageCompleted state, int index) {
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
                    color: Color(int.parse(state.babyTasks[index].color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${state.babyTasks[index].taskName}.svg",
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
                        "${state.babyTasks[index].taskName[0].toUpperCase()}${state.babyTasks[index].taskName.substring(1)}",
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
                        DateFormat('hh:mm a').format(
                            DateTime.parse(state.babyTasks[index].timeStamp)),
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
                            DateFormat('hh:mm a').format(DateTime.parse(
                                state.babyTasks[index].startTime)),
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
                            DateFormat('hh:mm a').format(
                                DateTime.parse(state.babyTasks[index].endTime)),
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
                        '${state.babyTasks[index].durationH}H ${state.babyTasks[index].durationM}M ${state.babyTasks[index].durationS}S',
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
                    child: Text("${state.babyTasks[index].note}",
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
        index + 1 == state.babyTasks.length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _food(HomePageCompleted state, int index) {
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
                    color: Color(int.parse(state.babyTasks[index].color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${state.babyTasks[index].taskName}.svg",
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
                        "${state.babyTasks[index].taskName[0].toUpperCase()}${state.babyTasks[index].taskName.substring(1)}",
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
                        DateFormat('hh:mm a').format(
                            DateTime.parse(state.babyTasks[index].timeStamp)),
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
                            '${state.babyTasks[index].groupFood}',
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
                            '${state.babyTasks[index].qtyFood}',
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
                    child: Text("${state.babyTasks[index].note}",
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
        index + 1 == state.babyTasks.length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _feeder(HomePageCompleted state, int index) {
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
                    color: Color(int.parse(state.babyTasks[index].color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${state.babyTasks[index].taskName}.svg",
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
                        "${state.babyTasks[index].taskName[0].toUpperCase()}${state.babyTasks[index].taskName.substring(1)}",
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
                        DateFormat('hh:mm a').format(
                            DateTime.parse(state.babyTasks[index].timeStamp)),
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
                            '${state.babyTasks[index].qtyFood}',
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
                    child: Text("${state.babyTasks[index].note}",
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
        index + 1 == state.babyTasks.length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _diaper(HomePageCompleted state, int index) {
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
                    color: Color(int.parse(state.babyTasks[index].color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${state.babyTasks[index].taskName}.svg",
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
                        "${state.babyTasks[index].taskName[0].toUpperCase()}${state.babyTasks[index].taskName.substring(1)}",
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
                        DateFormat('hh:mm a').format(
                            DateTime.parse(state.babyTasks[index].timeStamp)),
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
                          state.babyTasks[index].pee == 1
                              ? Container()
                              : SvgPicture.asset(
                                  "assets/icons/pee.svg",
                                  height: SizeConfig.heightMultiplier * 2,
                                ),
                          state.babyTasks[index].pee == 1
                              ? Container()
                              : SizedBox(
                                  width: SizeConfig.widthMultiplier * 1.2,
                                ),
                          state.babyTasks[index].pee == 1
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
                          state.babyTasks[index].pee == 1
                              ? Container()
                              : SizedBox(
                                  width: SizeConfig.widthMultiplier * 8,
                                ),
                          state.babyTasks[index].poo == 1
                              ? Container()
                              : SvgPicture.asset(
                                  "assets/icons/poop.svg",
                                  height: SizeConfig.heightMultiplier * 2,
                                ),
                          state.babyTasks[index].poo == 1
                              ? Container()
                              : SizedBox(
                                  width: SizeConfig.widthMultiplier * 1.2,
                                ),
                          state.babyTasks[index].poo == 1
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
                    child: Text("${state.babyTasks[index].note}",
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
        index + 1 == state.babyTasks.length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _walking(HomePageCompleted state, int index) {
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
                    color: Color(int.parse(state.babyTasks[index].color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${state.babyTasks[index].taskName}.svg",
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
                        "${state.babyTasks[index].taskName[0].toUpperCase()}${state.babyTasks[index].taskName.substring(1)}",
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
                        DateFormat('hh:mm a').format(
                            DateTime.parse(state.babyTasks[index].timeStamp)),
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
                            DateFormat('hh:mm a').format(DateTime.parse(
                                state.babyTasks[index].startTime)),
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
                            DateFormat('hh:mm a').format(
                                DateTime.parse(state.babyTasks[index].endTime)),
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
                        '${state.babyTasks[index].durationH}H ${state.babyTasks[index].durationM}M ${state.babyTasks[index].durationS}S',
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
                    child: Text("${state.babyTasks[index].note}",
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
        index + 1 == state.babyTasks.length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _breastPumping(HomePageCompleted state, int index) {
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
                    color: Color(int.parse(state.babyTasks[index].color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${state.babyTasks[index].taskName}.svg",
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
                        DateFormat('hh:mm a').format(
                            DateTime.parse(state.babyTasks[index].timeStamp)),
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
                            '${state.babyTasks[index].qtyFood}',
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
                    child: Text("${state.babyTasks[index].note}",
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
        index + 1 == state.babyTasks.length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }

  _breastFeeding(HomePageCompleted state, int index) {
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
                    color: Color(int.parse(state.babyTasks[index].color)),
                    shape: BoxShape.circle),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/${state.babyTasks[index].taskName}.svg",
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
                        DateFormat('hh:mm a').format(
                            DateTime.parse(state.babyTasks[index].timeStamp)),
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
                          state.babyTasks[index].leftBreast == 0
                              ? Text(
                                  'Left',
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 1.3,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black38),
                                )
                              : Container(),
                          state.babyTasks[index].rightBreast == 0
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
                    child: Text("${state.babyTasks[index].note}",
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
        index + 1 == state.babyTasks.length
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: primaryColor,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Divider(
                  thickness: 0.8,
                  color: Colors.black38,
                ),
              ),
      ],
    );
  }
}


                //  Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 12, vertical: 12),
                //           child: Row(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Container(
                //                 height: SizeConfig.heightMultiplier * 8,
                //                 width: SizeConfig.widthMultiplier * 18,
                //                 decoration: BoxDecoration(
                //                     color: Color(int.parse(
                //                         state.babyTasks[index].color)),
                //                     shape: BoxShape.circle),
                //                 child: Center(
                //                   child: SvgPicture.asset(
                //                     "assets/icons/${state.babyTasks[index].taskName}.svg",
                //                     height: SizeConfig.heightMultiplier * 4,
                //                   ),
                //                 ),
                //               ),
                //               SizedBox(
                //                 width: SizeConfig.widthMultiplier * 3,
                //               ),
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   Row(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         "${state.babyTasks[index].taskName[0].toUpperCase()}${state.babyTasks[index].taskName.substring(1)}",
                //                         style: TextStyle(
                //                             fontSize:
                //                                 SizeConfig.textMultiplier * 2,
                //                             fontFamily: 'Montserrat',
                //                             fontWeight: FontWeight.w700,
                //                             color: Colors.black38),
                //                       ),
                //                       SizedBox(
                //                         width: SizeConfig.widthMultiplier * 26,
                //                       ),
                //                       Text(
                //                         DateFormat('hh:mm a').format(
                //                             DateTime.parse(state
                //                                 .babyTasks[index].timeStamp)),
                //                         style: TextStyle(
                //                             fontSize:
                //                                 SizeConfig.textMultiplier * 2,
                //                             fontFamily: 'Montserrat',
                //                             // fontWeight: FontWeight.w700,
                //                             color: Colors.black38),
                //                       ),
                //                     ],
                //                   ),
                //                   SizedBox(
                //                       height:
                //                           SizeConfig.heightMultiplier * 1.5),
                //                   Row(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       SvgPicture.asset(
                //                         "assets/icons/ml.svg",
                //                         height: SizeConfig.heightMultiplier * 2,
                //                       ),
                //                       SizedBox(
                //                         width: SizeConfig.widthMultiplier * 3,
                //                       ),
                //                       Text(
                //                         '80 ml',
                //                         style: TextStyle(
                //                             fontSize:
                //                                 SizeConfig.textMultiplier * 2,
                //                             fontFamily: 'Montserrat',
                //                             // fontWeight: FontWeight.w700,
                //                             color: Colors.black38),
                //                       ),
                //                     ],
                //                   ),
                //                   SizedBox(
                //                     width: SizeConfig.heightMultiplier * 2,
                //                   ),
                //                   SizedBox(
                //                     width: 190,
                //                     child: Text(
                //                         "${state.babyTasks[index].note}",
                //                         maxLines: 1,
                //                         overflow: TextOverflow.ellipsis,
                //                         softWrap: false,
                //                         style: TextStyle(
                //                             fontSize:
                //                                 SizeConfig.textMultiplier * 2,
                //                             fontFamily: 'Montserrat',
                //                             // fontWeight: FontWeight.w700,
                //                             color: Colors.black38)),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //         index + 1 == state.babyTasks.length
                //             ? Padding(
                //                 padding:
                //                     const EdgeInsets.symmetric(horizontal: 14),
                //                 child: Divider(
                //                   thickness: 0.8,
                //                   color: primaryColor,
                //                 ),
                //               )
                //             : Padding(
                //                 padding:
                //                     const EdgeInsets.symmetric(horizontal: 14),
                //                 child: Divider(
                //                   thickness: 0.8,
                //                   color: Colors.black38,
                //                 ),
                //               ),
                //       ],
                //     );
   