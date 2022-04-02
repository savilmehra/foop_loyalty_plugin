import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/NetworkFile/calls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../CustomPaginator.dart';
import '../appAvatar.dart';
import '../basicInfo.dart';
import '../colors.dart';
import '../custom_app_bar.dart';
import '../customcard.dart';
import '../hexColors.dart';
import '../localization.dart';
import '../locator.dart';
import '../paginator.dart';
import '../text_styling.dart';
import 'models/loyalty_list_response.dart';

// ignore: must_be_immutable
class LoyaltyTypeListPage extends StatefulWidget {
  final String? type;
  final Null Function(List<String?>, List<String?>)? callback;

  final List<String?>? loyaltyList;

  const LoyaltyTypeListPage(
      {Key? key, this.type, this.loyaltyList, this.callback})
      : super(key: key);

  @override
  _PersonTypePage createState() => _PersonTypePage();
}

class _PersonTypePage extends State<LoyaltyTypeListPage> {
  GlobalKey<PaginatorState> pp = GlobalKey();
  BasicInfo? basicInfo = BasicInfo();
  late TextStyleElements styleElements;
  String? searchVal;
  SharedPreferences? prefs = locatorRewards<SharedPreferences>();
  List<LoyaltyItem> dataList = [];
  String? selectedRoomType;
  int? total = 0;
  bool isAddAll = false;

  _PersonTypePage();

  @override
  void initState() {
    super.initState();
    // setSharedPreferences();
  }

  void onsearchValueChanged(String value) {
    searchVal = value;
    dataList.clear();
    pp.currentState!.changeState(resetState: true);
  }

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    print(jsonEncode(widget.loyaltyList));
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appAppBar().getCustomAppBarWithSearch(context,
              onSearchValueChanged: onsearchValueChanged,
              hintText: AppLocalizations.of(context)!.translate("select") +
                  widget.type!,
              appBarTitle: AppLocalizations.of(context)!.translate("search") +
                  widget.type!,
              actions: [
                InkWell(
                  onTap: () {
                    widget.callback!(getTypeCode(), getNames());
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.translate('next'),
                          style: styleElements
                              .headline6ThemeScalableW(context)
                              .copyWith(color: HexColor(AppColors.blueApp)),
                        ),
                      ],
                    ),
                  ),
                ),
              ], onBackButtonPress: () {
            Navigator.pop(context);
          }),
          body: Stack(
            children: [
              appCard(
                child: Paginator.listView(
                  key: pp,
                  padding: EdgeInsets.only(bottom: 60),
                  pageLoadFuture: getType,
                  pageItemsGetter: listItemsGetter,
                  listItemBuilder: listItemBuilder,
                  loadingWidgetBuilder:
                      CustomPaginator(context).loadingWidgetMaker,
                  errorWidgetBuilder: CustomPaginator(context).errorWidgetMaker,
                  emptyListWidgetBuilder:
                      CustomPaginator(context).emptyListWidgetMaker,
                  totalItemsGetter: CustomPaginator(context).totalPagesGetter,
                  pageErrorChecker: (s){
                    return false;
                  },
                ),
              ),
            ],
          )),
    );
  }

  Future<LoyaltyListResponse> getType(int page) async {
    final body = jsonEncode({
      "search_val": searchVal,
      "page_size": 20,
      "page_number": page,
      "app_type": "FOOPWORKS",
      "entity_id": basicInfo!.businessId
    });
    var value = await Calls().call(body, context, basicInfo!.LOYALTY_LIST);

    var data = LoyaltyListResponse.fromJson(value);

    if ( widget.loyaltyList != null && widget.loyaltyList!.isNotEmpty) {
      for (var selected in widget.loyaltyList!) {
        var index =
            data.rows!.indexWhere((item) => item.loyaltyTypeCode == selected);
        data.rows![index].isSelected = true;
      }
    }

    data.total = data.rows!.length;

    return data;
  }

  List<LoyaltyItem>? listItemsGetter(LoyaltyListResponse? response) {
    dataList.addAll(response!.rows!);

    return response.rows;
  }

  Widget listItemBuilder(value, int index) {
    return Container(
      child: InkWell(
          onTap: () {},
          child: ListTile(
            contentPadding:
                EdgeInsets.only(left: 4.0, right: 4.0, bottom: 4, top: 4),
            leading: appAvatar(
              imageUrl: basicInfo!.baseUrl + value.imageUrl.toString(),
              isFullUrl: true,
            ),
            title: Text(value.loyaltyTypeName,
                style: styleElements.subtitle1ThemeScalable(context)),
            trailing: Checkbox(
              onChanged: (bool? val) {
                if (val!) {
                  dataList[index].isSelected = true;
                } else {
                  dataList[index].isSelected = false;
                }

                setState(() {});
              },
              value: value.isSelected,
            ),
          )),
    );
  }

  List<String?> getNames() {
    List<String?> typeCode = [];
    final selected = dataList.where((el) => el.isSelected == true).toList();

    if (selected.isNotEmpty) {
      for (int i = 0; i < selected.length; i++) {
        typeCode.add(selected[i].loyaltyTypeName);
      }

      return typeCode.toSet().toList();
    }
    return [];
  }

  List<String?> getTypeCode() {
    List<String?> typeCode = [];
    final selected = dataList.where((el) => el.isSelected == true).toList();

    if (selected.isNotEmpty) {
      for (int i = 0; i < selected.length; i++) {
        typeCode.add(selected[i].loyaltyTypeCode);
      }

      return typeCode.toSet().toList();
    }
    return [];
  }
}
