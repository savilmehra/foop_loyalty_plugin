
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/bloc/rewards_module/pages/rewards_list_page.dart';
import 'package:foop_loyalty_plugin/utils/app_user_list_tile.dart';
import 'package:foop_loyalty_plugin/utils/customcard.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../cubits/cubit_main.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';

import 'package:foop_loyalty_plugin/utils/text_styling.dart';

class RedemptionSettingPage extends StatefulWidget {

  @override
  _RedemptionSettingPage createState() => _RedemptionSettingPage();
}

class _RedemptionSettingPage extends State<RedemptionSettingPage> {

  @override
  void initState() {
    super.initState();

  }

  late TextStyleElements styleElements;
  late TextEditingController cnt = TextEditingController();
  late TextEditingController newCont = TextEditingController();

  late TextEditingController amountC = TextEditingController();
  late TextEditingController coinC = TextEditingController();
  bool isSwitched =false;
  SharedPreferences? prefs = locatorRewards<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);

    final amountGift = TextField(
      controller: amountC,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onChanged: (text) {},
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context!)!.translate("enter_amt"),
          contentPadding: EdgeInsets.only(left: 12, top: 16, bottom: 8),
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: AppLocalizations.of(context!)!.translate("enter_amt")),
    );



    final coinsPGift = TextField(
      controller: coinC,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onChanged: (text) {},
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context!)!.translate("coins"),
          contentPadding: EdgeInsets.only(left: 12, top: 16, bottom: 8),
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: AppLocalizations.of(context!)!.translate("en_per")),
    );


    final percentage =


    TextField(
      controller: cnt,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onChanged: (text) {},
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context!)!.translate("per_hint"),
          contentPadding: EdgeInsets.only(left: 12, top: 16, bottom: 8),
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: AppLocalizations.of(context!)!.translate("per_hint")),
    );



    final coinsP = TextField(
      controller: newCont,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      onChanged: (text) {},
      decoration: InputDecoration(
          hintText: AppLocalizations.of(context!)!.translate("coins"),
          contentPadding: EdgeInsets.only(left: 12, top: 16, bottom: 8),
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: AppLocalizations.of(context!)!.translate("en_per")),
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appAppBar().getCustomAppBar(context,
            appBarTitle: AppLocalizations.of(context!)!.translate("redemption_setting"),
            onBackButtonPress: () {
              Navigator.pop(context);
            }),
        body: appCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [




              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: ( context) =>    BlocProvider(
                    create: (_) => CubitMain(),
                    child:     RewardsListPage(type: 'post', messageTo: 'team',),
                  ),));



                },
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.only(left: 4, right: 4, bottom: 1),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                    child: appUserListTile(
                      iconWidget: Image.asset('packages/loyalty_foop/assets/appimages/reward.png',width: 36,height: 36,),
                      title: AppLocalizations.of(context!)!
                          .translate("disc_g"),
                        subtitle1: AppLocalizations.of(context!)!
                            .translate("disc_g"),
                        subtitle3:"1% = ₵10,000",

                      trailingWidget:  InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 30.0, left: 16, right: 16, top: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //Center Row contents horizontally,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        //Center Row contents vertically,

                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                child:
                                                Text(
                                                  AppLocalizations.of(context!)!.translate("dis_red"),
                                                  textAlign: TextAlign.center,
                                                  style: styleElements
                                                      .subtitle1ThemeScalable(context)
                                                      .copyWith(fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {

                                              },
                                              child: Container(
                                                child: Text(
                                                  AppLocalizations.of(context!)!.translate('next'),
                                                  style: styleElements
                                                      .headline6ThemeScalableW(context)
                                                      .copyWith(color: HexColor(AppColors.blueApp)),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),


                                    Padding(
                                      padding:    const EdgeInsets.all(16.0),
                                      child: Text(
                                        AppLocalizations.of(context!)!.translate("re_des"),
                                        style: styleElements
                                            .captionThemeScalable(context)
                                        ,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: HexColor(AppColors.appColorBackground),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 8.0, right: 4),
                                                    child: Icon(
                                                      Icons.emoji_people_rounded,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: percentage,
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: HexColor(AppColors.appColorBackground),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                const Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 8.0, right: 4),
                                                    child: Icon(
                                                      Icons.money,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: coinsP,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              // return BottomSheetContent();
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.more_vert,
                            color: HexColor(AppColors.appColorBlack65),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              InkWell(
                onTap: () {



                },
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.only(left: 4, right: 4, bottom: 1),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                    child: appUserListTile(
                      iconWidget: Image.asset('packages/loyalty_foop/assets/appimages/rewards.png',width: 36,height: 36,),
                      title: AppLocalizations.of(context!)!
                          .translate("gift_red"),
                      subtitle1: AppLocalizations.of(context!)!
                          .translate("set_coins"),
                      subtitle3:"1₹= ₵1,000",

                      trailingWidget:  InkWell(
                        onTap: () {
                          showModalBottomSheet<void>(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0)),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 30.0, left: 16, right: 16, top: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        //Center Row contents horizontally,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        //Center Row contents vertically,

                                        children: [
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                child:
                                                Text(
                                                  AppLocalizations.of(context!)!.translate("mng_gft"),
                                                  textAlign: TextAlign.center,
                                                  style: styleElements
                                                      .subtitle1ThemeScalable(context)
                                                      .copyWith(fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: InkWell(
                                              onTap: () {

                                              },
                                              child: Container(
                                                child: Text(
                                                  AppLocalizations.of(context!)!.translate('next'),
                                                  style: styleElements
                                                      .headline6ThemeScalableW(context)
                                                      .copyWith(color: HexColor(AppColors.blueApp)),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    Padding(
                                      padding:    const EdgeInsets.all(16.0),
                                      child: Text(
                                        AppLocalizations.of(context!)!.translate("pg_jj"),
                                        style: styleElements
                                            .captionThemeScalable(context)
                                           ,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: HexColor(AppColors.appColorBackground),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 8.0, right: 4),
                                                    child: Icon(
                                                      Icons.emoji_people_rounded,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: amountGift,
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: HexColor(AppColors.appColorBackground),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(left: 8.0, right: 4),
                                                    child: Icon(
                                                      Icons.money,
                                                      size: 30,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: coinsPGift,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                              // return BottomSheetContent();
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.more_vert,
                            color: HexColor(AppColors.appColorBlack65),
                          ),
                        ),
                      ),
                    ),
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