import 'package:flutter/material.dart';
import 'package:momnotebook/constants/customAppBar.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

class AddBaby extends StatelessWidget {
  const AddBaby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/images/baby_1.png",
              height: SizeConfig.imageSizeMultiplier * 74,
              width: SizeConfig.imageSizeMultiplier * 74,
            ),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 2,
          ),
          Center(
            child: Text(
              "Tell us a little bit about your baby",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.widthMultiplier * 8),
            child: DefaultButtonBsz(
              text: 'Add My Baby',
              press: () => Navigator.of(context).pushNamed('/add_baby_form'),
            ),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier * 4,
          ),
        ],
      ),
    );
  }
}
