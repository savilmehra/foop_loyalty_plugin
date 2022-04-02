import 'dart:convert';
import 'package:foop_loyalty_plugin/NetworkFile/calls.dart';
import 'package:foop_loyalty_plugin/models/connectionItem.dart';
import 'package:foop_loyalty_plugin/models/person_type_respnse.dart';
import 'package:foop_loyalty_plugin/utils/CustomPaginator.dart';
import 'package:foop_loyalty_plugin/utils/appAvatar.dart';
import 'package:foop_loyalty_plugin/utils/app_user_list_tile.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/customcard.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/paginator.dart';
import 'package:foop_loyalty_plugin/utils/searchBox.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:shared_preferences/shared_preferences.dart';




// ignore: must_be_immutable
class MemberPage extends StatefulWidget {
  final String? type;
  final Function()? callBack;
  final bool? isChat;
  final bool isUserAdmin;
  final Function(bool)? multiSelectionEnabled;
  Null Function(String?)? removeCallBack;
  bool isForward = false;
  int ownerId;

  bool isAddMember;
  Null Function(ConnectionItem)? addConnectionCallBack;
  MemberPage(
      {Key? key,
        this.type,
        required this.ownerId,
        required this.isUserAdmin,
        required this.callBack,
        this.isChat = false,
        this.isAddMember=false,
        this.multiSelectionEnabled,
        this.isForward = false,
        this.addConnectionCallBack,
        this.removeCallBack})
      : super(key: key);

  @override
  CommonListState createState() => CommonListState(type!);
}

