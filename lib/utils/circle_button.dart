import 'package:flutter/material.dart';

import 'colors.dart';
import 'hexColors.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData iconData;
  final double size;
  final double iconsize;
  final Color? color;
  const CircleButton(
      {Key? key,
      required this.onTap,
      required this.iconData,
      this.size = 20,
      this.iconsize = 16,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color ?? HexColor(AppColors.appMainColor),
          shape: BoxShape.circle,
        ),
        child: Icon(
          iconData,
          size: iconsize,
          color: HexColor(AppColors.appColorWhite),
        ),
      ),
    );
  }
}
