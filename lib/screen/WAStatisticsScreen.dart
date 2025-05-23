import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:wallet_flutter/component/WACategoriesComponent.dart';
import 'package:wallet_flutter/component/WAStatisticsChartComponent.dart';
import 'package:wallet_flutter/component/WAStatisticsComponent.dart';
import 'package:wallet_flutter/model/WalletAppModel.dart';
import 'package:wallet_flutter/utils/WADataGenerator.dart';
import 'package:wallet_flutter/utils/WAWidgets.dart';

class WAStatisticScreen extends StatefulWidget {
  static String tag = '/WAStatisticScreen';

  @override
  WAStatisticScreenState createState() => WAStatisticScreenState();
}

class WAStatisticScreenState extends State<WAStatisticScreen> {
  List<WATransactionModel> categoriesList = waCategoriesList();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: context.width(),
        padding: EdgeInsets.only(top: 50),
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/wa_bg.jpg'), fit: BoxFit.cover)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Statistics', style: boldTextStyle(color: Colors.black, size: 20))),
            16.height,
            WAStatisticsComponent(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Overview', style: boldTextStyle(size: 20)),
                16.height,
                Container(
                  width: 100,
                  height: 50,
                  child: DropdownButtonFormField(
                    value: overViewList[0],
                    isExpanded: true,
                    decoration: waInputDecoration(bgColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: 8)),
                    items: overViewList.map((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value!, style: boldTextStyle(size: 14)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      //
                    },
                  ),
                ),
              ],
            ).paddingOnly(left: 16, right: 16, top: 16),
            WAStatisticsChartComponent(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categories', style: boldTextStyle(size: 20)),
                Icon(Icons.play_arrow, color: Colors.grey),
              ],
            ).paddingOnly(left: 16, right: 16),
            16.height,
            Column(
              children: categoriesList.map((categoryItem) {
                return WACategoriesComponent(categoryModel: categoryItem);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