class CommonListState extends State<MemberPage>
    with AutomaticKeepAliveClientMixin<MemberPage> {
  String? searchVal;
  String? personName;
  String type;
  int? id;

  String? ownerType;
  BasicInfo? basicInfo = BasicInfo();
  String? personType;
  late Null Function() callback;
  GlobalKey<PaginatorState> paginatorKey = GlobalKey();
  late SharedPreferences prefs;
  late TextStyleElements styleElements;

  bool isSelectMultiple = false;
  List<int> selectedIds = [];
  List<ConnectionItem> connectionList = [];
  List<ConnectionItem> selectedConnections = [];
  List<Widget> getItems(String? name) {
    List<Widget> popupmenuList = [];

    if (widget.isUserAdmin) {
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.manage_accounts_outlined,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            "Assign Manager",
            style: styleElements.subtitle1ThemeScalable(context),
          )));
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.people_outline,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            AppLocalizations.of(context!)!.translate("partner_employees"),
            style: styleElements.subtitle1ThemeScalable(context),
          )));
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.card_membership,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            "Manage Loyalty",
            style: styleElements.subtitle1ThemeScalable(context),
          )));
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.contacts_outlined,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            "Manage Role",
            style: styleElements.subtitle1ThemeScalable(context),
          )));
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.assignment_ind_outlined,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            "Edit Partner ID",
            style: styleElements.subtitle1ThemeScalable(context),
          )));
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.person_remove_outlined,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            "Deactivate Partner",
            style: styleElements.subtitle1ThemeScalable(context),
          )));
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.account_tree_outlined,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            AppLocalizations.of(context!)!.translate("m_hierarchy"),
            style: styleElements.subtitle1ThemeScalable(context),
          )));
    } else {
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.people_outline,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            AppLocalizations.of(context!)!.translate("partner_employees"),
            style: styleElements.subtitle1ThemeScalable(context),
          )));
    }
    popupmenuList.add(ListTile(
        leading: Icon(
          Icons.chat_outlined,
          color: HexColor(AppColors.appColorBlack35),
          size: 25,
        ),
        title: Text(
          "Chat",
          style: styleElements.subtitle1ThemeScalable(context),
        )));
    popupmenuList.add(ListTile(
        leading: Icon(
          Icons.call_outlined,
          color: HexColor(AppColors.appColorBlack35),
          size: 25,
        ),
        title: Text(
          AppLocalizations.of(context!)!.translate("call"),
          style: styleElements.subtitle1ThemeScalable(context),
        )));

    return popupmenuList;
  }

  List<Widget> getItemsContact(String? name) {
    List<Widget> popupmenuList = [];
    if (widget.isUserAdmin ) {
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.assignment_ind_outlined,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            "Edit Partner Employee ID",
            style: styleElements.subtitle1ThemeScalable(context),
          )));
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.person_remove_outlined,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            "Deactivate Partner Employee",
            style: styleElements.subtitle1ThemeScalable(context),
          )));
      popupmenuList.add(ListTile(
          leading: Icon(
            Icons.manage_accounts_outlined,
            color: HexColor(AppColors.appColorBlack35),
            size: 25,
          ),
          title: Text(
            "Assign Manager",
            style: styleElements.subtitle1ThemeScalable(context),
          )));
    }
    popupmenuList.add(ListTile(
        leading: Icon(
          Icons.chat_outlined,
          color: HexColor(AppColors.appColorBlack35),
          size: 25,
        ),
        title: Text(
          "Chat",
          style: styleElements.subtitle1ThemeScalable(context),
        )));
    popupmenuList.add(ListTile(
        leading: Icon(
          Icons.call_outlined,
          color: HexColor(AppColors.appColorBlack35),
          size: 25,
        ),
        title: Text(
          AppLocalizations.of(context!)!.translate("call"),
          style: styleElements.subtitle1ThemeScalable(context),
        )));

    return popupmenuList;
  }

  @override
  bool get wantKeepAlive => true;

  void setSharedPreferences() async {
    refresh();
  }

  Future<void> _setPref() async {
    prefs = await SharedPreferences.getInstance();

  }

  @override
  void initState() {
    super.initState();

    _setPref();
  }

  void onsearchValueChanged(String text) {
    // print(text);
    searchVal = text;
    refresh();
  }

  refresh() {
    paginatorKey.currentState!.changeState(resetState: true);
  }

  filter(String? personT, String? typ) {
    setState(() {
      personType = personT;
      type = typ!;
    });
    paginatorKey.currentState!.changeState(resetState: true);
  }

  filterMyPartner(String? personT) {
    setState(() {
      type = personT!;
    });
    paginatorKey.currentState!.changeState(resetState: true);
  }
  late BuildContext ctx;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);



    return

      SafeArea(
          child: Scaffold(

            body:  Builder(builder: (BuildContext context) {
              this.ctx = context;
              return Container(
                  child: NestedScrollView(
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: SearchBox(
                            onvalueChanged: onsearchValueChanged,
                            hintText: AppLocalizations.of(context!)!.translate('search'),
                          ),
                        ),
                      ];
                    },
                    body: appCard(
                      padding: EdgeInsets.all(0),
                      child: RefreshIndicator(
                        onRefresh: refreshList,
                        child: Paginator.listView(
                            key: paginatorKey,
                            padding: EdgeInsets.only(top: 8),
                            scrollPhysics: BouncingScrollPhysics(),
                            pageLoadFuture: getFollowers,
                            pageItemsGetter: CustomPaginator(context).listItemsGetter,
                            listItemBuilder: listItemBuilder,
                            loadingWidgetBuilder: CustomPaginator(context).loadingWidgetMaker,
                            errorWidgetBuilder: CustomPaginator(context).errorWidgetMaker,
                            emptyListWidgetBuilder:
                            CustomPaginator(context).emptyListWidgetMaker,
                            totalItemsGetter: CustomPaginator(context).totalPagesGetter,
                            pageErrorChecker:(s){ return false;}),
                      ),
                    ),
                  ));
            }),
          ));
  }

  Future<Null> refreshList() async {
    refresh();
    await new Future.delayed(new Duration(seconds: 2));

    return null;
  }

  Future<PersonListResponse> getFollowers(int page) async {
    prefs = await SharedPreferences.getInstance();
    final body = jsonEncode({
      "is_active":
      personType != null && personType == "inActive" ? false : true,
      "list_type": type == "my_partner" ? "my" : "",
      "search_val": searchVal,
      "page_number": page,
      "page_size": 10,
      "relationship":
      type == "contacts" ? "partner,partneremployee" : "partner",
      "person_types":
      personType != null && personType != "inActive" ? [personType] : [],
      "business_id":""// widget.businessId=="
    });

    var res = await Calls().call(body, context, basicInfo!.PARTNER_LIST);

    return PersonListResponse.fromJson(res);
  }

  Widget listItemBuilder(value, int index) {
    Rows item = value;

    return  Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Opacity(
        opacity: item.isPartnerAssigned?1.0:0.50,

        child: appUserListTile(
          onPressed: () {
            if (!widget.isForward ) {

              if( item.isPartnerAssigned){

                if (isSelectMultiple) {
                  setState(() {
                    var changedVal = !(item.selected ?? false);
                    changeSelection(item, changedVal);
                  });
                } }

            }

          },
          // imageUrl: widget.type == "contacts" ? item.personAvatar : item.avatar,
          iconWidget: appAvatar(
            imageUrl: widget.type == "contacts"
                ? item.personAvatar??""
                : item.avatar??"",
            size: 52,
          ),
          title: widget.type == "contacts" ? item.subtitle??"" : item.title??"",
          subtitle3: item.role![0].toString() +
              ", " +
              item.levelDetails!.levelType.toString(),
          subtitle1:
          (widget.type == "contacts" ? item.title??"" : item.subtitle??"").toString(),
          trailingWidget:widget.isAddMember
              ? Checkbox(
            activeColor: HexColor(AppColors.appMainColor),
            value: item.selected,
            onChanged: (val) {
              if (this.mounted) {
                setState(() {
                  if (val!) {
                    item.selected = true;
                    if (widget.isForward) {
                      ConnectionItem cnItem = ConnectionItem();
                      cnItem.connectionId = item.contactId.toString();
                      cnItem.connectionName = item.subtitle.toString();
                      cnItem.connectionOwnerId =
                         widget.ownerId.toString();
                      cnItem.connectionOwnerType = "person";
                      cnItem.connectionType = "person";
                      cnItem.isSelected = true;
                      cnItem.connectionProfileThumbnailUrl =
                          item.personAvatar;

                      if (widget.addConnectionCallBack != null)
                        widget.addConnectionCallBack!(cnItem);
                      connectionList.add(cnItem);
                    }
                    setState(() {});
                  } else {
                    item.selected = false;
                    if (widget.isForward)
                      widget.removeCallBack!(item.contactId.toString());
                    // removeItem(item.connectionId);
                    setState(() {});
                  }
                });
              }
            },
          )
              : personType != null && personType == "inActive" || widget.isChat!
              ? Container()
              : InkWell(
            onTap: () {

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.more_vert,
                color: HexColor(AppColors.appColorBlack65),
              ),
            ),
          ),
        ),
      ),
    )
    ;
  }

  void changeSelection(Rows item, bool val) {
    setState(() {
      item.selected = val;
      if (val) {
        selectedIds.add(item.companyId!);
      } else {
        selectedIds.remove(item.companyId!);
      }
      if (selectedIds.length == 0) {
        isSelectMultiple = false;
        widget.multiSelectionEnabled!(false);
      }
    });
  }

  CommonListState(
      this.type,
      );

  Future<void> clickHandle(int value, Rows rows) async {
    switch (type) {
      case "my_partner":

    }
  }


  void removeMultiSelection() {
    setState(() {
      selectedIds = [];
      isSelectMultiple = false;
      widget.multiSelectionEnabled!(false);
      refresh();
    });
  }
}
