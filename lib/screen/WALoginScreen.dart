import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wallet_flutter/screen/WARegisterScreen.dart';
import 'package:wallet_flutter/utils/WAColors.dart';
import 'package:wallet_flutter/utils/WAWidgets.dart';

import 'WAEditProfileScreen.dart';

class WALoginScreen extends StatefulWidget {
  static String tag = '/WALoginScreen';

  @override
  WALoginScreenState createState() => WALoginScreenState();
}

class WALoginScreenState extends State<WALoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passWordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {}

  @override
  void dispose() {
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
        body: Container(
          width: context.width(),
          height: context.height(),
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                50.height,
                Text("Log In", style: boldTextStyle(size: 24)),
                Container(

                  margin: EdgeInsets.all(16),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Container(
                        width: context.width(),
                        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                        margin: EdgeInsets.only(top: 55.0),
                        decoration: boxDecorationWithShadow(
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Text("Email", style: boldTextStyle(size: 14)),
                                  8.height,
                                  AppTextField(
                                    decoration: waInputDecoration(hint: 'Enter your email here', prefixIcon: Icons.email_outlined),
                                    textFieldType: TextFieldType.EMAIL,
                                    keyboardType: TextInputType.emailAddress,
                                    controller: emailController,
                                    focus: emailFocusNode,
                                    nextFocus: passWordFocusNode,
                                  ),
                                  16.height,
                                  Text("Password", style: boldTextStyle(size: 14)),
                                  8.height,
                                  AppTextField(
                                    decoration: waInputDecoration(hint: 'Enter your password here', prefixIcon: Icons.lock_outline),
                                    suffixIconColor: WAPrimaryColor,
                                    textFieldType: TextFieldType.PASSWORD,
                                    isPassword: true,
                                    keyboardType: TextInputType.visiblePassword,
                                    controller: passwordController,
                                    focus: passWordFocusNode,
                                  ),
                                  16.height,
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text("Forgot password?", style: primaryTextStyle()),
                                  ),
                                  30.height,
                                  AppButton(
                                      text: "Log In",
                                      color: WAPrimaryColor,
                                      textColor: Colors.white,
                                      shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      width: context.width(),
                                      onTap: () {
                                        WAEditProfileScreen(isEditProfile: false).launch(context);
                                      }).paddingOnly(left: context.width() * 0.1, right: context.width() * 0.1),
                                  30.height,
                                  Container(
                                    width: 200,
                                    child: Row(
                                      children: [
                                        Divider(thickness: 2).expand(),
                                        8.width,
                                        Text('or', style: boldTextStyle(size: 16, color: Colors.grey)),
                                        8.width,
                                        Divider(thickness: 2).expand(),
                                      ],
                                    ),
                                  ).center(),
                                  30.height,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: boxDecorationRoundedWithShadow(16),
                                        padding: EdgeInsets.all(16),
                                        child: Image.asset('assets/wa_facebook.png', width: 40, height: 40),
                                      ),
                                      30.width,
                                      Container(
                                        decoration: boxDecorationRoundedWithShadow(16),
                                        padding: EdgeInsets.all(16),
                                        child: Image.asset('assets/wa_google_logo.png', width: 40, height: 40),
                                      ),
                                    ],
                                  ).center(),
                                  30.height,
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Don\'t have an account?', style: primaryTextStyle(color: Colors.grey)),
                                      4.width,
                                      Text('Register here', style: boldTextStyle(color: Colors.black)),
                                    ],
                                  ).onTap(() {
                                    WARegisterScreen().launch(context);
                                  }).center(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 100,
                        width: 100,
                        decoration: boxDecorationRoundedWithShadow(
                            30),
                        child: Image.asset(
                          'assets/wa_app_logo.png',
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
                16.height,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
