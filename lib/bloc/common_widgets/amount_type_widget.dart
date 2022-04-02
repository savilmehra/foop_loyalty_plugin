


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/models/SubscriptionListResponse.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';


class AmountTypeWidget extends StatefulWidget {
  final bool isYearly;
  final SubscriptionPricesList? subscriptionPricesList;


  AmountTypeWidget({ this.subscriptionPricesList, this.isYearly=true});

  @override
  AmountTypeWidgetState createState() => AmountTypeWidgetState();
}

class AmountTypeWidgetState extends State<AmountTypeWidget> {
  TextStyleElements? styleElements;

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    return Padding(
      padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 8,right: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Padding(
            padding: const EdgeInsets.only(top:8.0,bottom: 12.0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.subscriptionPricesList!.activityName??"-",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: styleElements!
                      .headline6ThemeScalable(context)
                  ,
                ),
                Text(
                    "₹"+(widget.isYearly? widget.subscriptionPricesList!.pricePerYear??"-": widget.subscriptionPricesList!.pricePerMonth??"-").toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .headline6ThemeScalable(context)

                ),
              ],
            ),
          ),

          Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: <Widget>[

                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                        onTap: () {

                        },
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(2),
                                child: Text(
                                  "Total",
                                  overflow: TextOverflow.ellipsis,
                                  style: styleElements!
                                      .subtitle2ThemeScalable(context)
                                      .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: HexColor(
                                          AppColors.appColorBlack85)),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 2, left: 2, right: 2),
                                child: Text(
                                  ( widget.subscriptionPricesList!.allocated??"-").toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: styleElements!
                                      .subtitle2ThemeScalable(context),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          onTap: () async {

                          },
                        )),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                        onTap: () {

                        },
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(2),
                                child: Text(
                                  "Used",
                                  overflow: TextOverflow.ellipsis,
                                  style: styleElements!
                                      .subtitle2ThemeScalable(context)
                                      .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: HexColor(
                                          AppColors.appColorBlack85)),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 2, left: 2, right: 2),
                                child: Text(
                                  ( widget.subscriptionPricesList!.usedCount??"-").toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: styleElements!
                                      .subtitle2ThemeScalable(context),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          onTap: () async {

                          },
                        )),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {

                        },
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.all(2),
                                child: Text(
                                  "Available",
                                  overflow: TextOverflow.ellipsis,
                                  style: styleElements!
                                      .subtitle2ThemeScalable(context)
                                      .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: HexColor(
                                          AppColors.appColorBlack85)),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 2, left: 2, right: 2),
                                child: Text(
                                  widget.subscriptionPricesList!.allocated!=null && widget.subscriptionPricesList!.usedCount!=null?
                                  (   widget.subscriptionPricesList!.allocated!- widget.subscriptionPricesList!.usedCount!).toString():"--"

                                  ,
                                  overflow: TextOverflow.ellipsis,
                                  style: styleElements!
                                      .subtitle2ThemeScalable(context),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          onTap: () async {

                          },
                        )),
                  ),
                ),
              ]),

        ],
      ),
    );
  }
}