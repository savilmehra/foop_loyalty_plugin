import 'package:flutter/material.dart';


class TextStyleElements {
  Color? color;
  double? fontSize;
  BuildContext? context;

  TextStyleElements(this.context){


  }

  TextStyle headline1ThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.headline1!.copyWith(fontSize: 96);
  }

  TextStyle headline2ThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.headline2!.copyWith(fontSize: 60);
  }

  TextStyle headline3ThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.headline3!.copyWith(fontSize: 48);
  }

  TextStyle headline4ThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.headline4!.copyWith(fontSize: 34);
  }


  TextStyle headline5ThemeScalableBold(BuildContext context){
    return Theme.of(context).textTheme.headline5!.copyWith(fontSize: 24,fontWeight: FontWeight.bold);
  }
  TextStyle headline5ThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.headline5!.copyWith(fontSize: 24);
  }

  TextStyle headlinecustomThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.headline6!.copyWith(fontSize: 20);
  }

  TextStyle headline6ThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18,fontWeight: FontWeight.w600);
  }


  TextStyle headline6ThemeScalableW(BuildContext context){
    return Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 16,fontWeight: FontWeight.w600);
  }
  TextStyle subtitle1ThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 16);
  }
  TextStyle subtitle2ThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 14);
  }
  TextStyle bodyText1ThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16);
  }
  TextStyle bodyText2ThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14);
  }
  TextStyle captionThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.caption!.copyWith(fontSize: 12);
  }
  TextStyle buttonThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.button!.copyWith(fontSize: 14);
  }
  TextStyle overlineThemeScalable(BuildContext context){
    return Theme.of(context).textTheme.overline!.copyWith(fontSize: 10);
  }


  TextStyle textStyleRegular() {
    return TextStyle(
        fontSize: fontSize,
        color: color ?? null,
        fontFamily: 'Source sans pro',
        fontWeight: FontWeight.w400);
  }

  TextStyle textStyleMedium() {
    return TextStyle(
        fontSize: fontSize,
        color: color ?? null,
        fontFamily: 'Source sans pro',
        fontWeight: FontWeight.w500);
  }

  TextStyle textStyleBold() {
    return TextStyle(
        fontSize: fontSize,
        color: color ?? null,
        fontFamily: 'Source sans pro',
        fontWeight: FontWeight.w700);
  }

  TextStyle textStyleBold900() {
    return TextStyle(
        fontSize: fontSize,
        color: color ?? null,
        fontFamily: 'Source sans pro',
        fontWeight: FontWeight.w900);
  }

  TextStyle textStyleLight() {
    return TextStyle(
        fontSize: fontSize,
        color: color ?? null,
        fontFamily: 'Source sans pro',
        fontWeight: FontWeight.w300);
  }

}