import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/models/postcreate.dart';
import 'package:foop_loyalty_plugin/models/postreceiver.dart';
import 'package:foop_loyalty_plugin/utils/custom_receiver_module/person_type_page.dart';
import 'package:foop_loyalty_plugin/utils/custom_receiver_module/select_country_code.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../appAlertDialog.dart';
import '../appProgressButton.dart';
import '../app_user_list_tile.dart';
import '../colors.dart';
import '../custom_app_bar.dart';
import '../customcard.dart';
import '../hexColors.dart';
import '../localization.dart';
import '../locator.dart';
import '../paginator.dart';
import '../postRecipientType.dart';
import '../text_styling.dart';
import 'custome_privacy_widget.dart';
import 'loyality_list_type_page.dart';

class CustomReceiverList extends StatefulWidget {
  final Function(CustomReceivers)? callback;
  final CustomReceivers? customReceivers;
  CustomReceiverList({this.callback, this.customReceivers});

  @override
  _CustomReceiverList createState() => _CustomReceiverList();
}

class _CustomReceiverList extends State<CustomReceiverList> {
  String? searchVal;

  PostCreatePayload? payload;
  PostReceiverListItem? selectedReceiverData;
  late TextStyleElements styleElements;
  GlobalKey<PaginatorState> paginatorKey = GlobalKey();
  List<PostReceiverListItem?> recList = [];
  List<PostReceiverListItem?> _selectedList = [];
  List<PostRecipientDetailItem> receiverDetailItem = [];
  PostCreatePayload postCreatePayload = PostCreatePayload();
  bool isPrivateSelected = false;
  SharedPreferences? prefs = locatorRewards<SharedPreferences>();
  GlobalKey<appProgressButtonState> progressButtonKey = GlobalKey();
  List<String?>? country;
  List<String?>? state;
  List<String?>? city;
  List<String?>? pinCode;
  List<String?>? loyaltyList;
  List<String?>? personTypeList;
  int? gender;
  int? minAge;
  int? maxAge;

  List<String?>? loyaltyNames;
  List<String?>? countryNames;
  List<String?>? stateNames;
  List<String?>? cityNames;
  List<String?>? pinNames;
  List<String?>? personTypeNames;
  _CustomReceiverList({this.payload, this.selectedReceiverData});

  /// method for refreshing the list
  refresh() {
    recList.clear();
    paginatorKey.currentState!.changeState(resetState: true);
  }

