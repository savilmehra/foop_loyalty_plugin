import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

class DemoAccountOnOffWidget extends StatefulWidget
{
  final  String? avatar;
  final  String? title;
  final  String? subTitle;
  DemoAccountOnOffWidget({this.avatar,this.title,this.subTitle});
  @override
  DemoAccountOnOffWidgetState createState() => DemoAccountOnOffWidgetState();
}

class DemoAccountOnOffWidgetState extends State<DemoAccountOnOffWidget>
{
  TextStyleElements? styleElements;
  bool isSwitched=false;
  @override
  Widget build(BuildContext context) {

    styleElements = TextStyleElements(context);
    return   Padding(
      padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 8,right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Expanded(
            child: GestureDetector(
              onTap: (){},
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
                                  "Switch off demo account",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: styleElements!
                                      .headline6ThemeScalable(context),
                                ),
                              ),

                            ],
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0),
                      child: GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: null,
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text("You cannot switch back to demo once you subscribe to one of the plans. All demo data will be cleared.",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: styleElements!
                                          .subtitle2ThemeScalable(context)),
                                )
                              ],
                            )),
                      ),
                    ),

                    SizedBox(
                      height: 4,
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
                margin: EdgeInsets.only(right: 16),
                child: Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  },
                ),

            ),
          ),
        ],
      ),
    );
  }
}