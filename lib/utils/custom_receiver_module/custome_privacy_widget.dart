import 'package:flutter/material.dart';

import '../colors.dart';
import '../hexColors.dart';
import '../localization.dart';
import '../text_styling.dart';

class CustomPrivacyType extends StatefulWidget {
  final String? selectedValue;
  final String type;
  final int? gender;

  final Function(int?, int, int)? callBack;

  CustomPrivacyType(
      {Key? key, this.selectedValue = "", this.type = "all", this.callBack,this.gender})
      : super(key: key);
  @override
  CustomPrivacyTypeState createState() =>
      CustomPrivacyTypeState(selectedTypeCode: selectedValue);
}

class CustomPrivacyTypeState extends State<CustomPrivacyType> {
  late TextStyleElements styleElements;
  String? selectedTypeCode;
  CustomPrivacyTypeState({this.selectedTypeCode});
  bool isFixed = false;
  RangeValues _currentRangeValues = const RangeValues(18, 80);
  int selectedReceiverType = 0;
  int selectedGender = 0;
  @override
  void initState() {
    if(widget.gender!=null)
      selectedGender=widget.gender!;
    super.initState();
  }

  String? get getSelectedTypeCode => this.selectedTypeCode;

  void setPrivacyType(String? privacyType) {
    setState(() {
      selectedTypeCode = privacyType;
      isFixed = (selectedTypeCode != null && selectedTypeCode!.isNotEmpty);
    });
  }

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 16),
              child: Text(
                AppLocalizations.of(context)!.translate("select_gender"),
                style: styleElements
                    .subtitle2ThemeScalable(context)
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedGender = 0;

                      widget.callBack!(null, _currentRangeValues.start.toInt(),
                          _currentRangeValues.end.toInt());
                    });
                  },
                  child: CircleAvatar(
                    radius: 24,
                    backgroundColor: selectedGender == 0
                        ? HexColor(AppColors.appMainColor)
                        : HexColor(AppColors.appColorWhite),
                    child: ClipOval(
                      child: Center(
                          child: Image.asset(
                        selectedGender == 0
                            ? 'assets/appimages/all_white.png'
                            : 'assets/appimages/all_.png',
                      )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedGender = 1;
                      widget.callBack!(1, _currentRangeValues.start.toInt(),
                          _currentRangeValues.end.toInt());
                    });
                  },
                  child: Container(
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: selectedGender == 1
                          ? HexColor(AppColors.appMainColor)
                          : HexColor(AppColors.appColorWhite),
                      child: ClipOval(
                        child: Center(
                            child: Image.asset(
                          selectedGender == 1
                              ? 'assets/appimages/man_white.png'
                              : 'assets/appimages/man_.png',
                        )),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedGender = 2;
                      widget.callBack!(2, _currentRangeValues.start.toInt(),
                          _currentRangeValues.end.toInt());
                    });
                  },
                  child: Container(
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: selectedGender == 2
                          ? HexColor(AppColors.appMainColor)
                          : HexColor(AppColors.appColorWhite),
                      child: ClipOval(
                        child: Center(
                            child: Image.asset(
                          selectedGender == 2
                              ? 'assets/appimages/woman_white.png'
                              : 'assets/appimages/woman_.png',
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 16),
              child: Text(
                AppLocalizations.of(context)!.translate("select_age"),
                style: styleElements
                    .subtitle2ThemeScalable(context)
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            RangeSlider(
              values: _currentRangeValues,
              min: 0,
              max: 100,
              activeColor: HexColor(AppColors.appMainColor),
              inactiveColor: HexColor(AppColors.appColorBlack35),
              divisions: 20,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;

                  widget.callBack!(
                      selectedGender == 0 ? null : selectedGender,
                      _currentRangeValues.start.toInt(),
                      _currentRangeValues.end.toInt());
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
