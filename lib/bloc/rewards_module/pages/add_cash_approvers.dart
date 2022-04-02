

import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/custom_tab_maker.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'member_page.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

// ignore: must_be_immutable
class AddCashApprovePage extends StatefulWidget {



  AddCashApprovePageState createState() => AddCashApprovePageState();
}

class AddCashApprovePageState extends State<AddCashApprovePage>
    with SingleTickerProviderStateMixin {
  List<CustomTabMaker>? list = [];
  late TabController _tabController;
  late TextStyleElements styleElements;
  List<PopupMenuItem>? menuItems;
  SharedPreferences prefs = locatorRewards<SharedPreferences>();
  String? ownerType;
  int? ownerId;

  int _currentPosition = 0;
  String? pageTitle;
  late Null Function() callback;
  String? imageUrl;
  List<PopupMenuItem> menuList = [];
  List<Widget> invitePartnerList = [];

  List<Widget> invitePartnerEmployeeList = [];
  String? type;

  bool isMultiSelectEnabled = false;

  @override
  void initState() {
    super.initState();


  }




  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: HexColor(AppColors.appColorBackground),

        appBar: appAppBar().getCustomAppBar(context,
            appBarTitle: AppLocalizations.of(context!)!.translate('cash_pp'),
            actions: [Padding(
              padding: const EdgeInsets.all(16.0),
              child:   Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context!)!.translate('next'),
                    style: styleElements
                        .headline6ThemeScalableW(context)
                        .copyWith(color: HexColor(AppColors.blueApp)),
                  ),
                  Icon(Icons.keyboard_arrow_right,
                      color: HexColor(AppColors.blueApp))
                ],
              ),
            ),],
            onBackButtonPress: () {
              Navigator.pop(context);
            }),




        body:MemberPage(
          isAddMember:true,
          callBack: () {

          },
          multiSelectionEnabled: (val) {
            setState(() {
              isMultiSelectEnabled = val;
            });
          },
          key: null,
          type: "contacts", ownerId: 9, isUserAdmin: true,
        ),
      ),
    );
  }


}
