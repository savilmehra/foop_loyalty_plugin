import 'dart:convert';
import 'package:foop_loyalty_plugin/bloc/common_widgets/loading_indicator.dart';
import 'package:foop_loyalty_plugin/bloc/common_widgets/paginator_list_view.dart';
import 'package:foop_loyalty_plugin/bloc/common_widgets/rewards_widget.dart';
import 'package:foop_loyalty_plugin/bloc/cubits/cubit_main.dart';
import 'package:foop_loyalty_plugin/bloc/rewards_module/pages/postcreatepage.dart';
import 'package:foop_loyalty_plugin/bloc/states/main_state.dart';
import 'package:foop_loyalty_plugin/bloc/states/states.dart';
import 'package:foop_loyalty_plugin/models/postcreate.dart';
import 'package:foop_loyalty_plugin/models/postlist.dart';
import 'package:foop_loyalty_plugin/models/welcomeMessagesListResponse.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/common_helpdesk_sheet.dart';
import 'package:foop_loyalty_plugin/utils/custom_app_bar.dart';
import 'package:foop_loyalty_plugin/utils/empty_widget.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'loyalty_type_page_new.dart';

class RewardsListPage extends StatefulWidget {
  final String type;
  final String messageTo;

  RewardsListPage({required this.type, required this.messageTo});

  @override
  State<StatefulWidget> createState() => RewardsListPageState();
}

class RewardsListPageState extends State<RewardsListPage> {
  final scrollController = ScrollController();
  late TextStyleElements styleElements;
  List<dynamic> list = [];
  bool isLastPage = false;
  String? searchValue;
  BasicInfo? basicInfo = BasicInfo();

  SharedPreferences? prefs = locatorRewards<SharedPreferences>();
  late BuildContext ctx;

  @override
  void initState() {
    setupScrollController();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<CubitMain>(context).loadPage(
          getBody(), context, basicInfo!.LOYALTY_PROGRAM_LIST, getData);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.ctx = context;
    styleElements = TextStyleElements(context);

    return Scaffold(
      appBar: appAppBar().getCustomAppBar(context,
          appBarTitle: AppLocalizations.of(context!)!.translate("manage_lo_prog"),
          actions: [
            IconButton(
                onPressed: () {









                  openDesiredPage();
                },
                icon: Icon(
                  Icons.add_circle,
                  color: HexColor(AppColors.blueApp),
                ))
          ], onBackButtonPress: () {
        Navigator.pop(context);
      }),
      body: _getBody(),
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
      } else if (state is Empty) {
        return Center(
          child: EmptyWidget(message:AppLocalizations.of(context)!.translate("no_data")),
        );
      }
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: PaginatorListView(
          scrollController: scrollController,
          list: list,
          isLoading: isLoading,
          itemBuilder: getPostWidget,
        ),
      );
    });
  }

  Widget getPostWidget(value, index) {
    WelcomeMessageItem item = value;

    item.avatar = basicInfo!.userImage;
    item.businessId = basicInfo!.businessId;
    item.name = basicInfo!.userName;

    if (widget.type == "chat") {
      if (item.messageDetails?.messageAttachment != null &&
          item.messageDetails!.messageAttachment!.isNotEmpty) {
        Media media = Media();
        media.mediaUrl = item.messageDetails?.messageAttachment ?? "";
        media.mediaThumbnailUrl =
            item.messageDetails?.messageAttachmentThumbnail ?? "";
        media.mediaType = item.messageDetails?.messageAttachmentType ?? "";
        item.messageDetails?.mediaDetails = [media];
      } else
        item.messageDetails?.mediaDetails = [];

      ContentMeta contentMeta = ContentMeta();
      contentMeta.title = null;
      contentMeta.meta = item.messageDetails?.message ?? "";
      ;
      item.messageDetails?.contentMeta = contentMeta;
    }

    return RewardsWidget(
      item: item,
      deleteCallBack: (id) {
        createPost(null, id, "deleted");
      },
      editCallBack: (item) {
        Navigator.of(context)
            .push(MaterialPageRoute(
                builder: (context) => PostCreatePage(
                      type: "feed",
                      isWelcomeMessage: true,
                      mediaFromEdit: item?.messageDetails?.mediaDetails,
                      postId: item?.id,
                      contentData: item?.messageDetails?.contentMeta?.meta,
                      titleLesson: item?.messageDetails?.contentMeta?.title,
                      isEdit: true,
                    )))
            .then((value) => {
                  if (value != null && value['postData'] != null)
                    createPost(value['postData'], item?.id, "active")
                });
      },
    );
  }

  void openDesiredPage() {
    Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                  create: (_) => CubitMain(), child: LoyaltyTypePageNew()),
            ))
        .then((value) => {
              if (value != null && value['postData'] != null)
                createPost(null, null, "active")
            });
  }

  dynamic getData(dynamic data) {
    return WelcomeMessagesListResponse.fromJson(data);
  }

  String getBody() {
    return jsonEncode({
      "business_id": basicInfo!.businessId,
      "page_size": 20,
      "page_number": BlocProvider.of<CubitMain>(ctx).page,
      "app_type": "FOOPWORKS"
    });
  }

  void setupScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (!isLastPage)
            BlocProvider.of<CubitMain>(ctx).loadPage(
                getBody(), ctx, basicInfo!.LOYALTY_TYPE_LIST, getData);
        }
      }
    });
  }

  void createPost(PostCreatePayload? payload, int? id, String status) {
    var bodyRefresh = jsonEncode({
      "business_id": basicInfo!.businessId,
      "applicable_to": widget.messageTo,
      "message_type": widget.type
    });
    var body = jsonEncode({
      "id": id,
      "status": status,
      "business_id": basicInfo!.businessId,
      "applicable_to": widget.messageTo,
      "message_type": widget.type,
      "message_details": {
        "media_details": payload?.mediaDetails,
        "content_meta": payload?.contentMeta
      }
    });
    context.read<CubitMain>().createPost(body, bodyRefresh, context);
  }
}
