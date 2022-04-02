import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/models/dateFormatItem.dart';
import 'package:foop_loyalty_plugin/models/members.dart';
import 'package:foop_loyalty_plugin/utils/app_buttons.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/customcard.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/utility_class.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class SetLoyaltyDetails extends StatefulWidget {


  @override
  SetLoyaltyDetailsState createState() =>
      SetLoyaltyDetailsState();
}

class SetLoyaltyDetailsState extends State<SetLoyaltyDetails> {

  String? title;

  final coinsController = TextEditingController();
  final cashController = TextEditingController();

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

  // GlobalKey<RoomPrivacyTypeWidgetState> privacyTypeKey = GlobalKey();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isOnline = false;
  bool startsNow = false;
  List<MembersItem>? selectedMembersItem = [];

  String? ownerImage;
  String? ownerName;
  int? ownerId;
  String? ownerType = 'person';

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    final coins = Container(
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: HexColor(AppColors.greyBg),
      ),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
                style: styleElements
                    .subtitle1ThemeScalable(context)
                    .copyWith(color: HexColor(AppColors.appColorBlack65)),
                controller: coinsController,

                keyboardType: TextInputType.number,

                onChanged: (text) {

                },
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(top: 15), // add padding to adjust icon
                    child: Icon(Icons.attach_money,color: HexColor(AppColors.appColorRed),),
                  ),
                  hintText: AppLocalizations.of(context!)!.translate('coins'),
                  contentPadding: EdgeInsets.only(left: 12, top: 16, bottom: 8),
                  border:
                  UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: AppLocalizations.of(context!)!.translate('coins'),
                ),
              )),
        ],
      ),
    );
    final cash = Container(
      padding: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: HexColor(AppColors.greyBg),
      ),
      child: TextFormField(
        controller: cashController,
        keyboardType: TextInputType.number,
        style: styleElements
            .subtitle1ThemeScalable(context)
            .copyWith(color: HexColor(AppColors.appColorBlack65)),

        textCapitalization: TextCapitalization.words,
        onChanged: (text) {

        },
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 15), // add padding to adjust icon
            child: Icon(Icons.flip_camera_android_sharp,color: HexColor(AppColors.appColorRed),),
          ),
          hintText: AppLocalizations.of(context!)!.translate('cash'),
          contentPadding: EdgeInsets.only(left: 12, top: 16, bottom: 8),
          border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          labelText: AppLocalizations.of(context!)!.translate('cash'),
        ),
      ),
    );
    final startDateWidget = GestureDetector(
        onTap: () {
          _selectStartDate(context);
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
    return SafeArea(
        child: Scaffold(
          appBar: appAppBar().getCustomAppBar(context,
              actions: [
                appTextButton(
                  onPressed: () {
                   /* Navigator.of(context)
                        .push(MaterialPageRoute(
                        builder: (context) => PostCreatePage(
                          type: "feed",
                          isWelcomeMessage: true,
                          mediaFromEdit: null,
                          postId: null,
                          contentData:null,
                          titleLesson: null,
                          isEdit: true,
                        )))
                       ;*/
                  },
                  child: Wrap(
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
                  shape: CircleBorder(),
                ),
              ],
              appBarTitle:"Set Details", onBackButtonPress: () {
                Navigator.pop(context);
              }),
          body: Form(
            key: formKey,
            child: appListCard(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0,bottom: 16.0),
                child: ListView(
                  shrinkWrap: true,
                  children: [

                    Visibility(
                      visible:true,
                      child: Padding(
                          padding:
                          EdgeInsets.only(bottom: 16, left: 8.0, right: 8),
                          child: Row(
                            children: [
                              Expanded(
                                  child: getEventDetailCard(
                                   AppLocalizations.of(context!)!.translate("coin_enter"),
                                    coins,
                                  )),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  child: getEventDetailCard(
                                    AppLocalizations.of(context!)!.translate("cash_incentive"),
                                    cash,
                                  )),
                            ],
                          )),
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
                            SizedBox(
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
                          EdgeInsets.only(bottom: 16, left: 8.0, right: 8),
                          child: Row(
                            children: [
                              Expanded(
                                  child: getEventDetailCard(
                                    'End date',
                                    endDateWidget,
                                  )),
                              SizedBox(
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
              ),
            ),
          ),
        ));
  }






  Future<void> _selectStartDate(BuildContext context) async {
    var newDate;

    newDate = new DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: newDate,
        firstDate: newDate,
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
        selectedEndDate =
            DateFormat(prefs!.getString(basicInfo!.dateFormat)).format(picked);
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
        // String  time= Utility().getDateFormat("${prefs!.getString(Strings.timeFormat)}", DateTime(
        //     DateTime.now().year,
        //     DateTime.now().month,
        //     DateTime.now().day,
        //     picked.hour,
        //     picked.minute
        // ));

        // if (date.isAfter(DateTime.now())) {
        selectedStartTimeOfDay = picked;
        selectedStartTime = Utility().getDateFormat(
            "${prefs!.getString(basicInfo!.timeFormat)}",
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, picked.hour, picked.minute));
        // picked.hour.toString() + ':' +(picked.minute<10?"0"+picked.minute.toString(): picked.minute.toString());
        // } else {
        //   ToastBuilder().showToast(
        //       AppLocalizations.of(context!)!.translate('future_date'),
        //       context,
        //       HexColor(AppColors.information));
        // }
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.black,
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
            "${prefs!.getString(basicInfo!.timeFormat)}",
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



}
