


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:foop_loyalty_plugin/utils/text_styling.dart';

class AccountDetailsBillingWidget extends StatefulWidget
{
  final  String? avatar;
  final  String? title;
  final  String? subTitle;
  AccountDetailsBillingWidget({this.avatar,this.title,this.subTitle});
  @override
  AccountDetailsBillingWidgetState createState() => AccountDetailsBillingWidgetState();
}

class AccountDetailsBillingWidgetState extends State<AccountDetailsBillingWidget>
{
  TextStyleElements? styleElements;
  @override
  Widget build(BuildContext context) {

    styleElements = TextStyleElements(context);
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 8,right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Account Number",
                        maxLines: 1,
                        style: styleElements!
                            .subtitle2ThemeScalable(context),
                        textAlign: TextAlign.left,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                         top: 8, ),
                      child: Text(
                      "2156-5885",
                        style: styleElements!
                            .bodyText1ThemeScalable(context)
                            .copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    )),

                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only( top: 20),
                      child: Text(
                        "GSTN",
                        maxLines: 1,
                        style: styleElements!
                            .subtitle2ThemeScalable(context),
                        textAlign: TextAlign.left,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                          right: 16),
                      child: Text(
                        "2156-5885-1234",
                        style: styleElements!
                            .bodyText1ThemeScalable(context)
                            .copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    )),

              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top:8.0,bottom: 8.0,right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only( top: 20),
                      child: Text(
                        "Billing address",
                        maxLines: 1,
                        style: styleElements!
                            .subtitle2ThemeScalable(context),
                        textAlign: TextAlign.left,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 8, ),
                      child: Text(
                      widget.title??"",
                        style: styleElements!
                            .bodyText1ThemeScalable(context)
                            .copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                       top: 8, ),
                      child: Text(
                       "address line1",
                        style: styleElements!
                            .subtitle2ThemeScalable(context),
                        textAlign: TextAlign.left,
                      ),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                     top: 8,),
                      child: Text(
                       "address linde2",
                        style: styleElements!
                            .subtitle2ThemeScalable(context),
                        textAlign: TextAlign.left,
                      ),
                    )),



              ],
            ),
          ),
        ),

      ],
    );
  }
}