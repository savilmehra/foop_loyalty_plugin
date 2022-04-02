import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'appAvatar.dart';
import 'app_buttons.dart';
import 'colors.dart';
import 'hexColors.dart';

class appUserListTile extends StatelessWidget {
  final bool isOnline;
  final String? superScriptText;
  final String? title;
  final String? subtitle1;
  final String? subtitle2;
  final String? subtitle3;
  final bool isVerified;
  final String? imageUrl;
  final bool isPerson;
  final bool isFullImageUrl;
  final bool showRating;
  final double rating;
  final bool isModerator;
  final bool showCount;
  final bool showAvatar;
  final int count;
  final Widget? trailingWidget;
  final Function? onPressed;
  final Function? onLongPressed;

  final Widget? subtitleWidget;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final Widget? iconWidget;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Function(int?)? callBack;
  final Widget? trailWidget;
  final int? userId;
  final bool showDivider;

  appUserListTile(
      {this.superScriptText,
      this.iconWidget,
      this.callBack,
      this.userId,
      this.subtitle3,
      this.trailWidget,
      this.isOnline = false,
      this.isVerified = false,
      this.showDivider = false,
      this.title = "",
      this.subtitle1,
      this.subtitle2,
      this.imageUrl,
      this.isPerson = true,
      this.isFullImageUrl = false,
      this.showRating = false,
      this.isModerator = false,
      this.rating = 0.0,
      this.showCount = false,
      this.showAvatar = true,
      this.onLongPressed,
      this.onPressed,
      this.count = 0,

      this.trailingWidget,
      this.subtitleWidget,
      this.titleWidget,
      this.leadingWidget,
      this.decoration,
      this.padding,
      this.margin});

  @override
  Widget build(BuildContext context) {
    var styleElements = TextStyleElements(context);
    return InkWell(
      onTap: () {
        if (callBack != null) {
          callBack!(userId);
        }
        if (onPressed != null) {
          onPressed!();
        }
      },
      onLongPress: () {
        if (onLongPressed != null) {
          onLongPressed!();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              decoration: decoration,
              margin: margin ?? EdgeInsets.all(0),
              padding: padding ??
                  EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 4),
              child: Row(
                children: [
                  iconWidget != null
                      ? iconWidget!
                      : _getAvatar(context, styleElements),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getSuperScript(context, styleElements),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.0, right: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _getTitle(context, styleElements),
                                    _getSubtitle(context, styleElements),
                                    Visibility(
                                      visible: subtitle3 != null,
                                      child: Text(
                                        subtitle3 ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: styleElements
                                            .subtitle1ThemeScalable(context)
                                            .copyWith(
                                                color: HexColor(
                                                    AppColors.appColorBlack35)),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        _ratingWidget(context, styleElements),
                                        _dividerWidget,
                                        Visibility(
                                            visible: isModerator,
                                            child: RoomButtons(context: context)
                                                .moderatorImage),
                                        _dividerWidget,
                                        (subtitle2 != null &&
                                                subtitle2!.isNotEmpty)
                                            ? Flexible(
                                                child: Text(
                                                  subtitle2!,
                                                  style: styleElements
                                                      .bodyText2ThemeScalable(
                                                          context)
                                                      .copyWith(fontSize: 14),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (showCount) _countWidget(context, styleElements),
                            if (trailingWidget != null) trailingWidget!
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: showDivider,
            child: Divider(
              thickness: 1.5,
              height: 1,
              indent: 24,
              endIndent: 12,
              color: HexColor(AppColors.appColorBackground),
            ),
          )
        ],
      ),
    );
  }

  Widget _getSuperScript(
      BuildContext context, TextStyleElements styleElements) {
    return (superScriptText != null && superScriptText!.isNotEmpty)
        ? Row(
            children: [
              Spacer(),
              Text(
                superScriptText!,
                style: styleElements.bodyText2ThemeScalable(context).copyWith(
                    color: HexColor(AppColors.appColorBlack35), fontSize: 12),
              )
            ],
          )
        : Container();
  }

  Widget _getTitle(BuildContext context, TextStyleElements styleElements) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            title!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: styleElements
                .subtitle1ThemeScalable(context)
                .copyWith(color: HexColor(AppColors.appColorBlack85)),
          ),
        ),
        Visibility(
          visible: isVerified,
          child: Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: RoomButtons(context: context).verifiedImage,
          ),
        )
      ],
    );
  }

  Widget _getSubtitle(BuildContext context, TextStyleElements styleElements) {
    return subtitleWidget != null
        ? subtitleWidget!
        : (subtitle1 != null && subtitle1!.isNotEmpty)
            ? Text(
                subtitle1!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: styleElements
                    .bodyText2ThemeScalable(context)
                    .copyWith(color: HexColor(AppColors.appColorBlack35)),
              )
            : new SizedBox.shrink();
  }

  Widget _getAvatar(BuildContext context, TextStyleElements styleElements) {
    return SizedBox(
      height: 52,
      width: 52,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: appAvatar(
              key: UniqueKey(),
              size: 52,
              name: title,
              isFullUrl: isFullImageUrl,
              imageUrl: imageUrl,

            ),
          ),
          Visibility(
            visible: isOnline,
            child: Align(
                alignment: Alignment.bottomRight,
                child: ClipOval(
                  child: Container(
                    height: 12,
                    width: 12,
                    color: HexColor(AppColors.appColorGreen),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget _countWidget(BuildContext context, TextStyleElements styleElements) {
    String c;
    if (count > 100) {
      c = '99+';
    } else {
      c = '$count';
    }
    return Container(
      margin: EdgeInsets.only(top: 4),
      decoration: BoxDecoration(
        color: HexColor(AppColors.appMainColor),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        child: Text(
          c,
          style: styleElements.captionThemeScalable(context).copyWith(
              color: HexColor(AppColors.appColorWhite),
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget get _dividerWidget => Container(
        margin: EdgeInsets.only(left: 4, right: 4),
        color: HexColor(AppColors.appColorBlack35),
        height: 12,
        width: 0,
      );

  Widget _ratingWidget(BuildContext context, TextStyleElements styleElements) {
    return Container();
  }
}

class appCenterAlignedCard extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final Widget? subtitle;

  appCenterAlignedCard(
      {this.leading, this.trailing, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      child: Row(
        children: [
          if (leading != null) leading!,
          SizedBox(
            width: 24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) title!,
                if (subtitle != null) subtitle!,
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
