import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wallet_flutter/component/WASelectBankComponent.dart';
import 'package:wallet_flutter/component/WASendViaComponent.dart';
import 'package:wallet_flutter/model/WalletAppModel.dart';
import 'package:wallet_flutter/screen/WATopUpReceiptScreen.dart';
import 'package:wallet_flutter/utils/WAColors.dart';
import 'package:wallet_flutter/utils/WADataGenerator.dart';
import 'package:wallet_flutter/utils/WAWidgets.dart';
import 'package:wallet_flutter/utils/widgets/slider.dart';

class WATopUPCardScreen extends StatefulWidget {
  static String tag = '/WATopUPCardScreen';

  @override
  WATopUPCardScreenState createState() => WATopUPCardScreenState();
}

class WATopUPCardScreenState extends State<WATopUPCardScreen> {
  TextEditingController amountController = TextEditingController(text: "\u002450");
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController pinController = TextEditingController();

  FocusNode cardFocusNode = FocusNode();
  FocusNode pinFocusNode = FocusNode();

  List<WACardModel> sendViaCardList = waSendViaCardList();
  WACardModel selectedCard = WACardModel();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    selectedCard = sendViaCardList[0];
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
          title: Text('Top Up to Card', style: boldTextStyle(color: Colors.black, size: 20)),
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
          elevation: 0.0, systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        body: Container(
          height: context.height(),
          width: context.width(),
          padding: EdgeInsets.only(top: 60),
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.height,
                Text('Select Bank', style: boldTextStyle(size: 18)).paddingLeft(16),
                WASelectBankComponent(),
                Text('Select Card', style: boldTextStyle(size: 18)).paddingLeft(16),
                8.height,
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(left: 16, right: 16),
                  width: context.width(),
                  decoration: boxDecorationRoundedWithShadow(16),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: selectedCard,
                      items: sendViaCardList.map((item) {
                        return DropdownMenuItem<WACardModel>(
                          value: item,
                          child: WASendViaComponent(item: item),
                        );
                      }).toList(),
                      onChanged: (WACardModel? value) {
                        selectedCard = value!;
                        setState(() {});
                      },
                    ),
                  ),
                ),
                16.height,
                Text('Amount', style: boldTextStyle(size: 18)).paddingLeft(16),
                AppTextField(
                  controller: amountController,
                  autoFocus: false,
                  textAlign: TextAlign.center,
                  textFieldType: TextFieldType.OTHER,
                  keyboardType: TextInputType.number,
                  textStyle: TextStyle(fontSize: 22),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))),
                  ),
                ).paddingOnly(left: 16, right: 16),
                16.height,
                Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 16,
                  children: List.generate(
                    amountList.length,
                    (index) {
                      return Container(
                        decoration: boxDecorationWithRoundedCorners(backgroundColor: WAPrimaryColor.withOpacity(0.2), borderRadius: BorderRadius.circular(18)),
                        padding: EdgeInsets.only(left: 22, right: 22, top: 8, bottom: 8),
                        child: Text('\u0024${amountList[index]}', style: secondaryTextStyle(color: WAPrimaryColor)),
                      ).onTap(
                        () {
                          amountController.text = amountList[index]!;
                          setState(() {});
                        },
                      );
                    },
                  ),
                ).center(),
                16.height,
                Text("Card Number", style: boldTextStyle(size: 18)).paddingLeft(16),
                16.height,
                AppTextField(
                  autoFocus: false,
                  decoration: waInputDecoration(hint: "Enter your card number", bgColor: Colors.white, borderColor: Colors.grey),
                  textFieldType: TextFieldType.NAME,
                  keyboardType: TextInputType.name,
                  controller: cardNumberController,
                  focus: cardFocusNode,
                ).paddingOnly(left: 16, right: 16),
                16.height,
                Text("Pin", style: boldTextStyle(size: 18)).paddingLeft(16),
                AppTextField(
                  autoFocus: false,
                  decoration: waInputDecoration(hint: "Enter the PIN No. here", bgColor: Colors.white, borderColor: Colors.grey),
                  textFieldType: TextFieldType.OTHER,
                  keyboardType: TextInputType.number,
                  controller: pinController,
                  focus: pinFocusNode,
                ).paddingOnly(left: 16, right: 16),
                16.height,
                SliderButton(
                  buttonSize: 50,
                  backgroundColor: WAPrimaryColor,
                  dismissible: false,
                  action: () {
                    WATopUpReceiptScreen(card: selectedCard).launch(context);
                  },
                  label: Text("Swipe for Top Up", style: boldTextStyle()),
                  icon: Icon(Icons.arrow_forward, color: WAPrimaryColor),
                ).paddingOnly(top: 16, bottom: 16).center(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
