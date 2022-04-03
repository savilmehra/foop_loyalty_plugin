import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/NetworkFile/calls.dart';

import 'package:foop_loyalty_plugin/models/postcreate.dart';
import 'package:foop_loyalty_plugin/models/postreceiver.dart';
import 'package:foop_loyalty_plugin/utils/CustomPaginator.dart';
import 'package:foop_loyalty_plugin/utils/appAlertDialog.dart';
import 'package:foop_loyalty_plugin/utils/app_buttons.dart';
import 'package:foop_loyalty_plugin/utils/app_user_list_tile.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/custom_receiver_module/custom_receivers_page.dart';
import 'package:foop_loyalty_plugin/utils/customcard.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/paginator.dart';
import 'package:foop_loyalty_plugin/utils/postRecipientType.dart';
import 'package:foop_loyalty_plugin/utils/resolutionenums.dart';
import 'package:foop_loyalty_plugin/utils/serviceTypeEnums.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:foop_loyalty_plugin/utils/toast_builder.dart';
import 'package:foop_loyalty_plugin/utils/utility_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostReceiverListPage extends StatefulWidget {
  final PostCreatePayload? payload;
  final PostCreatePayload? createLessonData;
  final Function? callBack;
  final String? title;
  final List<PostCreatePayload?>? list;
  final String? type;

   PostReceiverListPage(
      {this.payload,
      this.list,
      this.title,
      this.type,
      this.createLessonData,
      this.callBack});

  @override
  _PostReceiverListPage createState() => _PostReceiverListPage(
      payload: payload,);
}

class _PostReceiverListPage extends State<PostReceiverListPage> {
  String? searchVal;
  SharedPreferences? prefs;
  PostCreatePayload? payload;
  BasicInfo? basicInfo = BasicInfo();
  late TextStyleElements styleElements;
  GlobalKey<PaginatorState> paginatorKey = GlobalKey();
  List<PostReceiverListItem?> recList = [];
  List<PostReceiverListItem?> _selectedList = [];
  CustomReceivers? postRecipientDetailItem;
  PostCreatePayload postCreatePayload = PostCreatePayload();
  bool isPrivateSelected = false;
  bool isWhatsapp = false;

  PostReceiverListItem item = PostReceiverListItem();

  _PostReceiverListPage({this.payload});
  bool isLoading = false;

  /// method for refreshing the list
  refresh() {
    recList.clear();
    paginatorKey.currentState!.changeState(resetState: true);
  }

  @override
  void initState() {
    super.initState();
    item.recipientImage = "";
    item.recipientType = "Custom receivers";
    item.recipientTypeDescription =
        "You can customise the receivers list based on The profile of the receivers.";
    item.isSelected = null;
    item.recipientTypeCode = "business";
  }

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);

    return SafeArea(
      child: Scaffold(
        appBar: appAppBar().getCustomAppBarWithSearch(context,
            appBarTitle: widget.title != null
                ? widget.title ??
                    AppLocalizations.of(context)!.translate('receivers')
                : AppLocalizations.of(context)!.translate('receivers'),
            actions: [
              appTextButton(
                onPressed: () {
                  if (_selectedList.isNotEmpty || postRecipientDetailItem != null) {
                      payload!.postRecipientType = getTypeCode();
                      payload!.postRecipientDetails =getDetails();
                      Navigator.of(context).pop({'payload': payload});

                  } else {
                    ToastBuilder().showToast(
                        AppLocalizations.of(context)!
                            .translate('please_select_at_least'),
                        context,
                        HexColor(AppColors.information));
                  }
                },
                child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Visibility(
                      visible: isLoading,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
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
                shape: CircleBorder(),
              ),
            ], onBackButtonPress: () {
          Navigator.pop(context);
        }, onSearchValueChanged: (text) {
          searchVal = text;
          refresh();
        }),
        body: Column(children: [
          Expanded(
            child: Paginator.listView(
                key: paginatorKey,
                scrollPhysics: BouncingScrollPhysics(),
                pageLoadFuture: getReceiverList,
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
                }),
          ),
        ]),
      ),
    );
  }

  /// call to server for the receiver list
  Future<PostReceiverResponse> getReceiverList(int page) async {
    prefs ??= await SharedPreferences.getInstance();
    {
      PostReceiverRequest payload = PostReceiverRequest();
      payload.pageSize = 20;
      payload.pageNumber = page;
      payload.businessId = basicInfo!.businessId;
      payload.type = "post";
      payload.searchVal = searchVal;
      payload.postType = widget.list != null && widget.list!.isNotEmpty
          ? widget.list![0]!.postType
          : this.payload!.postType;
      var data = jsonEncode(payload);
      var value = await Calls().call(data, context, basicInfo!.postReceiversList);
      return PostReceiverResponse.fromJson(value);
    }
  }

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
    PostReceiverListItem item = value;
    return Container(
      child: appCard(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        margin: EdgeInsets.only(top: 1, bottom: 1, left: 8, right: 8),
        child: appUserListTile(
          onPressed: () {
            if (item.recipientType != null &&
                item.recipientType!.isNotEmpty &&
                item.recipientType == "Custom receivers") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => CustomReceiverList(
                            customReceivers: postRecipientDetailItem,
                            callback: (CustomReceivers item) {
                              setState(() {
                                postRecipientDetailItem = item;
                              });
                            },
                          )));
            }
          },
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
          trailingWidget: item.recipientType != null &&
                  item.recipientType!.isNotEmpty &&
                  item.recipientType == "Custom receivers"
              ? postRecipientDetailItem == null
                  ? Icon(Icons.chevron_right_outlined)
                  : Checkbox(
                      value: true,
                      onChanged: (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CustomReceiverList(
                                      customReceivers: postRecipientDetailItem,
                                      callback: (CustomReceivers item) {
                                        setState(() {
                                          postRecipientDetailItem = item;
                                        });
                                      },
                                    )));
                      })
              : Checkbox(
                  value: item.isSelected ??= false,
                  onChanged: (value) {
                    changeSelection(value, item, index);
                  }),
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
          recList[index]!.isSelected = value;
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
            item.isSelected = false;
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

    if (_selectedList.isNotEmpty) {
      for (int i = 0; i < _selectedList.length; i++) {
        typeCode.add(_selectedList[i]!.recipientTypeCode);
      }
    }
    if (postRecipientDetailItem != null) {
      typeCode.add("custompartner");
    }

    return typeCode;
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

    if (postRecipientDetailItem != null) detail.add(postRecipientDetailItem!);

    return detail;
  }




}
