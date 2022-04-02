import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

import 'app_buttons.dart';
import 'appemptywidget.dart';
import 'colors.dart';
import 'hexColors.dart';
import 'localization.dart';
import 'locator.dart';

class CustomPaginator {
  BuildContext context;


  List<dynamic>? listItemsGetter(dynamic response) {
    return response.rows;
  }

  List<dynamic>? listItemsGetterPhotos(dynamic response) {
    return response.rows[0].subRow;
  }



  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(HexColor(AppColors.appMainColor)),
      ),
    );
  }







  Widget errorWidgetMaker(dynamic response, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        /*  Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(AppLocalizations.of(context).translate('see_more')"There has been a server Error",
            style: TextStyle(
              fontSize: 16,
              color: HexColor(AppColors.appMainColor),
              fontWeight: FontWeight.bold
            ),
          ),
        ),*/
        appElevatedButton(
          onPressed: retryListener,
          color: HexColor(AppColors.appColorWhite),
          child: Text(
              AppLocalizations.of(context)!.translate('retry'),
            style: TextStyleElements(context)
                .buttonThemeScalable(context)
                .copyWith(color: HexColor(AppColors.appMainColor)),
          ),
        )
      ],
    );
  }

  Widget blank(dynamic response, retryListener) {
    return Center(
      child: Container(),
    );
  }


  Widget emptyListWidgetCustom() {
    return Center(
        child: CustomEmptyWidget()
    );
  }

  Widget emptyListWidgetMaker(dynamic response,{String? message,String? assetImage}) {
    return Center(
        child: appEmptyWidget(
      message: message ??  AppLocalizations.of(context)!.translate('no_data'),
      assetImage: assetImage,
    ));
  }


  int? totalPagesGetter(dynamic response) {
    return response.total;
  }


  CustomPaginator(this.context);
}
