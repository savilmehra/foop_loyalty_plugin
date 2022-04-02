import 'package:flutter/material.dart';

import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'colors.dart';
import 'hexColors.dart';

class CircleText extends StatelessWidget {
  final String name;
  final bool showFullText;

  CircleText({required this.name, this.showFullText = false});

  @override
  Widget build(BuildContext context) {
    var styleElements = TextStyleElements(context);
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: HexColor(AppColors.appColorBlack85),
        ),
      ),
      child: Center(
        child: Text(
          showFullText ? name : name[0].toUpperCase(),
          style: styleElements
              .headline6ThemeScalable(context)
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