  @override
  void initState() {
    if (widget.customReceivers != null) {
      cityNames = widget.customReceivers!.cityCodesNames ?? [];
      city = widget.customReceivers!.cityCodes ?? [];

      countryNames = widget.customReceivers!.countryCodesNames ?? [];
      country = widget.customReceivers!.countryCodes ?? [];

      stateNames = widget.customReceivers!.stateCodesNames ?? [];
      state = widget.customReceivers!.stateCodes ?? [];

      pinNames = widget.customReceivers!.postalCodesNames ?? [];
      pinCode = widget.customReceivers!.postalCodes ?? [];

      loyaltyNames = widget.customReceivers!.loyaltyTypesNames ?? [];
      loyaltyList = widget.customReceivers!.loyaltyTypes ?? [];

      personTypeNames = widget.customReceivers!.personTypesNames ?? [];
      personTypeList = widget.customReceivers!.personTypes ?? [];
      gender = widget.customReceivers!.gender ?? 0;
      minAge = widget.customReceivers!.minAge ?? 12;
      maxAge = widget.customReceivers!.maxAge ?? 80;

      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);

    return SafeArea(
      child: Scaffold(
        appBar: appAppBar().getCustomAppBar(
          context,
          appBarTitle: AppLocalizations.of(context)!.translate('receivers'),
          actions: [
            InkWell(
              onTap: () {
                widget.callback!(getData());
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
          ],
          onBackButtonPress: () {
            Navigator.pop(context);
          },
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 16),
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: appCard(
                    margin:
                        const EdgeInsets.only(top: 2, left: 8, right: 8, bottom: 2),
                    color: HexColor(AppColors.greyBg),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 8),
                        child: Text(
                          AppLocalizations.of(context)!.translate("5_min_post"),
                          style: styleElements
                              .subtitle2ThemeScalable(context)
                              .copyWith(fontWeight: FontWeight.w500),
                        )
                        // child: Text('Rooms are groups. You can create rooms to engage with more than one person together. Please click + on the top of the page to create new rooms.',style:
                        //   styleElements.subtitle2ThemeScalable(context).copyWith(fontWeight: FontWeight.w600),),
                        ),
                  ),
                ),
              ];
            },
            body: appCard(
                padding: EdgeInsets.all(0),
                child: Column(
                  children: [
                    CustomPrivacyType(
                      gender: gender,
                      callBack: (int? g, int start, int end) {
                        setState(() {
                          gender = g;
                          minAge = start;
                          maxAge = end;
                        });

                        print(gender.toString());
                      },
                    ),
                    Expanded(
                      child: ListView(children: [
                        listItemBuilder(null, 0),
                        listItemBuilder(null, 1),
                        listItemBuilder(null, 2),
                        listItemBuilder(null, 3),
                        listItemBuilder(null, 4),
                        listItemBuilder(null, 5),
                      ]),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  /// call to server for the receiver list

  /// return the recipient list from server
  List<PostReceiverListItem?>? listItemsGetter(PostReceiverResponse? response) {
    /// checking the already saved recipient with the new one returned by server
    response!.rows!.forEach((element) {
      if (_selectedList.any((selectedItem) {
        return selectedItem!.recipientTypeReferenceId ==
                element!.recipientTypeReferenceId &&
            selectedItem.recipientTypeCode == element.recipientTypeCode;
      })) {
        element!.isSelected = true;
      }
    });
    recList.addAll(response.rows!);
    return response.rows;
  }

  /// this return the list widget
  Widget listItemBuilder(value, int index) {
    PostReceiverListItem item = PostReceiverListItem();
    if (index == 0) {
      item.recipientImage = "assets/appimages/partner-type.png";
      item.recipientType = "Select Partner Type";
      item.recipientTypeDescription =
          personTypeNames != null && personTypeNames!.isNotEmpty
              ? personTypeNames!.join(', ')
              : "";
      item.isSelected = null;
      item.recipientTypeCode = "business";
    }
    if (index == 1) {
      item.recipientImage = "assets/appimages/card.png";
      item.recipientType = "Select Partner Loyalty Type";
      item.recipientTypeDescription =
          loyaltyNames != null && loyaltyNames!.isNotEmpty
              ? loyaltyNames!.join(', ')
              : "";
      item.isSelected = null;
      item.recipientTypeCode = "business";
    }

    if (index == 2) {
      item.recipientImage = "assets/appimages/countries.png";
      item.recipientType = "Select Countries";
      item.recipientTypeDescription =
          countryNames != null && countryNames!.isNotEmpty
              ? countryNames!.join(', ')
              : "";
      item.isSelected = null;
      item.recipientTypeCode = "business";
    }

    if (index == 3) {
      item.recipientImage = "assets/appimages/state.png";
      item.recipientType = "Select States/Provinces";
      item.recipientTypeDescription =
          stateNames != null && stateNames!.isNotEmpty
              ? stateNames!.join(', ')
              : "";
      item.isSelected = null;
      item.recipientTypeCode = "business";
    }

    if (index == 4) {
      item.recipientImage = "assets/appimages/cities.png";
      item.recipientType = "Select Cities";
      item.recipientTypeDescription = cityNames != null && cityNames!.isNotEmpty
          ? cityNames!.join(', ')
          : "";
      item.isSelected = null;
      item.recipientTypeCode = "business";
    }

    if (index == 5) {
      item.recipientImage = "assets/appimages/zip-code.png";
      item.recipientType = "Select Postcodes";
      item.recipientTypeDescription =
          pinNames != null && pinNames!.isNotEmpty ? pinNames!.join(', ') : "";
      item.isSelected = null;
      item.recipientTypeCode = "business";
    }
    return Container(
      child: appCard(
        padding: EdgeInsets.all(6),
        margin: EdgeInsets.only(top: 1, bottom: 1, left: 8, right: 8),
        child: appUserListTile(
          onPressed: () {
            print("-------------------------------999");
            switch (index) {
              case 0:
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonTypePage(
                              type: "Partner Type",
                              personType: personTypeList,
                              callback:
                                  (List<String?> item, List<String?> names) {
                                setState(() {
                                  personTypeList = item;
                                  personTypeNames = names;
                                });
                              })));
                }
                break;

              case 1:
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoyaltyTypeListPage(
                              type: "loyalty",
                              loyaltyList: loyaltyList,
                              callback:
                                  (List<String?> item, List<String?> names) {
                                setState(() {
                                  loyaltyList = item;
                                  loyaltyNames = names;
                                });
                              })));
                }
                break;
              case 2:
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectCountryPage(
                              type: "Country",
                              country: country,
                              state: state,
                              city: city,
                              pin: pinCode,
                              callback:
                                  (List<String?> item, List<String?> names) {
                                setState(() {
                                  country = item;
                                  countryNames = names;
                                });
                              })));
                }
                break;
              case 3:
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectCountryPage(
                              type: "State",
                              country: country,
                              state: state,
                              city: city,
                              pin: pinCode,
                              callback:
                                  (List<String?> item, List<String?> names) {
                                setState(() {
                                  state = item;
                                  stateNames = names;
                                });
                              })));
                }
                break;
              case 4:
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectCountryPage(
                              type: "City",
                              country: country,
                              state: state,
                              city: city,
                              pin: pinCode,
                              callback:
                                  (List<String?> item, List<String?> names) {
                                setState(() {
                                  city = item;
                                  cityNames = names;
                                });
                              })));
                }
                break;
              case 5:
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectCountryPage(
                              type: "Pincode",
                              country: country,
                              state: state,
                              city: city,
                              pin: pinCode,
                              callback:
                                  (List<String?> item, List<String?> names) {
                                setState(() {
                                  pinCode = item;
                                  pinNames = names;
                                });
                              })));
                }
                break;
            }
          },
          iconWidget: SizedBox(
              height: 30,
              width: 30,
              child: Image(image: AssetImage(item.recipientImage!))),
          title: item.recipientType,
          subtitle1: item.recipientTypeDescription,
          trailingWidget: item.isSelected != null
              ? Checkbox(
                  value: item.isSelected ??= false,
                  onChanged: (value) {
                    changeSelection(value, item, index);
                  })
              : Icon(Icons.chevron_right_outlined),
        ),
      ),
    );
  }

  /// updates the UI according to the selected recipient from the recipient list
  void changeSelection(bool? value, PostReceiverListItem item, int index) {
    if (item.isAllowed != null && item.isAllowed!) {
      if (item.recipientTypeCode!.toLowerCase() ==
          POST_RECIPIENT_TYPE.PRIVATE.type) {
        if (value!) {
          _selectedList.clear();
          _selectedList.add(item);
          isPrivateSelected = true;
        } else {
          _selectedList.remove(item);
          isPrivateSelected = false;
        }
        for (int i = 0; i < recList.length; i++) {
          recList[i]!.isSelected = false;
        }
        setState(() {
          item.isSelected = value;
        });
      } else {
        if (value!) {
          if (isPrivateSelected) {
            _selectedList.clear();
            _selectedList.add(item);
          } else {
            _selectedList.add(item);
          }
        } else {
          _selectedList.remove(item);
        }

        if (isPrivateSelected) {
          for (int i = 0; i < recList.length; i++) {
            recList[i]!.isSelected = false;
          }
          isPrivateSelected = false;
        }
        setState(() {
          item.isSelected = value;
        });
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return appDialog(
              message: item.allowedMsg,
            );
          });
    }
  }

  /// Get the recipient type code for the selected recipient

  CustomReceivers getData() {
    CustomReceivers item = CustomReceivers();

    item.cityCodesNames = cityNames ?? [];
    item.countryCodesNames = countryNames ?? [];
    item.stateCodesNames = stateNames ?? [];
    item.postalCodesNames = pinNames ?? [];
    item.personTypesNames = personTypeNames ?? [];
    item.loyaltyTypesNames = loyaltyNames ?? [];

    item.cityCodes = city ?? [];
    item.countryCodes = country ?? [];
    item.stateCodes = state ?? [];
    item.postalCodes = pinCode ?? [];
    item.personTypes = personTypeList ?? [];
    item.loyaltyTypes = loyaltyList ?? [];
    item.gender = gender;
    item.minAge = minAge;
    item.maxAge = maxAge;

    item.type = "custompartner";

    return item;
  }
}
