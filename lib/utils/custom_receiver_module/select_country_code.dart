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
import 'models/country_state_payload.dart';
import 'models/country_state_response.dart';

// ignore: must_be_immutable
class SelectCountryPage extends StatefulWidget {
  final String? type;
  final Null Function(List<String?>, List<String?>)? callback;

  final List<String?>? country;
  final List<String?>? state;
  final List<String?>? city;
  final List<String?>? pin;
  final List<String?>? personType;

  const SelectCountryPage(
      {Key? key,
      this.country,
      this.state,
      this.city,
      this.type,
      this.pin,
      this.personType,
      this.callback})
      : super(key: key);

  @override
  _SelectCountryPage createState() => _SelectCountryPage();
}

class _SelectCountryPage extends State<SelectCountryPage> {
  GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();
  List<CountryStatesItem> _selectedList = [];
  BasicInfo? basicInfo = BasicInfo();
  late TextStyleElements styleElements;
  String? searchVal;
  SharedPreferences? prefs;
  List<CountryStatesItem> dataList = [];
  String? selectedRoomType;
  int? total = 0;
  bool isAddAll = false;

  _SelectCountryPage();

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
              hintText: AppLocalizations.of(context)!.translate("select") +
                  widget.type!,
              appBarTitle: AppLocalizations.of(context)!.translate("search") +
                  widget.type!,
              actions: [
                InkWell(
                  onTap: () {
                    widget.callback!(getTypeCode(), getTypeNames());
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
                  pageLoadFuture: getList,
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

  Future<PersonTypeList?> getRoles(int page) async {
    final body = jsonEncode(
        {"business_id": 0, "searchVal": searchVal, "app_type": "FOOPWORKS"});
    var value = await Calls().call(body, context, basicInfo!.personList);

    if (value != null) {
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

      return data;
    }
  }

  Future<CountryStateResponse> getList(int page) async {
    prefs ??= await SharedPreferences.getInstance();
    CountryStatePayload payload = CountryStatePayload();
    payload.pageNumber = page;
    payload.pageSize = 5;
    payload.searchVal = searchVal;
    payload.entityType = widget.type?.toLowerCase();
    payload.countryCode = widget.country ?? [];
    payload.stateCode = widget.state ?? [];
    payload.city = widget.city ?? [];
    payload.businessId = basicInfo!.businessId;
    var data = jsonEncode(payload);
    var value =
        await Calls().call(data, context, basicInfo!.countryList);
    var res = CountryStateResponse.fromJson(value);

    if (widget.type == "Country" &&
        widget.country != null &&
        widget.country!.isNotEmpty) {
      for (var selected in widget.country!) {
        var index = res.rows!.indexWhere((item) => item.code == selected);
        res.rows![index].isSelected = true;
      }
    } else if (widget.type == "State" &&
        widget.state != null &&
        widget.state!.isNotEmpty) {
      for (var selected in widget.state!) {
        var index = res.rows!.indexWhere((item) => item.code == selected);
        res.rows![index].isSelected = true;
      }
    } else if (widget.type == "City" &&
        widget.city != null &&
        widget.city!.isNotEmpty) {
      for (var selected in widget.city!) {
        var index = res.rows!.indexWhere((item) => item.code == selected);
        res.rows![index].isSelected = true;
      }
    } else if (widget.type == "Pincode" &&
        widget.pin != null &&
        widget.pin!.isNotEmpty) {
      for (var selected in widget.pin!) {
        var index = res.rows!.indexWhere((item) => item.code == selected);
        res.rows![index].isSelected = true;
      }
    }

    if (total == 0) {
      setState(() {
        total = res.total;
      });
    }
    return res;
  }

  List<CountryStatesItem>? listItemsGetter(CountryStateResponse? response) {
    dataList.addAll(response!.rows!);
    if (!isAddAll) {
      for (int i = 0; i < dataList.length; i++) {
        for (int j = 0; j < _selectedList.length; j++) {
          if (dataList[i].code == _selectedList[j].code) {
            dataList[i].isSelected = true;
            break;
          }
        }
      }
    } else {
      for (int i = 0; i < dataList.length; i++) {
        dataList[i].isSelected = true;
      }
    }
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
                    child: Text(value.code,
                        style: styleElements.headline5ThemeScalable(context)),
                  ),
                ),
              ),
            ),
            title: Text(value.name,
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

  List<String?> getTypeNames() {
    List<String?> typeCode = [];
    final selected = dataList.where((el) => el.isSelected == true).toList();

    if (selected.isNotEmpty) {
      for (int i = 0; i < selected.length; i++) {
        typeCode.add(selected[i].name);
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
        typeCode.add(selected[i].code);
      }
      return typeCode.toSet().toList();
    }
    return [];
  }
}
