import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:foop_loyalty_plugin/NetworkFile/calls.dart';
import 'package:foop_loyalty_plugin/bottom_sheets/loyalty_add_edit.dart';
import 'package:foop_loyalty_plugin/models/base_response.dart';
import 'package:foop_loyalty_plugin/models/loyaltyPayload.dart';
import 'package:foop_loyalty_plugin/models/loyalty_list_response.dart';

import 'package:foop_loyalty_plugin/utils/CustomPaginator.dart';
import 'package:foop_loyalty_plugin/utils/appAvatar.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/customcard.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/paginator.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoyaltyEditPage extends StatefulWidget {
  final bool isSelection;
  final Function(String)? doneCallback;

  LoyaltyEditPage({ this.isSelection = false,this.doneCallback});

  @override
  LoyaltyEditPageState createState() => LoyaltyEditPageState();
}

class LoyaltyEditPageState extends State<LoyaltyEditPage> {
  String? searchVal;
  TextStyleElements? styleElements;
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
  SharedPreferences prefs = locatorRewards<SharedPreferences>();
  String loyalty = 'def';
  BasicInfo? basicInfo = BasicInfo();

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    return SafeArea(
      child: Scaffold(
        appBar: appAppBar().getCustomAppBarWithSearch(context,
            appBarTitle:  AppLocalizations.of(context!)!.translate('loyalty'),
            onBackButtonPress: () {
          Navigator.pop(context);
            },
            onSearchValueChanged: (String value) {
              searchVal = value;
              refresh();
            }, actions: [
              Visibility(
                visible: !widget.isSelection,
                child: IconButton(
                  onPressed: () {
                    showCreateSheet(null,false);
                  },
                  icon: Icon(
                    Icons.add_circle,
                    size: 30,
                    color: HexColor(AppColors.blueApp),
                  ),
                ),
              ),
              Visibility(
                visible: widget.isSelection,
                child: InkWell(
                  onTap: () {
                    widget.doneCallback!(loyalty);
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0,right: 24,bottom: 16,left: 16),
                    child: Text( AppLocalizations.of(context!)!.translate('done'),style: styleElements!.captionThemeScalable(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: HexColor(AppColors.appColorBlack65)
                    ),),
                  ),
                ),
              )
            ]),
        body: appListCard(
          child: Paginator<LoyaltyListResponse>.listView(
            key: paginatorGlobalKey,
            padding: EdgeInsets.only(bottom: 60),
            pageLoadFuture: getType,
            pageItemsGetter: CustomPaginator(context).listItemsGetter,
            listItemBuilder: listItemBuilder,
            loadingWidgetBuilder: CustomPaginator(context).loadingWidgetMaker,
            errorWidgetBuilder: CustomPaginator(context).errorWidgetMaker,
            emptyListWidgetBuilder:
            CustomPaginator(context).emptyListWidgetMaker,
            totalItemsGetter: CustomPaginator(context).totalPagesGetter,
            pageErrorChecker: (s){return false;},
          ),
        ),
      ),
    );
  }

  void refresh() {
    paginatorGlobalKey.currentState!.changeState(resetState: true);
  }

  Future<LoyaltyListResponse> getType(int page) async {
    final body = jsonEncode({
      "search_val": searchVal,
      "page_size": 20,
      "page_number": page,
      "app_type": "FOOPWORKS",
      "entity_id": basicInfo!.businessId
    });
    var value = await Calls().call(body, context, basicInfo!.loyaltyList);
    return LoyaltyListResponse.fromJson(value);
  }

  Widget listItemBuilder(value, int index) {
    LoyaltyItem item = value;
    return Container(
      child: InkWell(
        onTap: () {},
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          leading: appAvatar(
            imageUrl: basicInfo!.baseUrl + (item.imageUrl ?? ""),
            isFullUrl: true,
          ),
          title: Text(value.loyaltyTypeName,
              style: styleElements!.subtitle1ThemeScalable(context)),
          trailing: widget.isSelection ? _radio(item) : _simplePop(item),
        ),
      ),
    );
  }

  Widget _radio(LoyaltyItem? item) {
    return Radio<String>(
        value: item!.loyaltyTypeCode!,
        groupValue: loyalty,
        onChanged: (value){
          setState(() {
            loyalty = value!;
          });
        },
    );
  }

  Widget _simplePop(LoyaltyItem? item) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      onSelected: (value) {
        if (value == 'edit') {
          showCreateSheet(item,true);
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'edit',
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit_outlined),
                SizedBox(
                  width: 8,
                ),
                Text( AppLocalizations.of(context!)!.translate('edit'))
              ],
            ),
          )
        ];
      },
      icon: Icon(Icons.more_vert),
    );
  }

  void showCreateSheet(LoyaltyItem? item, bool isEdit) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            topLeft: Radius.circular(12),
          )),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return UpdateLoyaltySheet(
          isEdit:isEdit,
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          item: item,
          doneCallback: (value) {
            Navigator.pop(context);
            saveData(value);
          },
        );
      },
    );
  }

  void saveData(LoyaltyCreatePayload value) {
    Calls()
        .call(jsonEncode(value), context, basicInfo!.loyaltyTypeAdd)
        .then((value) {
      var res = BaseResponse.fromJson(value);
      if (res.statusCode == basicInfo!.statusCode) {
        refresh();
      }
    });
  }
}
