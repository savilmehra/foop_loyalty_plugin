import 'package:flutter/material.dart';

import 'package:foop_loyalty_plugin/models/postlist.dart';
import 'package:foop_loyalty_plugin/utils/app_buttons.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'appHtmlViewer.dart';

// ignore: must_be_immutable
class PostCardFooter extends StatefulWidget {
  Content? contentData;
  Statistics? stats;
  bool isRewards;
  Function? commentCallback;
  bool? isDetailPage;
  int? dateTime;
  String? postType;
  Function? onAnswerClickCallback;
  Function? onVoteCallback;
  int? postId;
  bool isVoted;
  int? postOwnerTypeId;
  SharedPreferences? prefs;
  bool? isNewsPage;
  String? webLink;
  bool? isFilterPage;
  Function? onSubmitAnswer;
  String? searchHighlightWord;
  GlobalKey ? globalKeyHtmlWidget;
  ContentMeta ? welcomeMessageData;
  bool isWelcomeChat;
  PostCardFooter(
      {this.contentData,
      this.stats,
        this.isRewards=false,
        this.isWelcomeChat=false,
        this.welcomeMessageData,
        this.globalKeyHtmlWidget,
      this.commentCallback,
      this.isDetailPage,
      this.dateTime,
      this.postType,
      this.postId,
      this.isFilterPage = false,
      this.onVoteCallback,
      this.isVoted = false,
      this.postOwnerTypeId,
      this.prefs,
      this.isNewsPage,
      this.webLink,
      this.onSubmitAnswer,
      this.searchHighlightWord,
      this.onAnswerClickCallback});

  @override
  _PostCardFooter createState() => _PostCardFooter(
      contentData: contentData,
      stats: stats,
      isDetailPage: isDetailPage,
      commentCallback: commentCallback,
      dateTime: dateTime,
      postId: postId,
      postType: postType,
      prefs: prefs,
      postOwnerTypeId: postOwnerTypeId,
      onVoteCallback: onVoteCallback,
      isVoted: isVoted,
      webLink: webLink,
      onSubmitAnswer: onSubmitAnswer,
      onAnswerClickCallback: onAnswerClickCallback);
}

class _PostCardFooter extends State<PostCardFooter> {
  late TextStyleElements styleElements;
  Statistics? stats;
  Content? contentData;
  int? comments;
  Function? commentCallback;
  bool? isDetailPage;
  int? dateTime;
  String? postType;
  int? postId;
  Function? onVoteCallback;
  bool isVoted;
  Function? onAnswerClickCallback;
  int? postOwnerTypeId;
  SharedPreferences? prefs;
  String? webLink;
  Function? onSubmitAnswer;

  _PostCardFooter(
      {this.contentData,
      this.stats,
      this.commentCallback,
      this.isDetailPage=false,
      this.dateTime,
      this.postType,
      this.postId,
      this.onVoteCallback,
      this.isVoted = false,
      this.postOwnerTypeId,
      this.prefs,
      this.webLink,
      this.onSubmitAnswer,
      this.onAnswerClickCallback});

