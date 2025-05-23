import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wallet_flutter/model/WalletAppModel.dart';
import 'package:wallet_flutter/screen/WALoginScreen.dart';
import 'package:wallet_flutter/utils/WAColors.dart';
import 'package:wallet_flutter/utils/WADataGenerator.dart';

class WAWalkThroughScreen extends StatefulWidget {
  static String tag = '/WAWalkThroughScreen';

  @override
  WAWalkThroughScreenState createState() => WAWalkThroughScreenState();
}

class WAWalkThroughScreenState extends State<WAWalkThroughScreen> {
  PageController pageController = PageController();
  List<WAWalkThroughModel> list = waWalkThroughList();

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(Colors.transparent, statusBarIconBrightness: Brightness.dark);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(WAPrimaryColor, statusBarIconBrightness: Brightness.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            Text('SKIP', style: boldTextStyle(size: 14)).onTap(() {
              WALoginScreen().launch(context);
            }).paddingOnly(top: 16, right: 16),
          ],
        ),
       // backgroundColor: Colors.white,
        body: Container(
          width: context.width(),
          height: context.height(),
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 400,
                  width: context.width(),
                  child: PageView(
                    controller: pageController,
                    children: list.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            e.image.validate(),
                            fit: BoxFit.cover,
                            width: 250,
                            height: 250,
                          ),
                          Text(e.title.validate(), style: boldTextStyle(size: 20)).paddingOnly(left: 16, right: 16),
                          16.height,
                          Text(e.description.validate(), style: secondaryTextStyle(), textAlign: TextAlign.center).paddingOnly(left: 16, right: 16),
                        ],
                      );
                    }).toList(),
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  ),
                ),
                30.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < list.length; i++) Icon(Icons.add, color: i == currentPage ? WAPrimaryColor : Colors.grey),
                  ],
                ),
                16.height,
                Container(
                  height: 60,
                  width: 60,
                  padding: EdgeInsets.all(18),
                  decoration: boxDecorationWithRoundedCorners(boxShape: BoxShape.circle, backgroundColor: WAPrimaryColor),
                  child: Image.asset('assets/wa_navigate_next.png', color: Colors.white, height: 14, width: 14, fit: BoxFit.cover),
                ).onTap(() {
                  if (currentPage == 2) {
                    WALoginScreen().launch(context);
                  } else {
                    pageController.animateToPage(currentPage + 1, duration: Duration(milliseconds: 300), curve: Curves.linear);
                  }
                }),
              ],
            ),
          ).center(),
        ),
      ),
    );
  }
}
