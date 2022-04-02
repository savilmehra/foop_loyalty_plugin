import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/customcard.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:foop_loyalty_plugin/utils/toast_builder.dart';
import 'package:foop_loyalty_plugin/utils/utility_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DateTimeWidget extends StatefulWidget {
  final String title;
  final String subTitle;

  final Function(String  selectedStartDate, String  selectedStarTime,String  selectedEndDate, String  selectedEndTime,) nextCallBack;

  const DateTimeWidget(
      {Key? key,
        required this.subTitle,
        required this.title,
        required this.nextCallBack,
     })
      : super(key: key);

  @override
  DateTimeWidgetState createState() => DateTimeWidgetState();
}

class DateTimeWidgetState extends State<DateTimeWidget> {
  GlobalKey<FormState> formKey = GlobalKey();

  late TextStyleElements styleElements;
  int selectedStartEpoch = 0;
  String selectedStartDate = "-";
  int selectedEndEpoch = 0;
  String selectedEndDate = "-";
  int selectedDueEpoch = 0;
  String selectedDueDate = "Due date";
  TimeOfDay? selectedStartTimeOfDay;
  String selectedStartTime = '-';
  TimeOfDay? selectedEndTimeOfDay;
  String selectedEndTime = '-';
  String? selectedPrivacyType;

  SharedPreferences? prefs = locatorRewards<SharedPreferences>();

