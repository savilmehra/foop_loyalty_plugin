import 'package:flutter/material.dart';

import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'app_buttons.dart';
import 'localization.dart';

// ignore: must_be_immutable
class appDialog extends StatelessWidget {
  String? message;
  appDialog({this.message});

  @override
  Widget build(BuildContext context) {
    TextStyleElements styleElements = TextStyleElements(context);
    return AlertDialog(
      content: Text(
        message ??= AppLocalizations.of(context)!.translate('you_cant_select'),
        style: styleElements.subtitle1ThemeScalable(context),
      ),
      buttonPadding: EdgeInsets.all(0),
      actions: [
        appTextButton(
          child:
              Text(AppLocalizations.of(context)!.translate('ok').toUpperCase()),
          onPressed: () {
            Navigator.pop(context);
          },
          shape: StadiumBorder(),
        )
      ],
    );
  }
}
