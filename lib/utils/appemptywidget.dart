import 'package:flutter/material.dart';

import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'appProgressButton.dart';
import 'colors.dart';
import 'hexColors.dart';
import 'localization.dart';
import 'locator.dart';


class appEmptyWidget extends StatelessWidget {
  final String? message;
  final String? assetImage;

  appEmptyWidget({this.message, this.assetImage});

  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(assetImage != null
                    ? assetImage!
                    : 'packages/foop_loyalty_plugin/assets/appimages/empty.png'),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Text(
                message!.isEmpty
                    ?  AppLocalizations.of(context)!.translate('no_data')
                    : message!,
                textAlign: TextAlign.center,
                style: styleElements
                    .subtitle1ThemeScalable(context)
                    .copyWith(color: HexColor(AppColors.appColorBlack35)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomEmptyWidget extends StatelessWidget {
  final String? message;
  final String? actionText;
  final String? assetImage;
  final Function? callBack;

  CustomEmptyWidget(
      {this.message, this.assetImage, this.actionText, this.callBack});

  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Text(
                message!.isEmpty
                    ?  AppLocalizations.of(context)!.translate('no_data')
                    : message!,
                textAlign: TextAlign.center,
                style: styleElements
                    .subtitle1ThemeScalable(context)
                    .copyWith(color: HexColor(AppColors.appColorBlack35)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: appProgressButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: HexColor(AppColors.appMainColor))),
                onPressed: () async {
                  if (callBack != null) callBack!();
                },
                color: HexColor(AppColors.appColorWhite),
                child: Text(
                  actionText ?? "Ok",
                  style: styleElements
                      .subtitle2ThemeScalable(context)
                      .copyWith(color: HexColor(AppColors.appMainColor)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class appEmptyWidgetForAudio extends StatelessWidget {
  final String? message;
  final String? assetImage;

  appEmptyWidgetForAudio({this.message, this.assetImage});

  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(assetImage != null
                    ? assetImage!
                    : 'packages/foop_loyalty_plugin/assets/appimages/avatar-default.png'),
              )),
            ),
            Padding(
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: styleElements
                          .subtitle1ThemeScalable(context)
                          .copyWith(color: HexColor(AppColors.appColorBlack35)),
                      children: [
                        TextSpan(text: 'No audience yet. please invite '),
                        WidgetSpan(
                            child: Icon(
                          Icons.group_add_outlined,
                          color: HexColor(AppColors.appColorBlack35),
                        )),
                        TextSpan(text: ' your followers or share '),
                        WidgetSpan(
                            child: Icon(
                          Icons.share_outlined,
                          color: HexColor(AppColors.appColorBlack35),
                        )),
                        TextSpan(
                            text:
                                ' this work talk with your circle to have more audience.')
                      ]),
                )
                // Text(message.isEmpty?AppLocalizations.of(context).translate('no_data'):message,
                //
                //   textAlign: TextAlign.center,
                //   style: styleElements.subtitle1ThemeScalable(context).copyWith(
                //       color: HexColor(AppColors.appColorBlack35)
                //   ),),
                )
          ],
        ),
      ),
    );
  }
}

class appEmptyWidgetForAudioList extends StatelessWidget {
  final String? message;
  final String? assetImage;

  appEmptyWidgetForAudioList({this.message, this.assetImage});

  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(assetImage != null
                    ? assetImage!
                    : 'packages/foop_loyalty_plugin/assets/appimages/avatar-default.png'),
              )),
            ),
            Padding(
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: styleElements
                          .subtitle1ThemeScalable(context)
                          .copyWith(color: HexColor(AppColors.appColorBlack35)),
                      children: [
                        TextSpan(
                            text:  AppLocalizations.of(context)!.translate('no_audio_events1')),
                        WidgetSpan(
                          child: Icon(
                            Icons.add_circle,
                            size: 30,
                            color: HexColor(AppColors.blueApp),
                          ),
                        ),
                        TextSpan(
                            text:  AppLocalizations.of(context)!.translate('no_audio_events2')),
                      ]),
                )
                // Text(message.isEmpty?AppLocalizations.of(context).translate('no_data'):message,
                //
                //   textAlign: TextAlign.center,
                //   style: styleElements.subtitle1ThemeScalable(context).copyWith(
                //       color: HexColor(AppColors.appColorBlack35)
                //   ),),
                )
          ],
        ),
      ),
    );
  }
}

