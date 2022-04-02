import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/bloc/common_widgets/postcardmedia.dart';

import 'package:foop_loyalty_plugin/models/welcomeMessagesListResponse.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/customcard.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'PostCardFooter.dart';

class RewardsWidget extends StatefulWidget {
  final WelcomeMessageItem item;
  final Function(WelcomeMessageItem? item) editCallBack;
  final Function(int ?id) deleteCallBack;

  const RewardsWidget(
      {Key? key,
        required this.item,
        required this.editCallBack,
        required this.deleteCallBack})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RewardsWidgetState();
}

class RewardsWidgetState extends State<RewardsWidget> {


  Widget _simplePopup() {
    // var name = headerData.title;
    return PopupMenuButton<String>(
      padding: EdgeInsets.only(right: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      itemBuilder: (context) => getItems(),
      onSelected: (value) {
        switch (value) {
          case 'delete':
            {
              widget.deleteCallBack(widget.item.id);

              break;
            }
          case 'edit':
            {
              widget.editCallBack(widget.item);
              break;
            }
          case 'hide':
            {
              break;
            }
          case 'statistics':
            {
              break;
            }

          case 'unfollow':
            {
              break;
            }
          case 'block':
            {
              break;
            }
          case 'topic':
            {
              break;
            }
          case 'report':
            {
              break;
            }
        }
      },
      icon: Icon(
        Icons.more_vert,
        color: HexColor(AppColors.appColorBlack65),
      ),
    );
  }

  late TextStyleElements styleElements;

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);

    return appCard(
      padding: EdgeInsets.all(0),
      child: Column(
        children: [

          Visibility(
            visible: widget.item.messageDetails!=null && widget.item.messageDetails?.mediaDetails!=null &&widget.item.messageDetails!.mediaDetails!.isNotEmpty,
            child: PostCardMedia(
                postType: "feed",
                mediaList:widget.item.messageDetails!.mediaDetails!.isNotEmpty? widget.item.messageDetails?.mediaDetails:[],
                pagePosition: 0,
                onItemClick: () {}),
          ),
          Padding(
            padding:
            EdgeInsets.only(left: 8, right: 8.0, top: 8.0, bottom: 16.0),
            child: PostCardFooter(
              postOwnerTypeId: widget.item.businessId,
              postId: widget.item.id,
              isRewards: true,
              postType: "feed",
              isWelcomeChat: widget.item.messageType=="chat",
              welcomeMessageData: widget.item.messageDetails?.contentMeta,
            ),
          )
        ],
      ),
    );
  }

  List<PopupMenuEntry<String>> getItems() {
    List<PopupMenuEntry<String>> popupmenuList = [];

    popupmenuList.add(
      PopupMenuItem(
        value: 'delete',
        child: Text(
           AppLocalizations.of(context)!.translate('delete'),
        ),
      ),
    );

    popupmenuList.add(
      PopupMenuItem(
        value: 'edit',
        child: Text(
           AppLocalizations.of(context)!.translate('edit'),
        ),
      ),
    );
    return popupmenuList;
  }
}
