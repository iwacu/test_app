import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jiffy/jiffy.dart';
import 'package:momnotebook/bloc/bloc/form_saving_bloc.dart';
import 'package:momnotebook/bloc/form_submission/form_sub.dart';
import 'package:momnotebook/constants/colors.dart';
import 'package:momnotebook/constants/customAppBar.dart';
import 'package:momnotebook/constants/defaultButton.dart';
import 'package:momnotebook/constants/show_snackBar.dart';
import 'package:momnotebook/constants/sizeConfig.dart';
import 'package:momnotebook/cubit/cubit/auth_cubit_cubit.dart';
import 'package:path_provider/path_provider.dart';

class AddNewBabyForm extends StatefulWidget {
  const AddNewBabyForm({Key? key}) : super(key: key);

  @override
  State<AddNewBabyForm> createState() => _AddNewBabyFormState();
}

class _AddNewBabyFormState extends State<AddNewBabyForm> {
  int currentBox = 1;
  bool _status = false;
  File? _babyImage;
  File? _saveImage;
  DateTime _nowDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  List<String> _relationships = [
    'Mother',
    'Father',
    'Brother',
    'Siter',
    'Aunt',
    'Uncle',
    'GrandMother',
    'GrandFather'
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocProvider(
        create: (context) => FormSavingBloc(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
              height: SizeConfig.heightMultiplier * 9,
              child: appBarM(context, 'New baby', () {}, () {})),
          body: BlocListener<FormSavingBloc, FormSavingState>(
            listener: (context, state) {
              final formStatus = state.formSubmissionStatus;
              if (formStatus is SubmissionSuccessBaby) {
                showSnackBar(context, 'New Baby added');
                Navigator.pop(context);
              }
            },
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "Complete Baby Profile",
                        // textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 3,
                            color: Colors.black,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      child: Container(
                        height: SizeConfig.heightMultiplier * 64,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: whiteGrey,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: greyColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            _babySex(),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                'Baby Name',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child:
                                  BlocBuilder<FormSavingBloc, FormSavingState>(
                                builder: (context, state) {
                                  return TextFormField(
                                      validator: (value) =>
                                          state.isValidUsername
                                              ? null
                                              : 'Enter Baby Name',
                                      onChanged: (val) {
                                        context
                                            .read<FormSavingBloc>()
                                            .add(UserNameChanged(val));
                                      },
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              new UnderlineInputBorder(
                                                  borderSide: new BorderSide(
                                                      color: greyColor,
                                                      width: 0.8)),
                                          hintText: 'Enter Baby Name'));
                                },
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/birthday-cake.svg',
                                      ),
                                      SizedBox(
                                        width: SizeConfig.widthMultiplier * 2,
                                      ),
                                      Text(
                                        'BirthDay',
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.textMultiplier * 2,
                                            fontFamily: 'Montserrat',
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () => _showDatePicker(context),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: primaryColor,
                                          border:
                                              Border.all(color: Colors.black26),
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          Jiffy(_nowDate).MMMEd,
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.textMultiplier * 2,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 9),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/prmtr-baby.svg',
                                        ),
                                        SizedBox(
                                          width: SizeConfig.widthMultiplier * 2,
                                        ),
                                        Text(
                                          'Premature',
                                          style: TextStyle(
                                              fontSize:
                                                  SizeConfig.textMultiplier * 2,
                                              fontFamily: 'Montserrat',
                                              color: Colors.black38,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  BlocBuilder<FormSavingBloc, FormSavingState>(
                                    builder: (context, state) {
                                      return Switch(
                                          value: _status,
                                          activeTrackColor: buttonBGColor,
                                          activeColor: buttonBGColor,
                                          onChanged: (value) {
                                            setState(() {
                                              _status = value;
                                            });
                                            context.read<FormSavingBloc>().add(
                                                BabyPrematureChanged(
                                                    value ? 0 : 1));
                                          });
                                    },
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                'Relationship With Baby',
                                style: TextStyle(
                                    fontSize: SizeConfig.textMultiplier * 2,
                                    fontFamily: 'Montserrat',
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: BlocBuilder<FormSavingBloc,
                                    FormSavingState>(
                                  builder: (context, state) {
                                    return DropdownButtonFormField<String>(
                                      onChanged: (value) {
                                        context.read<FormSavingBloc>().add(
                                            BabyRelationshipChanged(value!));
                                      },
                                      hint: Text(
                                        'Choose Relationship ',
                                        style: TextStyle(
                                            fontSize:
                                                SizeConfig.textMultiplier * 2,
                                            fontFamily: 'Montserrat',
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      validator: (value) =>
                                          state.isValidbabyRelationship
                                              ? null
                                              : 'Choose Relationship',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: Colors.black,
                                      ),
                                      items: _relationships.map(
                                        (val) {
                                          return DropdownMenuItem<String>(
                                            child: Text(val),
                                            value: val.toString(),
                                          );
                                        },
                                      ).toList(),
                                    );
                                  },
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.widthMultiplier * 8),
                      child: BlocBuilder<FormSavingBloc, FormSavingState>(
                        builder: (context, state) {
                          return state.formSubmissionStatus is FormSubmitting
                              ? Center(child: CircularProgressIndicator())
                              : DefaultButtonBsz(
                                  text: 'Save',
                                  press: () {
                                    //
                                    if (_formKey.currentState!.validate()) {
                                      context.read<FormSavingBloc>().add(
                                          SubmitFormSaveBaby(
                                              _nowDate.toString(),
                                              currentBox == 1 ? 'Boy' : 'Girl',
                                              _saveImage == null
                                                  ? ''
                                                  : _saveImage!.path));
                                      BlocProvider.of<AuthCubitCubit>(context)
                                          .getUser();
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
      ),
    );
  }

  _babySex() {
    return Stack(
      clipBehavior: Clip.antiAlias,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<FormSavingBloc, FormSavingState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentBox = 1;
                      });
                    },
                    child: Container(
                      height: SizeConfig.heightMultiplier * 14,
                      width: SizeConfig.widthMultiplier * 38,
                      decoration: BoxDecoration(
                        color: currentBox == 1 ? buttonBGColor : whiteGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 22, top: 29),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/girl.svg',
                              color:
                                  currentBox == 1 ? primaryColor : Colors.grey,
                            ),
                            Text(
                              "Boy",
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  color: currentBox == 1
                                      ? Colors.white
                                      : Colors.black38,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              BlocBuilder<FormSavingBloc, FormSavingState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentBox = 2;
                      });
                    },
                    child: Container(
                      height: SizeConfig.heightMultiplier * 14,
                      width: SizeConfig.widthMultiplier * 38,
                      decoration: BoxDecoration(
                        color: currentBox == 2 ? greyOrange : whiteGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 22, top: 29),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/boy.svg',
                              color: currentBox == 2
                                  ? Colors.white
                                  : Colors.black38,
                            ),
                            Text(
                              "Girl",
                              // textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 2,
                                  color: currentBox == 2
                                      ? Colors.white
                                      : Colors.black38,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: Container(
              height: SizeConfig.heightMultiplier * 14,
              width: SizeConfig.widthMultiplier * 34,
              decoration: BoxDecoration(
                  color: currentBox == 1 ? buttonBGColor : greyOrange,
                  shape: BoxShape.circle),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    height: SizeConfig.heightMultiplier * 10,
                    width: SizeConfig.widthMultiplier * 28,
                    decoration: BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                    child: Center(
                        child: _babyImage == null
                            ? Image.asset(
                                'assets/images/is.png',
                                height: SizeConfig.heightMultiplier * 3,
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    FileImage(File(_babyImage!.path)),
                                radius: SizeConfig.widthMultiplier * 9,
                                backgroundColor: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _babyImage = File(image!.path);
    });
    // getting a directory path for saving
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    // copy the file to a new path
    _saveImage = await _babyImage!.copy('$path/babyImage.png');
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
}
