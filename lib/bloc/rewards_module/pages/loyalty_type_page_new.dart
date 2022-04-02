import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foop_loyalty_plugin/bloc/common_widgets/common_list_tile.dart';
import 'package:foop_loyalty_plugin/bloc/common_widgets/date_time_widget.dart';
import 'package:foop_loyalty_plugin/bloc/common_widgets/loading_indicator.dart';
import 'package:foop_loyalty_plugin/bloc/common_widgets/loyalty_benifits.dart';
import 'package:foop_loyalty_plugin/bloc/common_widgets/paginator_list_view.dart';
import 'package:foop_loyalty_plugin/bloc/cubits/cubit_main.dart';
import 'package:foop_loyalty_plugin/bloc/rewards_module/pages/postcreatepage.dart';
import 'package:foop_loyalty_plugin/bloc/rewards_module/pages/set_loyalty_details.dart';
import 'package:foop_loyalty_plugin/bloc/states/main_state.dart';
import 'package:foop_loyalty_plugin/bloc/states/states.dart';
import 'package:foop_loyalty_plugin/models/LoyaltyTypeList.dart';
import 'package:foop_loyalty_plugin/utils/app_buttons.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/common_button.dart';
import 'package:foop_loyalty_plugin/utils/common_helpdesk_sheet.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/customcard.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/searchBox.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:foop_loyalty_plugin/utils/toast_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoyaltyTypePageNew extends StatefulWidget {
  const LoyaltyTypePageNew({Key? key}) : super(key: key);

  @override
  LoyaltyTypePageNewState createState() => LoyaltyTypePageNewState();
}

class LoyaltyTypePageNewState extends State<LoyaltyTypePageNew> {
  final scrollController = ScrollController();
  late TextStyleElements styleElements;
  List<dynamic> list = [];
  bool isLastPage = false;
  String? searchValue;
  LoyaltyTypeItem? selectedItem;
  BasicInfo? basicInfo = BasicInfo();

