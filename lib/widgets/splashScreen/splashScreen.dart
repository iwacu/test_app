import 'package:flutter/material.dart';
import 'package:momnotebook/constants/animations.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/services/database/database_helper.dart';
import 'package:momnotebook/widgets/splashScreen/splash_content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "Recognize Daily Patterns",
      "text":
          "Recognize your child's daily patterns, \nSet reminders and enjoy easier \nparenting.",
      "image": "assets/images/splash_1.png"
    },
    {
      "title": "Tracking Everything",
      "text":
          "Record your child's daily care, \nmilestones and precious memories \nall in one place.",
      "image": "assets/images/splash_2.png"
    },
    {
      "title": "Add Caregivers",
      "text":
          "Share with partner and family \nmembers and add multiple children.",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: SizeConfig.heightMultiplier * 4,
              ),
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    title: splashData[index]["title"],
                    image: splashData[index]["image"],
                    text: splashData[index]['text'],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 8),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(),
                      DefaultButton(
                          text: 'Start',
                          press: () async {
                            var user = await DatabaseHelper.instance.getUser();
                            if (user.object == null) {
                              Navigator.of(context).pushNamed('/sign_up');
                            } else {
                              Navigator.of(context)
                                  .pushNamed('/home_dashboard');
                            }
                          }),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
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

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? greyOrange : greyColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
