import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/NetworkFile/calls.dart';
import 'package:foop_loyalty_plugin/models/postcreate.dart';
import 'package:foop_loyalty_plugin/models/postreceiver.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../appAlertDialog.dart';
import '../appProgressButton.dart';
import '../app_user_list_tile.dart';
import '../basicInfo.dart';
import '../custom_app_bar.dart';
import '../customcard.dart';
import '../localization.dart';
import '../locator.dart';
import '../paginator.dart';
import '../postRecipientType.dart';
import '../resolutionenums.dart';
import '../serviceTypeEnums.dart';
import '../text_styling.dart';
import '../utility_class.dart';
import 'custom_receivers_page.dart';

class MainReceiverList extends StatefulWidget {
  @override
  _MainReceiverList createState() => _MainReceiverList();
}

class _MainReceiverList extends State<MainReceiverList> {
  String? searchVal;
  BasicInfo? basicInfo = BasicInfo();
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

  _MainReceiverList({this.payload, this.selectedReceiverData});

  /// method for refreshing the list
  refresh() {
    recList.clear();
    paginatorKey.currentState!.changeState(resetState: true);
  }

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);

    return SafeArea(
      child: Scaffold(
        appBar: appAppBar().getCustomAppBarWithSearch(context,
            appBarTitle: AppLocalizations.of(context)!.translate('receivers'),
            actions: [], onBackButtonPress: () {
          Navigator.pop(context);
        }, onSearchValueChanged: (text) {
          searchVal = text;
          refresh();
        }),
        body: Padding(
          padding: EdgeInsets.only(top: 16),
          child: ListView(children: [
            listItemBuilder(null, 0),
            listItemBuilder(null, 1),
          ]),
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
      item.recipientImage = "";
      item.recipientType = "Custom receivers";
      item.recipientTypeDescription =
          "You can customise the receivers list based on The profile of the receivers.";
      item.isSelected = null;
      item.recipientTypeCode = "business";
    } else {
      item.recipientImage =basicInfo!.userImage??"";
      item.recipientType = basicInfo!.userName??"";
      item.recipientTypeDescription =
          "When you want to set tasks, events & reminders only for yourself";
      item.isSelected = false;
      item.recipientTypeCode = "person";
    }

    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CustomReceiverList()));
        },
        child: appCard(
          padding: EdgeInsets.all(6),
          margin: EdgeInsets.only(top: 1, bottom: 1, left: 8, right: 8),
          child: appUserListTile(
            imageUrl: (item.recipientImage != null)
                ? basicInfo!.baseUrl + item.recipientImage!
                : Utility().getUrlForImage(
                    item.recipientImage,
                    RESOLUTION_TYPE.R64,
                    item.recipientTypeCode == 'business'
                        ? SERVICE_TYPE.BUSINESS
                        : item.recipientTypeCode == 'community'
                            ? SERVICE_TYPE.ROOM
                            : SERVICE_TYPE.PERSON),
            isFullImageUrl: true,
            title: item.recipientType,
            subtitle1: item.recipientTypeDescription,
            trailingWidget: item.isSelected != null
                ? Checkbox(
                    value: item.isSelected ??= false,
                    onChanged: (value) {
                      changeSelection(value, item, index);
                    })
                : IconButton(
                    icon: Icon(Icons.chevron_right_outlined),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CustomReceiverList()));
                    },
                  ),
          ),
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
  List<String?> getTypeCode() {
    List<String?> typeCode = [];
    for (int i = 0; i < _selectedList.length; i++) {
      typeCode.add(_selectedList[i]!.recipientTypeCode);
    }
    return typeCode;
  }

  ///method returns the payload to be uploaded to the server.
  PostCreatePayload getPayload() {
    postCreatePayload.postRecipientType = getTypeCode();
    postCreatePayload.postRecipientDetails = getDetails();
    return postCreatePayload;
  }

  /// This matches the selected list recipient type with the specific scenario to add it to the details for server upload.
  List<PostRecipientDetailItem> getDetails() {
    List<PostRecipientDetailItem> detail = [];
    for (int i = 0; i < _selectedList.length; i++) {
      if (_selectedList[i]!.recipientTypeReferenceId != null) {
        if (_selectedList[i]!.recipientTypeCode ==
                POST_RECIPIENT_TYPE.CLASS.type ||
            _selectedList[i]!.recipientTypeCode ==
                POST_RECIPIENT_TYPE.STAFF.type ||
            _selectedList[i]!.recipientTypeCode ==
                POST_RECIPIENT_TYPE.COMMUNITY.type ||
            _selectedList[i]!.recipientTypeCode ==
                POST_RECIPIENT_TYPE.PARENT.type) {
          detail.add(NormalReceivers2(
              type: POST_RECIPIENT_TYPE.ROOM.type,
              id: _selectedList[i]!.recipientTypeReferenceId));
        } else if (_selectedList[i]!.recipientTypeCode ==
            POST_RECIPIENT_TYPE.BUSINESS.type) {
          postCreatePayload.postBusinessId =
              _selectedList[i]!.recipientTypeReferenceId;
          detail.add(NormalReceivers2(
              type: POST_RECIPIENT_TYPE.BUSINESS.type,
              id: _selectedList[i]!.recipientTypeReferenceId));
        } else {
          detail.add(NormalReceivers2(
              type: _selectedList[i]!.recipientTypeCode,
              id: _selectedList[i]!.recipientTypeReferenceId));
        }
      }
    }
    return detail;
  }


}
