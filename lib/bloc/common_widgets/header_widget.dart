


import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/common_button.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

class HeaderWidget extends StatefulWidget
{
  final String baseUrl;
 final  String? avatar;
 final  String? title;
 final  String? subTitle;
 HeaderWidget({this.avatar,this.title,this.subTitle,required this.baseUrl});
 @override
 HeaderWidgetState createState() => HeaderWidgetState();
}

class HeaderWidgetState extends State<HeaderWidget>
{


  TextStyleElements? styleElements;
  @override
  Widget build(BuildContext context) {

    styleElements = TextStyleElements(context);
 return   Row(
   mainAxisAlignment: MainAxisAlignment.spaceBetween,
   children: <Widget>[
     GestureDetector(
       onTap: () {

       },
       child: Container(
         margin: EdgeInsets.all(4),
         height: 60,
         width: 60,
         child:   Align(
             alignment: Alignment.topLeft,
             child: CircleAvatar(
                 key: UniqueKey(),
                 foregroundColor: HexColor(AppColors.appColorWhite),
                 backgroundColor: HexColor(AppColors.appColorWhite),
                 backgroundImage: NetworkImage(widget.baseUrl+(widget.avatar??"")),
                 radius: 52)),
       ),
     ),
     Expanded(
       child: GestureDetector(
         onTap: (){},
         child: Container(

           child: Padding(
             padding: const EdgeInsets.only(left :12.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Align(
                   alignment: Alignment.topLeft,
                   child: Container(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Flexible(
                             child: Text(
                               widget.title??"-",
                               maxLines: 2,
                               overflow: TextOverflow.ellipsis,
                               style: styleElements!
                                   .headline6ThemeScalable(context)
                                   .copyWith(
                                   fontWeight: FontWeight.bold,
                                   color: HexColor(AppColors.appColorBlack85)),
                             ),
                           ),

                         ],
                       )),
                 ),
                 GestureDetector(
                   behavior: HitTestBehavior.translucent,
                   onTap: null,
                   child: Align(
                       alignment: Alignment.bottomLeft,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Flexible(
                             child: Text(widget.subTitle ?? "-",
                                 maxLines: 2,
                                 overflow: TextOverflow.ellipsis,
                                 style: styleElements!
                                     .captionThemeScalable(context)),
                           )
                         ],
                       )),
                 ),

                 SizedBox(
                   height: 4,
                 )
               ],
             ),
           ),
         ),
       ),
     ),
     Center(
       child: Container(
           margin: EdgeInsets.only(right: 16),
           child: AppButtonCommon(
               onPressed: () async {

               },
               color: HexColor(AppColors.appMainColor),
               child:
               Text(
                  AppLocalizations.of(context)!.translate('edit'),
                 style: styleElements!
                     .headline6ThemeScalableW(context)
                     .copyWith(
                     color:
                     HexColor(AppColors.blueApp)),
               )
           )

       ),
     ),
    Container()
   ],
 );
  }
}