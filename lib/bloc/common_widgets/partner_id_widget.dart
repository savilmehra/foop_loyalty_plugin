import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

class PartnerIdWidget extends StatefulWidget {
  final String? partnerDetails;


  PartnerIdWidget({this.partnerDetails});

  @override
  PartnerIdWidgetState createState() => PartnerIdWidgetState();
}

class PartnerIdWidgetState extends State<PartnerIdWidget> {
  TextStyleElements? styleElements;

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    return Padding(
      padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 8,right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {},
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
                              "Partner (ID: 123456789)",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  styleElements!.subtitle2ThemeScalable(context),
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
                                  child: Text(
                                widget.partnerDetails.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: styleElements!
                                    .bodyText1ThemeScalable(context)
                                    .copyWith(fontWeight: FontWeight.w600),
                              ))
                            ],
                          )),
                    ),
                    const SizedBox(
                      height: 4,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
