import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get_it/get_it.dart';
import 'package:foop_loyalty_plugin/bloc/rewards_module/pages/redemption_settings.dart';
import 'package:foop_loyalty_plugin/bloc/rewards_module/pages/rewards_list_page.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../cubits/cubit_main.dart';
import 'loyalty_edit.dart';
import 'manage_cash_loyalty.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';

import 'member_page.dart';

initializeScreeenUtils(BuildContext context)
{



}


class ManageRewardsPage extends StatefulWidget {
  String baseUrl;
  int userId;
  int businessId;
  String token;
  String appLanguageCode;
  String googleTranslationKey;
  String userName;
  String userImage;
  String baseUrlWithoutHttp;
  String timeFormat;
  String dateFormat;
  ManageRewardsPage({Key? key,
    required this.baseUrl,
    required this.userId,
    required this.appLanguageCode,
    required this.googleTranslationKey,
    required this.token,
    required this.businessId,
    required this.userName,
    required this.userImage,
    required this.baseUrlWithoutHttp,
    required this.timeFormat,
    required this.dateFormat


  })
      : super(key: key);

  @override
  _ManageRewardsPage createState() => _ManageRewardsPage();
}

class _ManageRewardsPage extends State<ManageRewardsPage> {
  BasicInfo? basicInfo = BasicInfo();

  @override
  void initState() {
    super.initState();
    setBasicData();
  }


