


import 'package:flutter/material.dart';

import 'package:foop_loyalty_plugin/bloc/cubits/cubit_main.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/common_button.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

class OutStandingWidget extends StatefulWidget
{
  final  double? amount;

  OutStandingWidget({this.amount});
  @override
  OutStandingWidgetState createState() => OutStandingWidgetState();
}

class OutStandingWidgetState extends State<OutStandingWidget>
{
  TextStyleElements? styleElements;


  @override
  Widget build(BuildContext context) {

    styleElements = TextStyleElements(context);
    return   Padding(
      padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 8,right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Expanded(
            child: GestureDetector(
              onTap: (){



              /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>

                          BlocProvider(
                            create: (_) => CubitMain(),
                            child:      PaymentPage(

                            ),
                          ),



                    ));*/
              },
              child: Container(
                margin: EdgeInsets.only(right: 16),
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
                                 "Outstanding amount",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: styleElements!
                                      .subtitle2ThemeScalable(context),
                                ),
                              ),

                            ],
                          )),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text("₹ "+(widget.amount??"-").toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: styleElements!
                                      .headline5ThemeScalable(context)),
                            )
                          ],
                        )),

                    SizedBox(
                      height: 4,
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Visibility(
              visible: widget.amount!=null &&  widget.amount!=0 ,
              child: Container(
                  margin: EdgeInsets.only(right: 16),
                  child: AppButtonCommon(
                      onPressed: () async {

                      },
                      color: HexColor(AppColors.appMainColor),
                      child:
                      Text(
                       AppLocalizations.of(context)!.translate('View_Invoices'),
                        style: styleElements!
                            .headline6ThemeScalableW(context)
                            .copyWith(
                            color:
                            HexColor(AppColors.blueApp)),
                      )
                  )

              ),
            ),
          ),
          Container()
        ],
      ),
    );
  }
}