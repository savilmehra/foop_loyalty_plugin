
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/bloc/cubits/cubit_main.dart';
import 'package:foop_loyalty_plugin/bloc/rewards_module/pages/permitted_staff_members.dart';
import 'package:foop_loyalty_plugin/bloc/rewards_module/pages/rewards_list_page.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'cas_insentive_approver.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';

import 'member_page.dart';

class ManageCashLoyalty extends StatefulWidget {

  @override
  _ManageCashLoyalty createState() => _ManageCashLoyalty();
}

class _ManageCashLoyalty extends State<ManageCashLoyalty> {

  @override
  void initState() {
    super.initState();

  }

  late TextStyleElements styleElements;

  bool isSwitched =false;
  SharedPreferences? prefs = locatorRewards<SharedPreferences>();
  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appAppBar().getCustomAppBar(context,
            appBarTitle: AppLocalizations.of(context!)!.translate("manage_cash_l"),
            onBackButtonPress: () {
              Navigator.pop(context);
            }),
        body: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: HexColor(AppColors.greyBg),
                child: Padding(
                    padding: EdgeInsets.only(top:16,left: 16,right: 16,bottom: 8),
                    child:RichText(
                      text: TextSpan(
                          style: styleElements.captionThemeScalable(context).copyWith(fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text:  AppLocalizations.of(context!)!.translate("m_cash_l") ),

                          ]
                      ),
                    )
              ),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ( context) =>    BlocProvider(
                  create: (_) => CubitMain(),
                  child:     PermittedStaffMembers(),
                ),));



              },
              child: Card(
                elevation: 0,
                margin: EdgeInsets.only(left: 4, right: 4, bottom: 1),
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                  child: ListTile(
                    leading: Image.asset('packages/foop_loyalty_plugin/assets/appimages/change-password.png',width: 36,height: 36,),
                    title: Text(
                      AppLocalizations.of(context!)!
                          .translate("permitted_s"),
                      style: styleElements.subtitle2ThemeScalable(context),
                    ),

                    subtitle: Text(
                      AppLocalizations.of(context!)!
                          .translate("permitted_s_d"),
                      style:
                      styleElements.captionThemeScalable(context),
                    ),

                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ( context) =>    BlocProvider(
                  create: (_) => CubitMain(),
                  child:     CashIncentiveApprove(),
                ),));



              },
              child: Card(
                elevation: 0,
                margin: EdgeInsets.only(left: 4, right: 4, bottom: 1),
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                  child: ListTile(
                    leading: Image.asset('packages/foop_loyalty_plugin/assets/appimages/change-password.png',width: 36,height: 36,),
                    title: Text(
                      AppLocalizations.of(context!)!
                          .translate("app_s"),
                      style: styleElements.subtitle2ThemeScalable(context),
                    ),

                    subtitle: Text(
                      AppLocalizations.of(context!)!
                          .translate("apprv_s"),
                      style:
                      styleElements.captionThemeScalable(context),
                    ),

                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
              ),
            ),
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
                  child: ListTile(
                    leading: Image.asset('packages/foop_loyalty_plugin/assets/appimages/change-password.png',width: 36,height: 36,),
                    title: Text(
                      AppLocalizations.of(context!)!
                          .translate("df_d"),
                      style: styleElements.subtitle2ThemeScalable(context),
                    ),

                    subtitle: Text(
                      AppLocalizations.of(context!)!
                          .translate("df_d_s"),
                      style:
                      styleElements.captionThemeScalable(context),
                    ),

                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: ( context) =>    BlocProvider(
                  create: (_) => CubitMain(),
                  child:     RewardsListPage(type: 'post', messageTo: 'partner',),
                ),));



              },
              child: Card(
                elevation: 0,
                margin: EdgeInsets.only(left: 4, right: 4, bottom: 1),
                child: Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                  child: ListTile(
                    leading: Image.asset('packages/foop_loyalty_plugin/assets/appimages/change-password.png',width: 36,height: 36,),
                    title: Text(
                      AppLocalizations.of(context!)!
                          .translate("prt_evn"),
                      style: styleElements.subtitle2ThemeScalable(context),
                    ),

                    subtitle: Text(
                      AppLocalizations.of(context!)!
                          .translate("prt_evn_dds"),
                      style:
                      styleElements.captionThemeScalable(context),
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
              //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => LoyaltyEditPage()));
              },
              child: Card(
                  elevation: 0,
                  margin:
                  EdgeInsets.only(left: 4, right: 4, top: 1, bottom: 1),
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8, left: 8),
                    child: ListTile(
                      leading: Image.asset('packages/foop_loyalty_plugin/assets/appimages/account-settings.png',width: 36,height: 36,),
                      title: Text(
                        AppLocalizations.of(context!)!
                            .translate("view_ledger"),
                        style:
                        styleElements.subtitle2ThemeScalable(context),
                      ),
                      subtitle: Text(
                        AppLocalizations.of(context!)!
                            .translate("view_l"),
                        style:
                        styleElements.captionThemeScalable(context),
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