import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/customAppBar.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';

class HomeBreastFeed extends StatefulWidget {
  HomeBreastFeed({Key? key}) : super(key: key);

  @override
  State<HomeBreastFeed> createState() => _HomeBreastFeedState();
}

class _HomeBreastFeedState extends State<HomeBreastFeed> {
  DateTime _nowDate = DateTime.now();
  final _text = TextEditingController();
  bool _left = false;
  bool _right = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bluewhite,
      appBar: CustomAppBar(
          height: SizeConfig.heightMultiplier * 9,
          child: appBarDashboardW(context, 'Sam', () {}, () {})),
      body: Container(
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
                      height: SizeConfig.heightMultiplier * 18,
                      width: SizeConfig.widthMultiplier * 28,
                      decoration:
                          BoxDecoration(color: rsGray, shape: BoxShape.circle),
                      child: Center(
                        child: SvgPicture.asset('assets/icons/breast-feed.svg',
                            height: SizeConfig.heightMultiplier * 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 4,
                ),
                Center(
                  child: Text(
                    'Breast Feed',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 3,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        color: Colors.black38),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Center(
                  child: Text(
                    'In Progress',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w200,
                        color: Colors.black38),
                  ),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _left = true;
                                _right = false;
                              });
                            },
                            child: Container(
                              height: SizeConfig.heightMultiplier * 8,
                              width: SizeConfig.widthMultiplier * 36,
                              decoration: BoxDecoration(
                                  color: _left ? rsGray : primaryColor,
                                  border: Border.all(color: rsGray),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  'Left',
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 2.5,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300,
                                      color: _left
                                          ? primaryColor
                                          : Colors.black38),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _right = true;
                                _left = false;
                              });
                            },
                            child: Container(
                              height: SizeConfig.heightMultiplier * 8,
                              width: SizeConfig.widthMultiplier * 36,
                              decoration: BoxDecoration(
                                  color: _right ? rsGray : primaryColor,
                                  border: Border.all(color: rsGray),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  'Right',
                                  style: TextStyle(
                                      fontSize: SizeConfig.textMultiplier * 2.5,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w300,
                                      color: _right
                                          ? primaryColor
                                          : Colors.black38),
                                ),
                              ),
                            ),
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
                          GestureDetector(
                            onTap: () => _showDatePicker(context),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: greyColor)),
                              child: Text(
                                Jiffy(_nowDate).MMMEd,
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.widthMultiplier * 2,
                          ),
                          GestureDetector(
                            onTap: () => _showTimePicker(context),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: greyColor)),
                              child: Text(
                                '10:40 Am',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w500),
                              ),
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
                  height: SizeConfig.heightMultiplier * 12,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 8),
                  child: DefaultButtonBsz(
                    text: 'Save',
                    press: () {
                      var di = rsGray.toString();
                      print(di);
                      const start = "Color(";
                      const end = ")";

                      final startIndex = di.indexOf(start);
                      final endIndex =
                          di.indexOf(end, startIndex + start.length);
                      var fnl =
                          di.substring(startIndex + start.length, endIndex);
                      BlocProvider.of<HomePageCubit>(context).saveTasksBF(
                          note: _text.text,
                          foodGroup: '',
                          color: fnl,
                          amount: '',
                          left: _left,
                          right: _right,
                          amountScale: '',
                          duration: Duration(),
                          taskName: 'breast-feed');
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: DateTime(2018, 1, 1),
                        onDateTimeChanged: (val) {
                          setState(() {
                            _nowDate = val;
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  void _showTimePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 400,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        onDateTimeChanged: (val) {
                          print(val);
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }
}
