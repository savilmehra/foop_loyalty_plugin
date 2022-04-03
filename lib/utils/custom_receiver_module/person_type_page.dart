import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/NetworkFile/calls.dart';
import 'package:foop_loyalty_plugin/models/person_type_list.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../CustomPaginator.dart';
import '../basicInfo.dart';
import '../colors.dart';
import '../custom_app_bar.dart';
import '../customcard.dart';
import '../hexColors.dart';
import '../localization.dart';
import '../paginator.dart';
import '../text_styling.dart';

class PersonTypePage extends StatefulWidget {
  final String? type;
  final Null Function(List<String?>, List<String?>)? callback;

  final List<String?>? personType;
  const PersonTypePage({Key? key, this.type, this.personType, this.callback})
      : super(key: key);

  @override
  _PersonTypePage createState() => _PersonTypePage();
}

class _PersonTypePage extends State<PersonTypePage> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
  BasicInfo? basicInfo = BasicInfo();
  late TextStyleElements styleElements;
  String? searchVal;
  SharedPreferences? prefs;
  List<PersonItem> dataList = [];
  String? selectedRoomType;
  int? total = 0;
  bool isAddAll = false;

  _PersonTypePage();

  void setSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    // paginatorGlobalKey.currentState.changeState(resetState: true);
  }

  @override
  void initState() {
    super.initState();
    // setSharedPreferences();
  }

  void onsearchValueChanged(String value) {
    searchVal = value;
    dataList.clear();
    paginatorGlobalKey.currentState!.changeState(resetState: true);
  }

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: appAppBar().getCustomAppBarWithSearch(context,
              onSearchValueChanged: onsearchValueChanged,
              hintText: AppLocalizations.of(context)!.translate("search") +
                  widget.type!,

              appBarTitle:   AppLocalizations.of(context)!.translate("select") + widget.type!,
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
                  key: paginatorGlobalKey,
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
                  pageErrorChecker:(s){
                    return false;
                  },
                ),
              ),
            ],
          )),
    );
  }

  Future<PersonTypeList> getType(int page) async {
    final body = jsonEncode({
      "business_id": 0,
      "page_size": 20,
      "page_number": page,
      "searchVal": searchVal,
      "app_type": "FOOPWORKS"
    });
    var value = await Calls().call(body, context, basicInfo!.personList);

    var data = PersonTypeList.fromJson(value);

    if (widget.type == "person" &&
        widget.personType != null &&
        widget.personType!.isNotEmpty) {
      for (var selected in widget.personType!) {
        var index =
            data.rows!.indexWhere((item) => item.personTypeCode == selected);
        data.rows![index].isSelected = true;
      }
    }

    data.total = data.rows!.length;

    return data;
  }

  List<PersonItem>? listItemsGetter(PersonTypeList? response) {
    dataList.addAll(response!.rows!);

    return response.rows;
  }

  Widget listItemBuilder(value, int index) {
    return Container(
      child: InkWell(
          onTap: () {},
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            leading: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 3, color: Colors.black)),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: HexColor(AppColors.appColorWhite),
                child: ClipOval(
                  child: Center(
                    child: Text(value.personTypeCode,
                        style: styleElements.headline5ThemeScalable(context)),
                  ),
                ),
              ),
            ),
            title: Text(value.personTypeName,
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
        typeCode.add(selected[i].personTypeName);
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
        typeCode.add(selected[i].personTypeCode);
      }

      return typeCode.toSet().toList();
    }
    return [];
  }
}
