import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momnotebook/bloc/bloc/form_saving_bloc.dart';
import 'package:momnotebook/bloc/form_submission/form_sub.dart';
import 'package:momnotebook/constants/customAppBar.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/show_snackBar.dart';
import 'package:momnotebook/constants/sizeConfig.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  // int currentPage = 0;
  // List<Map<String, dynamic>> splashData = [
  //   {
  //     "title": "Add your name",
  //     "text": "First and Last name",
  //     "image": "assets/images/signUp_1.png",
  //     "arr": [],
  //   },
  //   {
  //     "title": "Sign up with your email",
  //     "text": "name@example.com",
  //     "image": "assets/images/signUp_2.png",
  //     "arr": [],
  //   },
  //   {
  //     "title": "Create your password",
  //     "text": "Atleast 8 characters",
  //     "image": "assets/images/signUp_3.png",
  //     "arr": [
  //       '8 characters minimum',
  //       'At least one number',
  //       'Upper & lowercase character'
  //     ],
  //   },
  // ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FormSavingBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            height: SizeConfig.heightMultiplier * 9,
            child: appBar(context, '', () {})),
        body: BlocListener<FormSavingBloc, FormSavingState>(
          listener: (context, state) {
            final formStatus = state.formSubmissionStatus;
            if (formStatus is SubmissionSuccess) {
              showSnackBar(context, formStatus.message);
              Navigator.of(context).pushNamed('/add_baby');
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),

                  SizedBox(
                    height: SizeConfig.heightMultiplier * 3,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/signUp_1.png",
                      height: SizeConfig.imageSizeMultiplier * 34,
                      width: SizeConfig.imageSizeMultiplier * 34,
                    ),
                  ),
                  // Spacer(flex: 2),
                  Center(
                    child: Text(
                      "Add your name",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 2.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 94),
                    child: BlocBuilder<FormSavingBloc, FormSavingState>(
                      builder: (context, state) {
                        return TextFormField(
                            validator: (value) => state.isValidUsername
                                ? null
                                : 'Enter your First and Last name',
                            onChanged: (val) {
                              context
                                  .read<FormSavingBloc>()
                                  .add(UserNameChanged(val));
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "First and Last name",
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.heightMultiplier * 32,
                  ),
                  Center(
                    child: BlocBuilder<FormSavingBloc, FormSavingState>(
                      builder: (context, state) {
                        return state.formSubmissionStatus is FormSubmitting
                            ? Center(child: CircularProgressIndicator())
                            : DefaultButton(
                                text: 'Save',
                                press: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<FormSavingBloc>()
                                        .add(SubmitForm());
                                  }
                                });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // AnimatedContainer buildDot({int? index}) {
  //   return AnimatedContainer(
  //     duration: kAnimationDuration,
  //     margin: EdgeInsets.only(right: 5),
  //     height: 6,
  //     width: currentPage == index ? 20 : 6,
  //     decoration: BoxDecoration(
  //       color: currentPage == index ? buttonBGColor : greyColor,
  //       borderRadius: BorderRadius.circular(3),
  //     ),
  //   );
  // }
}


//  Container(
//                   width: double.infinity,
//                   height: SizeConfig.heightMultiplier * 54,
//                   child: PageView.builder(
//                     onPageChanged: (value) {
//                       setState(() {
//                         currentPage = value;
//                       });
//                     },
//                     itemCount: splashData.length,
//                     itemBuilder: (context, index) => SignUpContent(
//                       text: splashData[index]['text'],
//                       title: splashData[index]["title"],
//                       image: splashData[index]["image"],
//                       arr: splashData[index]["arr"],
//                     ),
//                   ),
//                 ),