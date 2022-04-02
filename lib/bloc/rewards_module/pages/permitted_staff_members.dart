

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foop_loyalty_plugin/bloc/cubits/cubit_main.dart';
import 'package:foop_loyalty_plugin/utils/custom_tab_maker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';

import 'member_page.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'add_team_member.dart';

// ignore: must_be_immutable
class PermittedStaffMembers extends StatefulWidget {



  PermittedStaffMembersState createState() => PermittedStaffMembersState();
}

class PermittedStaffMembersState extends State<PermittedStaffMembers>
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
            appBarTitle: AppLocalizations.of(context!)!.translate('pr_member'),
            actions: [  InkWell(
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: ( context) =>    BlocProvider(
                  create: (_) => CubitMain(),
                  child:     AddMemberPage(),
                ),));




              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12, right: 12.0),
                child: Icon(Icons.add_circle,
                    color: HexColor(AppColors.blueApp)),
              ),
            ),],
            onBackButtonPress: () {
              Navigator.pop(context);
            }),




        // appAppBar().getCustomAppBar(context,
        //     appBarTitle: pageTitle+"'s "+AppLocalizations.of(context).translate('network'),
        //     onBackButtonPress: () {
        //       Navigator.pop(context);
        //     }),
        body:MemberPage(
          callBack: () {

          },
          multiSelectionEnabled: (val) {
            setState(() {
              isMultiSelectEnabled = val;
            });
          },
          key: null,
          type: "contacts", isUserAdmin: true, ownerId: 9,
        ),
      ),
    );
  }


}
