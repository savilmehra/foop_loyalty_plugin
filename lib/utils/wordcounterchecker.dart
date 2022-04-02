import 'package:flutter/material.dart';

import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'colors.dart';
import 'hexColors.dart';
import 'localization.dart';
import 'locator.dart';

class WordCounterChecker extends StatefulWidget {
  final int? currentWordCount;
  final int wordLimit;
  final bool isMinimumWords;
  WordCounterChecker(
      {Key? key,
      this.currentWordCount,
      required this.wordLimit,
      required this.isMinimumWords})
      : super(key: key);
  @override
  WordCounterCheckerState createState() => WordCounterCheckerState(
      currentWordCount: currentWordCount, wordLimit: wordLimit);
}

class WordCounterCheckerState extends State<WordCounterChecker> {
  int? currentWordCount = 0;
  final int? wordLimit;
  bool isWordLimitReached = false;


  WordCounterCheckerState({this.currentWordCount, this.wordLimit});
  @override
  Widget build(BuildContext context) {
    var styleElements = TextStyleElements(context);
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Visibility(
            visible: isWordLimitReached && !widget.isMinimumWords,
            child: Text(
               AppLocalizations.of(context)!.translate('max_word_limit_reached'),
              style: styleElements
                  .captionThemeScalable(context)
                  .copyWith(color: HexColor(AppColors.appMainColor)),
            )),
        // Visibility(
        //     visible: isWordLimitReached && !widget.isMinimumWords,
        //     child: Text(AppLocalizations.of(context)!.translate('max_word_limit_reached'),style: styleElements.captionThemeScalable(context).copyWith(color: HexColor(AppColors.appMainColor)),)),
        Spacer(),
        Visibility(
            visible: !widget.isMinimumWords,
            child: Text(
              "$currentWordCount/$wordLimit",
              style: styleElements.captionThemeScalable(context),
            )),
        Visibility(
            visible: widget.isMinimumWords,
            child: Text(
              "$currentWordCount words",
              style: styleElements.captionThemeScalable(context),
            )),
      ]),
    );
  }

  void updateWidget(int wordCount) {
    setState(() {
      currentWordCount = wordCount;
      isWordLimitReached = currentWordCount! > wordLimit!;
    });
  }
}
