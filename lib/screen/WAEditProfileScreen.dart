import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wallet_flutter/utils/WAColors.dart';
import 'package:wallet_flutter/utils/WADataGenerator.dart';
import 'package:wallet_flutter/utils/WAWidgets.dart';

import 'WAAddCreditionalScreen.dart';

class WAEditProfileScreen extends StatefulWidget {
  static String tag = '/WAEditProfileScreen';
  final isEditProfile;

  WAEditProfileScreen({this.isEditProfile});

  @override
  WAEditProfileScreenState createState() => WAEditProfileScreenState();
}

class WAEditProfileScreenState extends State<WAEditProfileScreen> {
  var fullNameController = TextEditingController();
  var contactNumberController = TextEditingController();

  FocusNode fullNameFocusNode = FocusNode();
  FocusNode contactNumberFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
  }

  @override
  void dispose() {
    setStatusBarColor(Colors.white, statusBarIconBrightness: Brightness.dark);
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Edit Profile',
            style: boldTextStyle(color: Colors.black, size: 20),
          ),
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: boxDecorationWithRoundedCorners(
              backgroundColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
            ),
            child: Icon(Icons.arrow_back),
          ).onTap(() {
            finish(context);
          }),
          centerTitle: true,
          scrolledUnderElevation: 0,

          bottomOpacity: 0.0,
          elevation: 0.0,
        ),
        body: Container(
          height: context.height(),
          width: context.width(),
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 80),
                padding: EdgeInsets.only(top: 50, left: 16, right: 16, bottom: 16),
                width: context.width(),
                height: context.height(),
                decoration: boxDecorationWithShadow(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Personal Information', style: boldTextStyle(size: 18)),
                      16.height,
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey.withOpacity(0.2), width: 0.5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Full Name', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your full name here',
                              ),
                              textFieldType: TextFieldType.NAME,
                              keyboardType: TextInputType.name,
                              controller: fullNameController,
                              focus: fullNameFocusNode,
                            ),
                            16.height,
                            Text('Contact Number', style: boldTextStyle(size: 14)),
                            8.height,
                            AppTextField(
                              decoration: waInputDecoration(
                                hint: 'Enter your full name here',
                              ),
                              textFieldType: TextFieldType.PHONE,
                              keyboardType: TextInputType.phone,
                              controller: contactNumberController,
                              focus: contactNumberFocusNode,
                            ),
                            16.height,
                            Text('Date of birth', style: boldTextStyle(size: 14)),
                            8.height,
                            Row(
                              children: [
                                DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: waInputDecoration(hint: "Date"),
                                  items: List.generate(31, (index) {
                                    return DropdownMenuItem(child: Text('${index + 1}', style: secondaryTextStyle()), value: index + 1);
                                  }),
                                  onChanged: (value) {},
                                ).expand(),
                                16.width,
                                DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: waInputDecoration(hint: "Month"),
                                  items: waMonthList.map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value!, style: secondaryTextStyle()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    //
                                  },
                                ).expand(),
                                16.width,
                                DropdownButtonFormField(
                                  isExpanded: true,
                                  decoration: waInputDecoration(hint: "Year"),
                                  items: waYearList.map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value!, style: secondaryTextStyle()),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    //
                                  },
                                ).expand(),
                              ],
                            ),
                            16.height,
                            Text('Gender', style: boldTextStyle()),
                            8.height,
                            DropdownButtonFormField(
                              isExpanded: true,
                              decoration: waInputDecoration(hint: "Select your gender"),
                              items: <String>['Female', 'Male'].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: secondaryTextStyle()),
                                );
                              }).toList(),
                              onChanged: (value) {
                                //
                              },
                            ),
                          ],
                        ),
                      ),
                      16.height,
                      AppButton(
                        color: WAPrimaryColor,
                        width: context.width(),
                        child: Text('Continue', style: boldTextStyle(color: Colors.white)),
                        onTap: () {
                          if (widget.isEditProfile) {
                            finish(context);
                          } else {
                            WAAddCredentialScreen().launch(context);
                          }
                        },
                      ).cornerRadiusWithClipRRect(30).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    height: 110,
                    width: 110,
                    decoration: BoxDecoration(color: WAPrimaryColor.withOpacity(0.2), shape: BoxShape.circle),
                    child: Icon(Icons.person, color: WAPrimaryColor, size: 60),
                  ),
                  Positioned(
                    bottom: 16,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Icon(Icons.edit, color: Colors.white, size: 20),
                      decoration: BoxDecoration(color: WAPrimaryColor, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingTop(60),
        ),
      ),
    );
  }
}
