import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

import 'boxIcon.dart';

appBar(BuildContext context, String text, GestureTapCallback press) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BoxIcon(
            svgSrc: 'assets/icons/back-icon.svg',
            numOfitem: 0,
            press: () => Navigator.pop(context),
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2.3,
                fontFamily: 'Muli',
                color: Colors.black38),
          ),
        ],
      ),
    ),
  );
}

appBarM(BuildContext context, String text, GestureTapCallback press,
    GestureTapCallback reset) {
  return SafeArea(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BoxIcon(
            svgSrc: 'assets/icons/back-icon.svg',
            numOfitem: 0,
            press: () => Navigator.pop(context),
          ),
          SizedBox(
            width: SizeConfig.widthMultiplier * 6,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: SizeConfig.textMultiplier * 3,
                  fontFamily: 'Montserrat',
                  color: Colors.black38),
            ),
          ),
          Spacer(),
          BoxIcon(
            svgSrc: 'assets/icons/delete-icon.svg',
            numOfitem: 0,
            press: () => Navigator.pop(context),
          )
        ],
      ),
    ),
  );
}

appBarDashboard(BuildContext context, String text, GestureTapCallback press,
    GestureTapCallback reset) {
  return Container(
    color: Colors.white,
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
              height: SizeConfig.heightMultiplier * 6,
              width: SizeConfig.widthMultiplier * 10,
              decoration: BoxDecoration(
                // color: kSecondaryColor.withOpacity(0.1),
                image: DecorationImage(
                    image: AssetImage('assets/images/user_icon.png')),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 6,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 3,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    color: Colors.black38),
              ),
            ),
            Spacer(),
            BoxIcon(
              svgSrc: 'assets/icons/search.svg',
              numOfitem: 0,
              press: () => Navigator.pop(context),
            ),
            BoxIcon(
              svgSrc: 'assets/icons/notification.svg',
              numOfitem: 0,
              press: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    ),
  );
}

appBarDashboardAccount(BuildContext context, String text,
    GestureTapCallback press, GestureTapCallback reset) {
  return Container(
    color: Colors.white,
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: SizeConfig.textMultiplier * 3,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                color: Colors.black38),
          ),
        ),
      ),
    ),
  );
}

appBarDashboardW(BuildContext context, String text, GestureTapCallback press,
    GestureTapCallback reset) {
  return Container(
    color: Colors.white,
    child: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BoxIcon(
              svgSrc: 'assets/icons/back-icon.svg',
              numOfitem: 0,
              press: () => Navigator.pop(context),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 6,
            ),
            Container(
              padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
              height: SizeConfig.heightMultiplier * 6,
              width: SizeConfig.widthMultiplier * 10,
              decoration: BoxDecoration(
                // color: kSecondaryColor.withOpacity(0.1),
                image: DecorationImage(
                    image: AssetImage('assets/images/user_icon.png')),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: SizeConfig.widthMultiplier * 6,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                text,
                style: TextStyle(
                    fontSize: SizeConfig.textMultiplier * 3,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w700,
                    color: Colors.black38),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class CustomAppBar extends PreferredSize {
  @override
  final Widget child;
  final double height;

  CustomAppBar({
    required this.height,
    required this.child,
  }) : super(child: child, preferredSize: Size.fromHeight(height));

  @override
  Widget build(BuildContext context) => child;
}
