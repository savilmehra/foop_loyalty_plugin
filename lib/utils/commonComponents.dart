import 'package:flutter/material.dart';

import 'colors.dart';
import 'hexColors.dart';

class CommonComponents {
  BoxShadow getShadowforBox() {
    return BoxShadow(
      color: HexColor(AppColors.appColorBlack08),
      offset: Offset(0, 3),
      blurRadius: 6,
    );
  }

  BoxShadow getShadowforBoxSideCard() {
    return BoxShadow(
      color: HexColor(AppColors.appColorBlack16),
      offset: Offset(0, 3),
      blurRadius: 6,
    );
  }

  BoxShadow getShadowforBox_01_3() {
    return BoxShadow(
      color: HexColor(AppColors.appColorBlack08),
      offset: Offset(0, 1),
      blurRadius: 3,
    );
  }

  BoxShadow getShadowforBox_03_9() {
    return BoxShadow(
      color: HexColor(AppColors.appColorBlack08),
      offset: Offset(0, 3),
      blurRadius: 9,
    );
  }
}