  SharedPreferences? prefs = locatorRewards<SharedPreferences>();
  late BuildContext ctx;

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (!isLastPage) {
            BlocProvider.of<CubitMain>(ctx).loadPage(
                getBody(), ctx, basicInfo!.LOYALTY_TYPE_LIST, getData);
          }
        }
      }
    });
  }

  dynamic getData(dynamic data) {
    return LoyaltyTypeList.fromJson(data);
  }

  String getBody() {
    return jsonEncode({
      "entity_id": basicInfo!.businessId,
      "search_val": searchValue,
      "page_size": 20,
      "page_number": BlocProvider.of<CubitMain>(ctx).page,
      "app_type": "FOOPWORKS"
    });
  }

  @override
  void initState() {
    setupScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<CubitMain>(context)
          .loadPage(getBody(), context, basicInfo!.LOYALTY_TYPE_LIST, getData);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    styleElements = TextStyleElements(context);

    return Scaffold(
      appBar: appAppBar().getCustomAppBar(
        context,
        appBarTitle: AppLocalizations.of(context)!.translate('select_l_type'),
        actions: [
          appTextButton(
            onPressed: () {
              if (selectedItem != null) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  builder: (BuildContext context) {
                    return Wrap(
                      children: [
                        CommonHelpdeskSheet(
                          child: LoyaltyBenifits(
                            firstItemHint: AppLocalizations.of(context)!
                                .translate('coins'),
                            firstItemTag: AppLocalizations.of(context)!
                                .translate('coin_enter'),
                            secondItemHint:
                                AppLocalizations.of(context)!.translate('cash'),
                            firstItemIcon: Icon(
                              Icons.flip_camera_android_sharp,
                              color: HexColor(AppColors.appColorRed),
                            ),
                            secondItemTag: AppLocalizations.of(context)!
                                .translate('cash_incentive'),
                            title: AppLocalizations.of(context)!
                                .translate("set_l_benefits"),
                            nextCallBack: (cash, coin) {
                              BlocProvider.of<CubitMain>(ctx)
                                  .updateCashCoins(cash, coin);
                              openManageRedemption();
                            },
                            subTitle: AppLocalizations.of(context)!
                                .translate("incentive_des"),
                            secondItemIcon: Icon(
                              Icons.insert_emoticon_outlined,
                              color: HexColor(AppColors.appColorRed),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              } else {
                ToastBuilder().showToast(
                    AppLocalizations.of(context)!.translate("select_type"),
                    context,
                    HexColor(AppColors.information));
              }
            },
            child: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Visibility(
                  visible: false,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.translate("next"),
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
        onBackButtonPress: () {
          Navigator.of(context).pop();
        },
      ),
      body: Stack(
        children: <Widget>[
          Container(
              child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: SearchBox(
                          onvalueChanged: (s) {
                            searchValue = s;
                            BlocProvider.of<CubitMain>(ctx).page = 1;
                            s.isNotEmpty
                                ? BlocProvider.of<CubitMain>(ctx).search(
                                    getBody(),
                                    ctx,
                                    basicInfo!.LOYALTY_TYPE_LIST,
                                    getData)
                                : BlocProvider.of<CubitMain>(ctx).loadPage(
                                    getBody(),
                                    ctx,
                                    basicInfo!.LOYALTY_TYPE_LIST,
                                    getData);
                          },
                          hintText:
                              AppLocalizations.of(context)!.translate('search'),
                        ),
                      ),
                    ];
                  },
                  body: _getBody())),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60,
                color: HexColor(AppColors.appColorWhite),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: AppButtonCommon(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: HexColor(AppColors.appMainColor))),
                        onPressed: () async {
                          if (selectedItem != null) {
                            Navigator.of(context).pop({'result': selectedItem});
                          }
                        },
                        color: HexColor(AppColors.appColorWhite),
                        child: Text(
                          AppLocalizations.of(context!)!.translate('next'),
                          style: styleElements
                              .headline6ThemeScalableW(context)
                              .copyWith(color: HexColor(AppColors.blueApp)),
                        ),
                      ),
                    )),
              ))
        ],
      ),
    );
  }

  Widget _getBody() {
    return BlocBuilder<CubitMain, MainState>(builder: (context, state) {
      if (state is LoadingStatePagination && state.isFirstFetch) {
        return LoadingIndicator();
      }
      bool isLoading = false;
      if (state is LoadingStatePagination) {
        list = state.list;
        isLoading = true;
      } else if (state is Loaded) {
        list = state.list;
        isLastPage = state.isLastPage;
        selectedItem = state.selectedItem;
      }

      return appCard(
          padding: const EdgeInsets.only(left: 0, right: 0, bottom: 60, top: 0),
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: PaginatorListView(
              scrollController: scrollController,
              list: list,
              isLoading: isLoading,
              itemBuilder: listItemBuilder,
            ),
          ));
    });
  }

  openManageRedemption() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            CommonHelpdeskSheet(
              child: LoyaltyBenifits(
                isBothValueRequired: true,
                firstItemHint:
                    AppLocalizations.of(context)!.translate('per_hint'),
                firstItemTag:
                    AppLocalizations.of(context)!.translate('per_hint'),
                secondItemHint:
                    AppLocalizations.of(context)!.translate('coins'),
                secondItemTag:
                    AppLocalizations.of(context)!.translate('en_per'),
                firstItemIcon: Icon(
                  Icons.build,
                  color: HexColor(AppColors.appColorRed),
                ),
                title: AppLocalizations.of(context)!.translate("dis_red"),
                nextCallBack: (cash, coin) {
                  BlocProvider.of<CubitMain>(ctx).updateDiscountCouponDeatails(cash, coin);
                  openManageGiftRedemption();
                },
                subTitle: AppLocalizations.of(context)!.translate("re_des"),
                secondItemIcon: Icon(
                  Icons.gamepad,
                  color: HexColor(AppColors.appColorRed),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  openManageGiftRedemption() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            CommonHelpdeskSheet(
              child: LoyaltyBenifits(
                isBothValueRequired: true,
                firstItemHint:
                AppLocalizations.of(context)!.translate('enter_amt'),
                firstItemTag:
                AppLocalizations.of(context)!.translate('enter_amt'),
                secondItemHint:
                AppLocalizations.of(context)!.translate('coins'),
                secondItemTag:
                AppLocalizations.of(context)!.translate('en_per'),
                firstItemIcon: Icon(
                  Icons.upload_outlined,
                  color: HexColor(AppColors.appColorRed),
                ),
                title: AppLocalizations.of(context)!.translate("mng_gft"),
                nextCallBack: (percentage, coin) {
                  BlocProvider.of<CubitMain>(ctx).updateDiscountCouponDeatails(percentage, coin);
                  openManageDateTime();
                },
                subTitle: AppLocalizations.of(context)!.translate("pg_jj"),
                secondItemIcon: Icon(
                  Icons.youtube_searched_for_rounded,
                  color: HexColor(AppColors.appColorRed),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  openManageDateTime() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      builder: (BuildContext context) {
        return Wrap(
          children: [
            CommonHelpdeskSheet(
              child: DateTimeWidget(

        subTitle: AppLocalizations.of(context)!.translate("program_period_des") ,
                title: AppLocalizations.of(context)!.translate("program_period"),
                nextCallBack: (selectedStartDate,selectedStartTime,selectedEndDate,selectedEndTime) {




                  Navigator.of(context)
                      .push(MaterialPageRoute(
                      builder: (context) => PostCreatePage(
                        type: "feed",
                        isWelcomeMessage: true,
                        mediaFromEdit: null,
                        postId:null,
                        contentData:null,
                        titleLesson: null,
                        isEdit: true,
                      )))
                      .then((value) => {
                    if (value != null && value['payload'] != null)
                      {
                       // createPost(value['payload'])
                      }

                  });
                },

              ),
            ),
          ],
        );
      },
    );
  }



  Widget listItemBuilder(value, int index) {
    LoyaltyTypeItem item = value;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Padding(
          padding: const EdgeInsets.all(0),
          child: CommonListTile(
            title: item.loyaltyTypeName ?? "-",
            subTitle: item.loyaltyTypeDescription ?? "-",
            trailWidget: Checkbox(
              onChanged: (bool? value) {
                BlocProvider.of<CubitMain>(ctx)
                    .updateSelectedItem(value ?? false, index);
              },
              value: item.isSelected,
            ),
          )),
    );
  }
}
