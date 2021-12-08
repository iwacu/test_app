import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
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
              Container(
                height: SizeConfig.heightMultiplier * 18,
                decoration: BoxDecoration(color: bluewhite),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: SizeConfig.widthMultiplier * 73,
                      child: CustomPaint(
                        child: Container(),
                        painter: TimelinePainter(),
                      ),
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: SizeConfig.heightMultiplier * 8,
                              width: SizeConfig.widthMultiplier * 18,
                              decoration: BoxDecoration(
                                  color: movGray, shape: BoxShape.circle),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/icons/feeder.svg",
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
                                      'Feeder',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black38),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 26,
                                    ),
                                    Text(
                                      DateFormat('hh:mm a').format(_todayDate),
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Montserrat',
                                          // fontWeight: FontWeight.w700,
                                          color: Colors.black38),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: SizeConfig.heightMultiplier * 1.5),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/ml.svg",
                                      height: SizeConfig.heightMultiplier * 2,
                                    ),
                                    SizedBox(
                                      width: SizeConfig.widthMultiplier * 3,
                                    ),
                                    Text(
                                      '80 ml',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Montserrat',
                                          // fontWeight: FontWeight.w700,
                                          color: Colors.black38),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: SizeConfig.heightMultiplier * 2,
                                ),
                                SizedBox(
                                  width: 190,
                                  child: Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 2,
                                          fontFamily: 'Montserrat',
                                          // fontWeight: FontWeight.w700,
                                          color: Colors.black38)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Divider(
                          thickness: 0.8,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