  BasicInfo? basicInfo = BasicInfo();


  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    final startDateWidget = GestureDetector(
        onTap: () {
          _selectStartDate(context);
        },
        child: Container(
            padding: const EdgeInsets.only(top: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  //
                  color: HexColor(AppColors.appColorGrey50),
                  width: 1.0,
                ),
              ), // set border width
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  selectedStartDate != "-" ? selectedStartDate : "-",
                  textAlign: TextAlign.left,
                  style: styleElements.bodyText2ThemeScalable(context),
                ))));
    final endDateWidget = GestureDetector(
        onTap: () {
          _selectEndDate(context);
        },
        child: Container(
            padding: EdgeInsets.only(top: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  //
                  color: HexColor(AppColors.appColorGrey50),
                  width: 1.0,
                ),
              ), // set border width
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  selectedEndDate != "-" ? selectedEndDate : "-",
                  textAlign: TextAlign.left,
                  style: styleElements.bodyText2ThemeScalable(context),
                ))));
    final startTimeWidget = GestureDetector(
        onTap: () {
          _selectStartTime(context);
        },
        child: Container(
            padding: EdgeInsets.only(top: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  //
                  color: HexColor(AppColors.appColorGrey50),
                  width: 1.0,
                ),
              ), // set border width
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  selectedStartTime,
                  textAlign: TextAlign.left,
                  style: styleElements.bodyText2ThemeScalable(context),
                ))));
    final endTimeWidget = GestureDetector(
        onTap: () {
          _selectEndTime(context);
        },
        child: Container(
            padding: EdgeInsets.only(top: 16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  //
                  color: HexColor(AppColors.appColorGrey50),
                  width: 1.0,
                ),
              ), // set border width
            ),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  selectedEndTime,
                  textAlign: TextAlign.left,
                  style: styleElements.bodyText2ThemeScalable(context),
                ))));
    return  Form(
      key: formKey,
      child:ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.title ?? "-",
                        style: styleElements
                            .headline6ThemeScalable(context)
                            .copyWith(
                            fontWeight: FontWeight.bold,
                            color: HexColor(AppColors.appColorBlack85)),
                        textAlign: TextAlign.center,
                      )),
                ),
                InkWell(
                  onTap: () {


                    Navigator.pop(context);
                    widget.nextCallBack(selectedStartDate,selectedStartTime,selectedEndDate,selectedEndTime);

                  },
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate('next'),
                        style: styleElements
                            .headline6ThemeScalableW(context)
                            .copyWith(color: HexColor(AppColors.blueApp)),
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          color: HexColor(AppColors.blueApp))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              widget.subTitle
              ,
              textAlign: TextAlign.center,
              style: styleElements.captionThemeScalable(context),
            ),
          ),

          Padding(
              padding: EdgeInsets.only(bottom: 16, left: 8.0, right: 8),
              child: Row(
                children: [
                  Expanded(
                      child: getEventDetailCard(
                        'Start date',
                        startDateWidget,
                      )),
                  const SizedBox(
                    width: 100,
                  ),
                  Expanded(
                      child: getEventDetailCard(
                        'Start time',
                        startTimeWidget,
                      )),
                ],
              )),
          Visibility(
            visible:true,
            child: Padding(
                padding:
                const EdgeInsets.only(bottom: 16, left: 8.0, right: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: getEventDetailCard(
                          'End date',
                          endDateWidget,
                        )),
                    const SizedBox(
                      width: 100,
                    ),
                    Expanded(
                        child: getEventDetailCard(
                          'End time',
                          endTimeWidget,
                        )),
                  ],
                )),
          ),



          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text( AppLocalizations.of(context!)!.translate("rewards_end_date_des"),  style: styleElements.bodyText2ThemeScalable(context),),
          )

          ,



        ],
      ),
    );
  }


  Future<void> _selectStartDate(BuildContext context) async {
    var newDate;

    newDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: newDate,
        firstDate: newDate,
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: HexColor(AppColors.appColorBlack85),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              colorScheme: ColorScheme.dark(
                primary: HexColor(AppColors.appColorBlack85),
                onPrimary: HexColor(AppColors.appColorWhite),
                surface: HexColor(AppColors.appColorWhite),
                onSurface: HexColor(AppColors.appColorBlack85),
              ).copyWith(secondary: HexColor(AppColors.appColorBlack85)),
            ),
            child: child!,
          );
        },
        lastDate: DateTime(DateTime.now().year + 100));
    if (picked != null) {
      setState(() {
        selectedStartEpoch = picked.millisecondsSinceEpoch;
        selectedStartDate =
            DateFormat(prefs!.getString(basicInfo!.dateFormat)).format(picked);
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    var newDate = new DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(newDate.year, newDate.month, newDate.day + 1),
      firstDate: DateTime(newDate.year, newDate.month, newDate.day),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: HexColor(AppColors.appColorBlack85),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.dark(
              primary: HexColor(AppColors.appColorBlack85),
              onPrimary: HexColor(AppColors.appColorWhite),
              surface: HexColor(AppColors.appColorWhite),
              onSurface: HexColor(AppColors.appColorBlack85),
            ).copyWith(secondary: HexColor(AppColors.appColorBlack85)),
          ),
          child: child!,
        );
      },
      lastDate: DateTime(newDate.year + 100),
    );
    if (picked != null) {
      setState(() {
        selectedEndEpoch = picked.millisecondsSinceEpoch;
        selectedEndDate = DateFormat(prefs!.getString(basicInfo!.dateFormat)).format(picked);
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: HexColor(AppColors.appColorBlack85),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: ColorScheme.dark(
              primary: HexColor(AppColors.appColorBlack85),
              onPrimary: HexColor(AppColors.appColorWhite),
              surface: HexColor(AppColors.appColorWhite),
              onSurface: HexColor(AppColors.appColorBlack85),
            ).copyWith(secondary: HexColor(AppColors.appColorBlack85)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {

        selectedStartTimeOfDay = picked;
        selectedStartTime = Utility().getDateFormat(
            basicInfo!.timeFormat,
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, picked.hour, picked.minute));

      });
    }
  }


  Widget getEventDetailCard(String title, Widget child, {EdgeInsets? padding}) {
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(title),
            ),
            Padding(
              padding: padding ?? EdgeInsets.all(0),
              child: child,
            )
          ],
        ));
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black,
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: const ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ).copyWith(secondary: Colors.black),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedEndTimeOfDay = picked;
        selectedEndTime = Utility().getDateFormat(
            basicInfo!.timeFormat,
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, picked.hour, picked.minute));
      });
    }
  }


}
