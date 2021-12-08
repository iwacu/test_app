import 'package:flutter/material.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
              SizedBox(
                height: SizeConfig.heightMultiplier * 4,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Babies',
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 2.5,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          color: Colors.black38),
                    ),
                    Spacer(),
                    Icon(
                      Icons.add,
                      color: buttonBGColor,
                      size: SizeConfig.imageSizeMultiplier * 3,
                    ),
                    SizedBox(
                      width: SizeConfig.widthMultiplier * 1.3,
                    ),
                    Text(
                      'Add Baby',
                      style: TextStyle(
                          fontSize: SizeConfig.textMultiplier * 2,
                          fontFamily: 'Montserrat',
                          color: buttonBGColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: buttonBGColor)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
                          height: SizeConfig.heightMultiplier * 6,
                          width: SizeConfig.widthMultiplier * 10,
                          decoration: BoxDecoration(
                            // color: kSecondaryColor.withOpacity(0.1),
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/user_icon.png')),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.widthMultiplier * 6,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Sam',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2.5,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                            ),
                            Text(
                              '2y 5month 2dys',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black38),
                            )
                          ],
                        ),
                        Spacer(),
                        Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: SizeConfig.heightMultiplier * 5,
                                width: SizeConfig.widthMultiplier * 7,
                                decoration: BoxDecoration(
                                  // color: kSecondaryColor.withOpacity(0.1),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/add_pctr.png')),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 1,
                              left: 0,
                              child: Container(
                                height: SizeConfig.heightMultiplier * 2.5,
                                width: SizeConfig.widthMultiplier * 4.5,
                                decoration: BoxDecoration(
                                  color: buttonBGColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: primaryColor,
                                  size: SizeConfig.heightMultiplier * 2,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  'Preferences',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.5,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.black38),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: ggrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 22),
                              child: Text(
                                'Language',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                  ),
                                  hint: Text(
                                    'English',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.4,
                                        fontFamily: 'Montserrat',
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  items: []),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          thickness: 0.3,
                          color: Colors.black38,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 22),
                              child: Text(
                                'Show Notifications',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                  ),
                                  hint: Text(
                                    'Daily',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.4,
                                        fontFamily: 'Montserrat',
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  items: []),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 3,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  'Growth Units',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 2.5,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600,
                      color: Colors.black38),
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
                    color: ggrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 22),
                              child: Text(
                                'Weight',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                  ),
                                  hint: Text(
                                    'Kilogram(kg)',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.4,
                                        fontFamily: 'Montserrat',
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  items: []),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Divider(
                          thickness: 0.3,
                          color: Colors.black38,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 22),
                              child: Text(
                                'Height',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 1.8,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38),
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: InputBorder.none,
                                  ),
                                  hint: Text(
                                    'Centimeter (cm)',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.textMultiplier * 1.4,
                                        fontFamily: 'Montserrat',
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  items: []),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
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
