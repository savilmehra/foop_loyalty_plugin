import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'colors.dart';
import 'hexColors.dart';


class AppButtonCommon extends StatefulWidget {
  final double? progressSize;
  final EdgeInsets? padding;
  final Color? progressColor;
  final ShapeBorder? shape;
  final Function? onPressed;
  final Color? color;
  final Widget? child;
  final Color? splashColor;
  final double? elevation;
  AppButtonCommon(
      {Key? key,
        this.elevation,
        this.splashColor,
        this.progressColor,
        this.padding,
        this.progressSize,
        this.shape,
        this.onPressed,
        this.color,
        this.child})
      : super(key: key);
  @override
  AppButtonCommonState createState() => AppButtonCommonState();
}

class AppButtonCommonState extends State<AppButtonCommon> {
  bool isProgress = false;
  TextStyleElements? styleElements;
  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    return Container(child: InkWell(
      onTap: (){

        if(widget.onPressed!=null)
          widget.onPressed!();
      },
      child: Padding(
        padding:widget.padding?? const EdgeInsets.all(16.0),
        child: _getChild,
      ),
    ));
  }

  Widget get _getChild {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
            visible: isProgress,
            child: Padding(
              padding: EdgeInsets.only(left: 4, right: 8),
              child: SizedBox(
                height: widget.progressSize != null ? widget.progressSize : 16,
                width: widget.progressSize != null ? widget.progressSize : 16,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color?>(
                      widget.progressColor ?? HexColor(AppColors.appMainColor)),
                ),
              ),
            )),
        widget.child!,
      ],
    );
  }


  void show() {
    setState(() {
      isProgress = true;
    });
  }

  void hide() {
    setState(() {
      isProgress = false;
    });
  }
}
