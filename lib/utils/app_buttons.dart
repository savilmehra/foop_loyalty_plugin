import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'colors.dart';
import 'hexColors.dart';
import 'localization.dart';
import 'locator.dart';


class appTextButton extends StatelessWidget {
  final Function? onPressed;
  final String? buttonText;
  final Widget? child;
  final Color? color;
  final OutlinedBorder? shape;
  final EdgeInsets? padding;
  final double? elevation;
  final Color? boarderColor;

  appTextButton(
      {required this.onPressed,
      this.buttonText,
      this.child,
      this.color,
      this.shape,
      this.padding,
      this.elevation,
      this.boarderColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed as void Function()?,
        style: TextButton.styleFrom(
          shape: shape,
          backgroundColor: color,
          elevation: elevation,
          side: BorderSide(
              color: boarderColor != null
                  ? boarderColor!
                  : HexColor(AppColors.appColorTransparent)),
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.only(left: 6, right: 6),
          child: child,
        ));
  }
}

class appElevatedButton extends StatelessWidget {
  final Function? onPressed;
  final String? buttonText;
  final Widget? child;
  final Color? color;
  final OutlinedBorder? shape;
  final EdgeInsets? padding;
  final double? elevation;
  final Color? boarderColor;

  appElevatedButton(
      {required this.onPressed,
      this.buttonText,
      this.child,
      this.color,
      this.shape,
      this.padding,
      this.elevation,
      this.boarderColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          if (onPressed != null) {
            onPressed!();
          }
        },
        style: ElevatedButton.styleFrom(
          shape: shape,
          primary: color,
          side: BorderSide(
              color: boarderColor != null
                  ? boarderColor!
                  : HexColor(AppColors.appColorTransparent)),
          elevation: elevation,
        ),
        child: Padding(
          padding: padding ?? EdgeInsets.only(left: 6, right: 6),
          child: child,
        ));
  }
}


class
RoomButtons{

  Function? onPressed;
  BuildContext? context;
  late TextStyleElements styleElements;
  RoomButtons({this.onPressed,this.context}){
    styleElements = TextStyleElements(context);
  }

  String getByTitle(String? title, subtitle) {
    StringBuffer buff= StringBuffer();
    buff.write(' by ');
    buff.write(title ?? '');
    buff.write(subtitle!=null?', ':"");
    buff.write(subtitle ?? '');
    return buff.toString();
  }

  Widget get moderatorImage{
    return Image.asset('packages/foop_loyalty_plugin/assets/appimages/moderator.png',width: 12,height: 12,);
  }
  Widget get verifiedImage{
    return Image.asset('packages/foop_loyalty_plugin/assets/appimages/check.png',width: 16,height: 16,);
  }

  Widget getmoderatorImage(Size size){
    return Image.asset('packages/foop_loyalty_plugin/assets/appimages/moderator.png',width: 12,height: 12,);
  }

  Widget get exitButton {
    return appTextButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(0),
      child: Text(  AppLocalizations.of(context!)!.translate('exit'), style: styleElements.captionThemeScalable(context!).copyWith(fontWeight: FontWeight.bold,color:HexColor(AppColors.appMainColor),)),
    );
    // return GestureDetector(
    //    onTap: onPressed,
    //   // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0),),
    //   // color: HexColor(AppColors.appMainColor),
    //  child: Padding(
    //    padding: const EdgeInsets.all(8.0),
    //    child: Text(AppLocalizations.of(context).translate('exit'), style: styleElements.captionThemeScalable(context).copyWith(fontWeight: FontWeight.bold,color:HexColor(AppColors.appMainColor),)),
    //  ),
    //  );
  }

  Widget get joinButton {

    return appTextButton(
      onPressed: onPressed,
      color: HexColor(AppColors.appMainColor),
      child: Text(  AppLocalizations.of(context!)!.translate('join'),
          style: styleElements.captionThemeScalable(context!).copyWith(fontWeight: FontWeight.bold,
            color:HexColor(AppColors.appColorWhite),)),
    );

    // return GestureDetector(
    //   onTap: onPressed,
    //   // shape:RoundedRectangleBorder(
    //   //     borderRadius: BorderRadius.circular(25.0),
    //   //     side: BorderSide(color: HexColor(AppColors.appMainColor))
    //   // ),
    //   // color: HexColor(AppColors.appColorTransparent),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Text(AppLocalizations.of(context).translate('join'), style: styleElements.captionThemeScalable(context).copyWith(fontWeight: FontWeight.bold,color:HexColor(AppColors.appMainColor),)),
    //   ),
    // );
  }

  Widget get editButton {
    return appTextButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(0),
      shape: const StadiumBorder(),
      child: Text(  AppLocalizations.of(context!)!.translate('edit'), style: styleElements.captionThemeScalable(context!).copyWith(fontWeight: FontWeight.bold,color:HexColor(AppColors.appMainColor),)),
    );
    //
    // return GestureDetector(
    //   onTap: onPressed,
    //   // shape: RoundedRectangleBorder(),
    //   // color: HexColor(AppColors.appColorTransparent),
    //   child: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: Text(AppLocalizations.of(context).translate('edit'), style: styleElements.captionThemeScalable(context).copyWith(fontWeight: FontWeight.bold,color:HexColor(AppColors.appMainColor),)),
    //   ),
    // );
  }

}
