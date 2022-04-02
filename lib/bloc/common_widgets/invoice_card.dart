import 'package:flutter/material.dart';

import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

class InvoiceCard extends StatefulWidget
{
  final  String? avatar;
  final  String? title;
  final  String? subTitle;
  InvoiceCard({this.avatar,this.title,this.subTitle});
  @override
  InvoiceCardState createState() => InvoiceCardState();
}

class InvoiceCardState extends State<InvoiceCard>
{
  TextStyleElements? styleElements;
  @override
  Widget build(BuildContext context) {

    styleElements = TextStyleElements(context);
    return


        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Invoice date",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "31 July 2021",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Invoice #",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2345678900132",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Subscription plan - STARTER",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .headline6ThemeScalableW(context),

                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Subscription period",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle1ThemeScalable(context),

                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 2.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "From",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "31 July 2021",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 2.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "To",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "31 July 2021",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Employee license",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle1ThemeScalable(context),

                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Qty: 2 Nos",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Secondary partner license",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle1ThemeScalable(context),

                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Qty: 2 Nos",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Secondary partner license",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle1ThemeScalable(context),

                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Qty: 2 Nos",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Sub Total",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),

            const Divider(
              height: 2,
              thickness: 0.5,
              indent: 0,
              endIndent: 0,
            ),


            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Tax",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle1ThemeScalable(context),

                  ),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "IGST",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "SGST",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "CGST",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Total Tax",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),

            const Divider(
              height: 2,
              thickness: 0.5,
              indent: 0,
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Grand total",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Paid",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Balance",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: styleElements!
                        .subtitle2ThemeScalable(context),

                  ),
                  Text(
                      "2300.00",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: styleElements!
                          .headline6ThemeScalableW(context)

                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: (){

                },
                child: Center(
                  child: Text(
                    "Download",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: styleElements!
                        .headline6ThemeScalableW(context)
                        .copyWith(color: HexColor(AppColors.blueApp)),
                  ),
                ),
              ),
            ),
          ],
        );
  }
}