  @override
  Widget build(BuildContext context) {
    print("refreshing post card footer");
    // Utility().screenUtilInit(context);
    // DateTime time =
    // print(timeago.format(time));
    styleElements = TextStyleElements(context);
    comments = stats != null
        ? stats!.commentCount != null
            ? stats!.commentCount
            : 0
        : 0;

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 0.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Visibility(
                                  visible: dateTime!=null,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, bottom: 0, top: 4),
                                    child: Text(
    dateTime!=null? timeago.format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              dateTime!)):"",
                                      style: styleElements
                                          .captionThemeScalable(context)
                                          .copyWith(
                                              fontSize: 10,
                                              color: HexColor(
                                                  AppColors.appColorBlack35)),
                                    ),
                                  ),
                                ),

                    ],
                  ),
                ),
                (isDetailPage!=null && isDetailPage! || (widget.isNewsPage != null && widget.isNewsPage!))
                    ? Visibility(
                        visible: (contentData!=null && contentData!.contentMeta!.title != null &&
                            contentData!.contentMeta!.title!.isNotEmpty),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                                visible: (webLink != null &&
                                    widget.isNewsPage != null &&
                                    widget.isNewsPage!),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    getHost(webLink),
                                    style:
                                        styleElements.overlineThemeScalable(context),
                                  ),
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      contentData!.contentMeta!.title ??= '',
                                      style: styleElements
                                          .subtitle1ThemeScalable(context)
                                          .copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: (webLink != null && webLink!.isNotEmpty),
                                  child: InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 4.0, bottom: 4.0, left: 6, right: 8),
                                        child: Icon(
                                          Icons.open_in_new,
                                          size: 18,
                                          color: HexColor(AppColors.appColorBlack35),
                                        ),
                                      ),
                                      onTap: () {
                                       /* Utility().openWebView(
                                            context, widget.webLink ??= "");*/
                                      }),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    :
                widget.welcomeMessageData!=null?
                Visibility(
                  visible: (widget.welcomeMessageData?.title != null),
                  child: Text(
                    widget.welcomeMessageData!.title ??= '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements
                        .subtitle1ThemeScalable(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ):
                Visibility(
                        visible: (contentData!.contentMeta!.title != null &&
                            contentData!.contentMeta!.title!.isNotEmpty),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            contentData!.contentMeta!.title ??= '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: styleElements
                                .subtitle1ThemeScalable(context)
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                Visibility(
                  visible: false,
                  /*(contentData.contentMeta.subtitle1 != null &&
                      contentData.contentMeta.subtitle1.isNotEmpty),*/
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          color: HexColor(AppColors.appColorBlack35),
                          size: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            contentData!=null ? contentData!.contentMeta!.subtitle1 ??= "":"",
                            style: styleElements.captionThemeScalable(context),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.pin_drop_outlined,
                          color: HexColor(AppColors.appColorBlack35),
                          size: 16,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              contentData!=null? contentData!.contentMeta!.subtitle2 ??= "":"",
                              style: styleElements.captionThemeScalable(context),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                widget.welcomeMessageData!=null?
                Visibility(
                  visible: ( widget.welcomeMessageData?.meta != null),
                  child: Container(
                    child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        // child: Text(
                        child: AppHtmlViewer(
                            key:  widget. globalKeyHtmlWidget,
                            isNewsPage: false,
                            isDetailPage: widget.isWelcomeChat,
                            sourceString: widget.welcomeMessageData?.meta??"",
                           ),
                  ))):
                Visibility(
                        visible: ( contentData!=null&&contentData!.contentMeta!.meta != null &&
                            contentData!.contentMeta!.meta!.isNotEmpty),
                        child: Container(
                          child: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              // child: Text(
                              child: AppHtmlViewer(
                                key:  widget. globalKeyHtmlWidget,
                                  isNewsPage: widget.isNewsPage,
                                  isDetailPage: isDetailPage,
                                  sourceString: contentData!=null? contentData!.contentMeta!.meta:"",
                                  searchHighlightWord: widget.searchHighlightWord)),
                        ),
                      ),



              ],
            ),
          ),
          Visibility(
            visible: widget.isRewards,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                appElevatedButton(
                    onPressed: () async {

                    },
                    color: HexColor(AppColors.appColorGreen),
                    child: RichText(
                      text: TextSpan(
                        children: [

                          WidgetSpan(
                            child: Icon(Icons.attach_money, size: 14),
                          ),
                          TextSpan(
                            text: " 200",
                            style: styleElements
                                .subtitle2ThemeScalable(context)
                                .copyWith(
                                color: HexColor(AppColors.appColorWhite)),
                          ),
                        ],
                      ),
                    )
                       ),
                appElevatedButton(
                    onPressed: () async {

                    },
                    color: HexColor(AppColors.appColorGreen),
                    child: RichText(
                      text: TextSpan(
                        children: [

                          WidgetSpan(
                            child: Icon(Icons.attach_money, size: 14),
                          ),
                          TextSpan(
                            text: " 290",
                            style: styleElements
                                .subtitle2ThemeScalable(context)
                                .copyWith(
                                color: HexColor(AppColors.appColorWhite)),
                          ),
                        ],
                      ),
                    )
                )
              ],
            ),
          )

        ],
      ),
    );
  }

  getlistofkeywords() {
    if ( contentData!=null&& contentData!.keywords != null && contentData!.keywords!.length > 0) {
      List<Widget> list = [];
      for (int i = 0; i < contentData!.keywords!.length; i++) {
        list.add(Padding(
          padding: const EdgeInsets.all(4.0),
          child: Chip(
            label: Text(
              contentData!.keywords![i].toString(),
              style: styleElements.captionThemeScalable(context),
            ),
            backgroundColor: HexColor(AppColors.appColorGrey300),
          ),
        ));
      }
      return list;
    } else {
      List<Widget> list = [];
      list.add(Text(''));
      return list;
    }
  }
  // getlistofmentions() {
  //   if (contentData.mentions != null && contentData.mentions.length > 0) {
  //     List<Widget> list = [];
  //     for (int i = 0; i < contentData.mentions.length; i++) {
  //       list.add(Padding(
  //         padding: const EdgeInsets.all(4.0),
  //         child: Chip(
  //           label: Text(
  //             '@'+contentData.mentions[i].toString(),
  //             style: styleElements.captionThemeScalable(context),
  //           ),
  //           backgroundColor: HexColor(AppColors.appMainColor33)[300],
  //         ),
  //       ));
  //     }
  //     return list;
  //   } else {
  //     List<Widget> list = [];
  //     list.add(Text(''));
  //     return list;
  //   }
  // }

  String getHost(String? path) {
    try {
      if (path != null)
        return Uri.parse(path).host;
      else
        return "";
    } catch (e) {
      print(e);
      return "";
    }
  }
}
