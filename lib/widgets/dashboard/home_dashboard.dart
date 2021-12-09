import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/customAppBar.dart';
import 'package:momnotebook/constants/data_obj.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/home_page_cubit.dart';
import 'package:momnotebook/widgets/dashboard/dashboard_content/home/home_page.dart';

import 'dashboard_content/growth/growth_page.dart';
import 'dashboard_content/profile_account/profile_page.dart';
import 'dashboard_content/statistics/statistics_page.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _selectedIndex = 1;
  final widgetList = [
    HomePage(
      splashData: DataObj().splashData,
    ),
    StatisticsPage(),
    GrowthPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bluewhite,
      appBar: CustomAppBar(
          height: SizeConfig.heightMultiplier * 9,
          child: _selectedIndex == 3
              ? appBarDashboardAccount(context, 'Account', () {}, () {})
              : appBarDashboard(context, 'Sam', () {}, () {})),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is HomePageInitial) {
            return Center(
              child: Text('loading'),
            );
          } else if (state is HomePageCompleted) {
            print('fffffffffffff : => ${state.babyTasks.length}');

            return IndexedStack(
              index: _selectedIndex,
              children: widgetList,
            );
          }
          return Container();
        },
      ),
      floatingActionButton: _selectedIndex == 0
          ? SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              backgroundColor: buttonBGColor,
              children: [
                SpeedDialChild(
                  child: SvgPicture.asset('assets/icons/sleeping.svg'),
                  label: 'Sleeping',
                  backgroundColor: greenGray,
                  onTap: () => Navigator.of(context).pushNamed('/sleep'),
                ),
                SpeedDialChild(
                  child: SvgPicture.asset('assets/icons/feeder.svg'),
                  label: 'Feeder',
                  backgroundColor: movGray,
                  onTap: () => Navigator.of(context).pushNamed('/feeder'),
                ),
                SpeedDialChild(
                  child: SvgPicture.asset('assets/icons/breast-pumping.svg'),
                  label: 'Breast Pumping',
                  backgroundColor: orGray,
                  onTap: () =>
                      Navigator.of(context).pushNamed('/breast_pumping'),
                ),
                SpeedDialChild(
                  child: SvgPicture.asset('assets/icons/breast-feed.svg'),
                  label: 'Breast Feed',
                  backgroundColor: rsGray,
                  onTap: () => Navigator.of(context).pushNamed('/breast_feed'),
                ),
                SpeedDialChild(
                  child: SvgPicture.asset('assets/icons/food.svg'),
                  label: 'Food',
                  backgroundColor: buttonBGColor,
                  onTap: () => Navigator.of(context).pushNamed('/food'),
                ),
                SpeedDialChild(
                  child: SvgPicture.asset('assets/icons/diaper.svg'),
                  label: 'Diaper',
                  backgroundColor: greenAccGray,
                  onTap: () => Navigator.of(context).pushNamed('/diaper'),
                ),
                SpeedDialChild(
                  child: SvgPicture.asset('assets/icons/walking.svg'),
                  label: 'Walking',
                  backgroundColor: jnAccGray,
                  onTap: () => Navigator.of(context).pushNamed('/walk'),
                ),
              ],
            )
          : Container(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedFontSize: 16,
            onTap: (index) => setState(() => _selectedIndex = index),
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/md-home.svg',
                    color: _selectedIndex == 0 ? buttonBGColor : Colors.black38,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        color: _selectedIndex == 0
                            ? buttonBGColor
                            : Colors.black38,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  )),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/chart-pie.svg',
                    color: _selectedIndex == 1 ? buttonBGColor : Colors.black38,
                  ),
                  title: Text(
                    "Statistics",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        color: _selectedIndex == 1
                            ? buttonBGColor
                            : Colors.black38,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  )),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/growth.svg',
                    color: _selectedIndex == 2 ? buttonBGColor : Colors.black38,
                  ),
                  title: Text(
                    "Growth",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        color: _selectedIndex == 2
                            ? buttonBGColor
                            : Colors.black38,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  )),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/user-alt.svg',
                    color: _selectedIndex == 3 ? buttonBGColor : Colors.black38,
                  ),
                  title: Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2,
                        color: _selectedIndex == 3
                            ? buttonBGColor
                            : Colors.black38,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