class appEmptyWidgetForAskQuestions extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('packages/foop_loyalty_plugin/assets/appimages/ask_empty.png',),
              )),
            ),
            Padding(
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: styleElements
                          .subtitle1ThemeScalable(context)
                          .copyWith(color: HexColor(AppColors.appColorBlack35)),
                      children: [
                        TextSpan(
                            text:  AppLocalizations.of(context)!.translate('ask_empty')),
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}

class appEmptyWidgetForBlogList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('packages/foop_loyalty_plugin/assets/appimages/blog_empty.png',),
              )),
            ),
            Padding(
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: styleElements
                          .subtitle1ThemeScalable(context)
                          .copyWith(color: HexColor(AppColors.appColorBlack35)),
                      children: [
                        TextSpan(
                            text:  AppLocalizations.of(context)!.translate('blog_empty')),
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}

class appEmptyWidgetForNews extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('packages/foop_loyalty_plugin/assets/appimages/news_empty.png',),
              )),
            ),
            Padding(
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: styleElements
                          .subtitle1ThemeScalable(context)
                          .copyWith(color: HexColor(AppColors.appColorBlack35)),
                      children: [
                        TextSpan(
                            text:  AppLocalizations.of(context)!.translate('news_empty')),
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}

class appEmptyWidgetForPolls extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('packages/foop_loyalty_plugin/assets/appimages/polling_empty.png',),
              )),
            ),
            Padding(
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: styleElements
                          .subtitle1ThemeScalable(context)
                          .copyWith(color: HexColor(AppColors.appColorBlack35)),
                      children: [
                        TextSpan(
                            text:  AppLocalizations.of(context)!.translate('poll_empty')),
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}

class appEmptyWidgetForNotice extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('packages/foop_loyalty_plugin/assets/appimages/notice_board_empty.png',),
              )),
            ),
            Padding(
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: styleElements
                          .subtitle1ThemeScalable(context)
                          .copyWith(color: HexColor(AppColors.appColorBlack35)),
                      children: [
                        TextSpan(
                            text:  AppLocalizations.of(context)!.translate('notice_empty')),
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}

class appEmptyWidgetForGeneral extends StatelessWidget {


  final String? messages;
  appEmptyWidgetForGeneral(this.messages);
  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('packages/foop_loyalty_plugin/assets/appimages/empty.png',),
              )),
            ),
            messages != null
                ? Padding(
                    padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: styleElements
                              .subtitle1ThemeScalable(context)
                              .copyWith(
                                  color: HexColor(AppColors.appColorBlack35)),
                          children: [
                            TextSpan(text: messages),
                          ]),
                    ))
                : Padding(
                    padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: styleElements
                              .subtitle1ThemeScalable(context)
                              .copyWith(
                                  color: HexColor(AppColors.appColorBlack35)),
                          children: [
                            TextSpan(
                                text:  AppLocalizations.of(context)!.translate('general_empty_1')),
                            WidgetSpan(
                              child: Icon(
                                Icons.add_circle,
                                size: 30,
                                color: HexColor(AppColors.blueApp),
                              ),
                            ),
                            TextSpan(
                                text:  AppLocalizations.of(context)!.translate('general_empty_2')),
                          ]),
                    ))
          ],
        ),
      ),
    );
  }
}

class appEmptyWidgetForBookmark extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);

    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('packages/foop_loyalty_plugin/assets/appimages/bookmark_empty.png',),
              )),
            ),
            Padding(
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: styleElements
                          .subtitle1ThemeScalable(context)
                          .copyWith(color: HexColor(AppColors.appColorBlack35)),
                      children: [
                        TextSpan(
                            text:  AppLocalizations.of(context)!.translate('bookmark_empty_1')),
                        WidgetSpan(
                            child: Image.asset(
                          'packages/foop_loyalty_plugin/assets/appimages/bookmark.png',
                          width: 24,
                          height: 24,
                        )),
                        TextSpan(
                            text:  AppLocalizations.of(context)!.translate('bookmark_empty_2')),
                      ]),
                ))
          ],
        ),
      ),
    );
  }
}
