import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'colors.dart';
import 'hexColors.dart';
import 'localization.dart';
import 'locator.dart';


// ignore: must_be_immutable
class SearchBox extends StatefulWidget {
  Function(String value) onvalueChanged;
  String? hintText;
  bool? progressIndicator;
  bool? isFilterVisible;
  Function? onFilterClick;
  bool isDemoBox;
  Function? onBoxClick;
  Widget? clearText;
  TextEditingController? controller;
  IconData? icon;

  SearchBox(
      {Key? key,
      required this.onvalueChanged,
      this.progressIndicator,
      this.hintText,
      this.icon,
      this.clearText,
      this.isFilterVisible,
      this.onBoxClick,
      this.isDemoBox = false,
      this.controller,
      this.onFilterClick})
      : super(key: key);

  @override
  SearchBoxState createState() => SearchBoxState(
      hintText: hintText,
      onvalueChanged: onvalueChanged,
      progressIndicator: progressIndicator,
      isFilterVisible: isFilterVisible,
      onFilterClick: onFilterClick);
}

class SearchBoxState extends State<SearchBox> {
  Function(String value)? onvalueChanged;
  String? hintText;
  Timer? searchOnStoppedTyping;
  bool? progressIndicator;
  late TextStyleElements styleElements;

  bool? isFilterVisible;
  Function? onFilterClick;
  TextEditingController controller = TextEditingController();

  SearchBoxState(
      {this.onvalueChanged,
      this.hintText,
      this.progressIndicator,
      this.isFilterVisible,
      this.onFilterClick});

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap:
                widget.isDemoBox ? widget.onBoxClick as void Function()? : null,
            child: Container(
              height: 48,
              margin: EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexColor(AppColors.appColorWhite),
                    HexColor(AppColors.appColorWhite),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.0)),

              ),
              child: Center(
                child: Container(
                    child: Row(
                  children: <Widget>[
                    widget.isDemoBox
                        ? Padding(
                            padding: EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Icon(
                                widget.icon ?? Icons.search,
                                color: HexColor(AppColors.appColorBlack65)))
                        : Container(),
                    widget.isDemoBox
                        ? Expanded(
                            child: Text(
                               AppLocalizations.of(context)!.translate("search"),
                              style: styleElements
                                  .bodyText2ThemeScalable(context)
                                  .copyWith(
                                      color:
                                          HexColor(AppColors.appColorBlack35)),
                            ),
                          )
                        : Expanded(
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              controller: controller,
                              onChanged: (value) {
                                const duration = Duration(
                                    milliseconds:
                                        700); // set the duration that you want call search() after that.
                                if (searchOnStoppedTyping != null) {
                                  searchOnStoppedTyping!
                                      .cancel(); // clear timer
                                }
                                searchOnStoppedTyping = new Timer(
                                    duration, () => onvalueChanged!(value));
                              },
                              style: styleElements
                                  .subtitle1ThemeScalable(context)
                                  .copyWith(
                                      color:
                                          HexColor(AppColors.appColorBlack65)),
                              decoration: InputDecoration(
                                hintText:
                                    (hintText != null || hintText!.isNotEmpty)
                                        ? hintText
                                        : "Search",
                                border: InputBorder.none,
                                hintStyle: styleElements
                                    .bodyText2ThemeScalable(context)
                                    .copyWith(
                                        color: HexColor(
                                            AppColors.appColorBlack35)),
                                prefixIcon: Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Icon(Icons.search,
                                        color: HexColor(
                                            AppColors.appColorBlack65))),
                              ),
                            ),
                          ),
                    Visibility(
                        visible: widget.clearText != null &&
                            controller.text.length >= 1,
                        child: widget.clearText ?? Container()),
                    Visibility(
                        visible: progressIndicator ??= false,
                        child: Container(
                          margin: EdgeInsets.all(16),
                          child: new SizedBox(
                            height: 20.0,
                            width: 20.0,
                            child: new CircularProgressIndicator(
                              value: null,
                              strokeWidth: 2.0,
                            ),
                          ),
                        ))
                  ],
                )),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isFilterVisible ??= false,
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: onFilterClick as void Function()?,
              child: Icon(
                Icons.filter_list,
                size: 24,
                color: HexColor(AppColors.appColorBlack35),
              ),
            ),
          ),
        )
      ],
    );
  }
}
