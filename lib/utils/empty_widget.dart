import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';


import 'colors.dart';
import 'hexColors.dart';
import 'localization.dart';
import 'locator.dart';



class EmptyWidget extends StatelessWidget {
  final String? message;


  EmptyWidget({this.message});

  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/appimages/empty.png',),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Text(
                message!.isEmpty
                    ? AppLocalizations.of(context!)!.translate('no_data')
                    : message!,
                textAlign: TextAlign.center,
                style: styleElements
                    .subtitle1ThemeScalable(context)
                    .copyWith(color: HexColor(AppColors.appColorBlack35)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
