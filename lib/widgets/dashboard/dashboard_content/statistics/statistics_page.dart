import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_content/statistics/timeLineChart.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class StatisticsPage extends StatefulWidget {
  final List<Map<String, dynamic>> splashData;
  const StatisticsPage({Key? key, required this.splashData}) : super(key: key);

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  DateTime? _startTime;
  DateTime? _endTime;

  int _mday = 0,
      _tday = 0,
      _wday = 0,
      _thay = 0,
      _fday = 0,
      _satday = 0,
      _sunday = 0;
  int _year = DateTime.now().year;
  DateTime _dateTime = DateTime.now();

  final List<int> _years = [
    2021,
    2022,
    2023,
    2024,
    2025,
    2026,
    2027,
    2028,
    2029,
    2030,
    2031,
    2032,
    2033,
    2034,
    2035,
    2036,
    2037,
    2038,
    2039,
    2040,
  ];

  @override
  void initState() {
    super.initState();
    _getWeekDates(DateTime.now().weekday, DateTime.now().day, DateTime.now());
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
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Container(
                          width: SizeConfig.widthMultiplier * 20,
                          child: DropdownButtonFormField<int>(
                            onChanged: (value) {
                              print(value);
                            },
                            hint: Text(
                              '$_year',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontFamily: 'Montserrat',
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w500),
                            ),
                            items: _years.map(
                              (val) {
                                return DropdownMenuItem<int>(
                                  child: Text(val.toString()),
                                  value: val,
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        SizedBox(width: SizeConfig.widthMultiplier * 16),
                        Text(
                          'Timeline',
                          style: TextStyle(
                              fontSize: SizeConfig.textMultiplier * 3,
                              color: Colors.black38,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  _scrollTasks(),
                  // _scrollDates(),
                  _scrollableDates(),
                  _timeLineChart(),
                  Text('.')
                ],
              ),
            )));
  }

  _scrollTasks() {
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Container(
        height: SizeConfig.heightMultiplier * 18,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.splashData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Container(
                  height: SizeConfig.heightMultiplier * 8,
                  width: SizeConfig.widthMultiplier * 12,
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
              );
            }),
      ),
    );
  }

  _scrollDates() {
    return Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Container(
          child: DatePicker(
            DateTime.now(),
            // height: SizeConfig.heightMultiplier * 14,
            // width: SizeConfig.widthMultiplier * 1,
            initialSelectedDate: DateTime.now(),
            onDateChange: (value) {
              print(value);
            },
            selectionColor: buttonBGColor,
            selectedTextColor: primaryColor,
            dateTextStyle: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                color: Colors.black38),
          ),
        ));
  }

  _scrollableDates() {
    return Padding(
        padding: const EdgeInsets.only(left: 32),
        child: WeeklyDatePicker(
            enableWeeknumberText: false,
            selectedBackgroundColor: buttonBGColor,
            selectedDigitColor: primaryColor,
            selectedDay: _dateTime,
            changeDay: (value) {
              setState(() => _dateTime = value);
              _getWeekDates(value.weekday, value.day, value);
            }));
  }

  _getWeekDates(int weekDay, int day, DateTime time) {
    switch (weekDay) {
      case 1:
        {
          _mday = day;
          _tday = day + 1;
          _wday = day + 2;
          _thay = day + 3;
          _fday = day + 4;
          _satday = day + 5;
          _sunday = day + 6;

          _startTime = time;
          _endTime = time.add(Duration(days: 6));
          print(
              ' Start time :: ${_startTime.toString()},_end time :: ${_endTime.toString()} Monday :: $_mday\n Tuesday::$_tday\n Wend::$_wday\n Thday::$_thay\n frday::$_fday\n satday::$_satday\n sunday::$_sunday\n');
        }
        break;
      case 2:
        {
          _mday = day - 1;
          _tday = day;
          _wday = day + 1;
          _thay = day + 2;
          _fday = day + 3;
          _satday = day + 4;
          _sunday = day + 5;
          _startTime = time;
          _startTime = time.subtract(Duration(days: 1));
          _endTime = time.add(Duration(days: 5));
          print(
              ' Start time :: ${_startTime.toString()},_end time :: ${_endTime.toString()} Monday :: $_mday\n Tuesday::$_tday\n Wend::$_wday\n Thday::$_thay\n frday::$_fday\n satday::$_satday\n sunday::$_sunday\n');
        }

        break;
      case 3:
        {
          _mday = day - 2;
          _tday = day - 1;
          _wday = day;
          _thay = day + 1;
          _fday = day + 2;
          _satday = day + 3;
          _sunday = day + 4;
          _startTime = time.subtract(Duration(days: 2));
          _endTime = time.add(Duration(days: 4));
          print(
              ' Start time :: ${_startTime.toString()},_end time :: ${_endTime.toString()} Monday :: $_mday\n Tuesday::$_tday\n Wend::$_wday\n Thday::$_thay\n frday::$_fday\n satday::$_satday\n sunday::$_sunday\n');
        }

        break;
      case 4:
        {
          _mday = day - 3;
          _tday = day - 2;
          _wday = day - 1;
          _thay = day;
          _fday = day + 1;
          _satday = day + 2;
          _sunday = day + 3;
          _startTime = time.subtract(Duration(days: 3));
          _endTime = time.add(Duration(days: 3));
          print(
              ' Start time :: ${_startTime.toString()},_end time :: ${_endTime.toString()} Monday :: $_mday\n Tuesday::$_tday\n Wend::$_wday\n Thday::$_thay\n frday::$_fday\n satday::$_satday\n sunday::$_sunday\n');
        }

        break;
      case 5:
        {
          _mday = day - 4;
          _tday = day - 3;
          _wday = day - 2;
          _thay = day - 1;
          _fday = day;
          _satday = day + 1;
          _sunday = day + 2;
          _startTime = time.subtract(Duration(days: 4));
          _endTime = time.add(Duration(days: 2));
          print(
              ' Start time :: ${_startTime.toString()},_end time :: ${_endTime.toString()} Monday :: $_mday\n Tuesday::$_tday\n Wend::$_wday\n Thday::$_thay\n frday::$_fday\n satday::$_satday\n sunday::$_sunday\n');
        }

        break;
      case 6:
        {
          _mday = day - 5;
          _tday = day - 4;
          _wday = day - 3;
          _thay = day - 2;
          _fday = day - 1;
          _satday = day;
          _sunday = day + 1;
          _startTime = time.subtract(Duration(days: 5));
          _endTime = time.add(Duration(days: 1));
          print(
              ' Start time :: ${_startTime.toString()},_end time :: ${_endTime.toString()} Monday :: $_mday\n Tuesday::$_tday\n Wend::$_wday\n Thday::$_thay\n frday::$_fday\n satday::$_satday\n sunday::$_sunday\n');
        }

        break;
      case 7:
        {
          _mday = day - 6;
          _tday = day - 5;
          _wday = day - 4;
          _thay = day - 3;
          _fday = day - 2;
          _satday = day - 1;
          _sunday = day;
          _startTime = time.subtract(Duration(days: 6));
          _endTime = time;
          print(
              ' Start time :: ${_startTime.toString()}, _end time :: ${_endTime.toString()}, Monday :: $_mday\n Tuesday::$_tday\n Wend::$_wday\n Thday::$_thay\n frday::$_fday\n satday::$_satday\n sunday::$_sunday\n');
        }

        break;
      default:
    }
  }

  _timeLineChart() {
    return BlocBuilder<HomePageCubit, HomePageState>(
      builder: (context, state) {
        if (state is HomePageInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomePageCompleted) {
          return Container(
            width: SizeConfig.widthMultiplier * 100,
            height: SizeConfig.heightMultiplier * 90,
            child: CustomPaint(
              child: Container(),
              painter: TimeLineChart(_startTime!,
                  _endTime!.add(Duration(days: 1)), state.babyTasks, _dateTime),
            ),
          );
        }
        return Container();
      },
    );
  }
}