  setBasicData()
  async {
    basicInfo?.appLanguageCode = widget.appLanguageCode;
    basicInfo?.googleTransltionKey = widget.googleTranslationKey;
    basicInfo?.token = widget.token;
    basicInfo?.baseUrl = widget.baseUrl;
    basicInfo?.userId = widget.userId;
    basicInfo?.businessId = widget.businessId;
    basicInfo?.userName = widget.userName;
    basicInfo?.userImage = widget.userImage;
    basicInfo?.baseUrlWithoutHttp = widget.baseUrlWithoutHttp;
    basicInfo?.timeFormat = widget.timeFormat;
    basicInfo?.dateFormat = widget.dateFormat;

    setState(() {

    });
  }
  late TextStyleElements styleElements;
  bool isSwitched = false;
  SharedPreferences? prefs = locatorRewards<SharedPreferences>();

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appAppBar().getCustomAppBar(context,
            appBarTitle: AppLocalizations.of(context!)!=null? AppLocalizations.of(context!)!
                .translate("manage_loyalty"):"", onBackButtonPress: () {
              Navigator.pop(context);
            }),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: HexColor(AppColors.greyBg),
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 8),
                    child: RichText(
                      text: TextSpan(
                          style: styleElements
                              .captionThemeScalable(context)
                              .copyWith(fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text: AppLocalizations.of(context!)!=null? AppLocalizations.of(context!)!
                                    .translate("loyalty_des"):""),
                          ]),
                    )
                  // child: Text('Rooms are groups. You can create rooms to engage with more than one person together. Please click + on the top of the page to create new rooms.',style:
                  //   styleElements.captionThemeScalable(context).copyWith(fontWeight: FontWeight.w600),),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => CubitMain(),
                        child: RewardsListPage(
                          type: 'post',
                          messageTo: 'team',
                        ),
                      ),
                    ));
              },
              child: Card(
                elevation: 0,
                margin: EdgeInsets.only(left: 4, right: 4, bottom: 1),
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                  child: ListTile(
                    leading: Image.asset(
                      'packages/foop_loyalty_plugin/assets/appimages/change-password.png',
                      width: 36,
                      height: 36,
                    ),
                    title: Text(
                      AppLocalizations.of(context!)!=null?   AppLocalizations.of(context!)!.translate("activate_lo"):"",
                      style: styleElements.bodyText1ThemeScalable(context),
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context!)!=null? AppLocalizations.of(context!)!
                          .translate("activate_lo_des"):"",
                      style: styleElements.captionThemeScalable(context),
                    ),
                    trailing: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => CubitMain(),
                        child: RewardsListPage(
                          type: 'post',
                          messageTo: 'team',
                        ),
                      ),
                    ));
              },
              child: Card(
                elevation: 0,
                margin: EdgeInsets.only(left: 4, right: 4, bottom: 1),
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                  child: ListTile(
                    leading: Image.asset(
                      'packages/foop_loyalty_plugin/assets/appimages/change-password.png',
                      width: 36,
                      height: 36,
                    ),
                    title: Text(
                      AppLocalizations.of(context!)!=null?  AppLocalizations.of(context!)!.translate("activate_cash"):"",
                      style: styleElements.bodyText1ThemeScalable(context),
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context!)!=null? AppLocalizations.of(context!)!
                          .translate("activate_cash_des"):"",
                      style: styleElements.captionThemeScalable(context),
                    ),
                    trailing: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => CubitMain(),
                        child: RewardsListPage(
                          type: 'post',
                          messageTo: 'team',
                        ),
                      ),
                    ));
              },
              child: Card(
                elevation: 0,
                margin: EdgeInsets.only(left: 4, right: 4, bottom: 1),
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                  child: ListTile(
                    leading: Image.asset(
                      'packages/foop_loyalty_plugin/assets/appimages/change-password.png',
                      width: 36,
                      height: 36,
                    ),
                    title: Text(
                      AppLocalizations.of(context!)!=null?  AppLocalizations.of(context!)!.translate("activate_api"):"",
                      style: styleElements.bodyText1ThemeScalable(context),
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context!)!=null?  AppLocalizations.of(context!)!
                          .translate("activate_api_des"):"",
                      style: styleElements.captionThemeScalable(context),
                    ),
                    trailing: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => CubitMain(),
                        child: ManageCashLoyalty(),
                      ),
                    ));
              },
              child: Card(
                elevation: 0,
                margin: EdgeInsets.only(left: 4, right: 4, bottom: 1),
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                  child: ListTile(
                    leading: Image.asset(
                      'packages/foop_loyalty_plugin/assets/appimages/change-password.png',
                      width: 36,
                      height: 36,
                    ),
                    title: Text(
                      AppLocalizations.of(context!)!=null? AppLocalizations.of(context!)!.translate("manage_cash"):"",
                      style: styleElements.bodyText1ThemeScalable(context),
                    ),
                    subtitle: Text(
                      AppLocalizations.of(context!)!=null?   AppLocalizations.of(context!)!
                          .translate("manage_cash_des"):"",
                      style: styleElements.captionThemeScalable(context),
                    ),
                    trailing: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoyaltyEditPage()));
              },
              child: Card(
                  elevation: 0,
                  margin: EdgeInsets.only(left: 4, right: 4, top: 1, bottom: 1),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                    child: ListTile(
                      leading: Image.asset(
                        'packages/foop_loyalty_plugin/assets/appimages/account-settings.png',
                        width: 36,
                        height: 36,
                      ),
                      title: Text(
                        AppLocalizations.of(context!)!=null? AppLocalizations.of(context!)!
                            .translate("manage_lo_cat"):"",
                        style: styleElements.bodyText1ThemeScalable(context),
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context!)!=null?  AppLocalizations.of(context!)!
                            .translate("manage_lo_cat_des"):"",
                        style: styleElements.captionThemeScalable(context),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => CubitMain(),
                        child: RewardsListPage(
                          type: 'chat',
                          messageTo: 'partner',
                        ),
                      ),
                    ));
              },
              child: Card(
                  elevation: 0,
                  margin: EdgeInsets.only(left: 4, right: 4, top: 1, bottom: 1),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                    child: ListTile(
                      leading: Image.asset(
                        'packages/foop_loyalty_plugin/assets/appimages/account-settings.png',
                        width: 36,
                        height: 36,
                      ),
                      title: Text(
                        AppLocalizations.of(context!)!=null?  AppLocalizations.of(context!)!.translate("manage_lo"):"",
                        style: styleElements.bodyText1ThemeScalable(context),
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context!)!=null?  AppLocalizations.of(context!)!
                            .translate("manage_lo_des"):"",
                        style: styleElements.captionThemeScalable(context),
                      ),
                      trailing: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => CubitMain(),
                        child: RedemptionSettingPage(),
                      ),
                    ));
              },
              child: Card(
                  elevation: 0,
                  margin: EdgeInsets.only(left: 4, right: 4, top: 1, bottom: 1),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                    child: ListTile(
                      leading: Image.asset(
                        'packages/foop_loyalty_plugin/assets/appimages/account-settings.png',
                        width: 36,
                        height: 36,
                      ),
                      title: Text(
                        AppLocalizations.of(context!)!=null? AppLocalizations.of(context!)!.translate("manage_coin"):"",
                        style: styleElements.bodyText1ThemeScalable(context),
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context!)!=null? AppLocalizations.of(context!)!
                            .translate("manage_coin_des"):"",
                        style: styleElements.captionThemeScalable(context),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                  )),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (_) => CubitMain(),
                        child: RewardsListPage(
                          type: 'chat',
                          messageTo: 'partner',
                        ),
                      ),
                    ));
              },
              child: Card(
                  elevation: 0,
                  margin: EdgeInsets.only(left: 4, right: 4, top: 1, bottom: 1),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                    child: ListTile(
                      leading: Image.asset(
                        'packages/foop_loyalty_plugin/assets/appimages/account-settings.png',
                        width: 36,
                        height: 36,
                      ),
                      title: Text(
                        AppLocalizations.of(context!)!=null?  AppLocalizations.of(context!)!
                            .translate("manage_lo_prog"):"",
                        style: styleElements.bodyText1ThemeScalable(context),
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context!)!=null? AppLocalizations.of(context!)!
                            .translate("manage_lo_prog_des"):"",
                        style: styleElements.captionThemeScalable(context),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.keyboard_arrow_right),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
