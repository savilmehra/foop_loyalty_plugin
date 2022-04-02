import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/customcard.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';
import 'package:foop_loyalty_plugin/utils/toast_builder.dart';

class LoyaltyBenifits extends StatefulWidget {
  final String title;
  final bool isBothValueRequired;
  final String subTitle;
  final String firstItemHint;
  final String firstItemTag;

  final Widget firstItemIcon;
  final Widget secondItemIcon;
  final String secondItemHint;
  final String secondItemTag;

  final Function(int cash, int coin) nextCallBack;

  const LoyaltyBenifits(
      {Key? key,
      required this.title,
        this.isBothValueRequired=false,
        required this.subTitle,
      required this.nextCallBack,
        required  this.secondItemIcon,
        required this.firstItemIcon,
      required this.firstItemHint,
      required this.firstItemTag,
      required this.secondItemHint,
      required this.secondItemTag})
      : super(key: key);

  @override
  LoyaltyBenifitsState createState() => LoyaltyBenifitsState();
}

class LoyaltyBenifitsState extends State<LoyaltyBenifits> {
  GlobalKey<FormState> formKey = GlobalKey();
  final coinsController = TextEditingController();
  final cashController = TextEditingController();

  late TextStyleElements styleElements;

  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    final coins = TextFormField(
      controller: coinsController,
      keyboardType: TextInputType.number,
      style: styleElements
          .subtitle1ThemeScalable(context)
          .copyWith(color: HexColor(AppColors.appColorBlack65)),
      decoration: InputDecoration(
        fillColor: Colors.black12,
        filled: true,
        prefixIcon: widget.firstItemIcon,
        hintText: widget.firstItemHint??"",
        contentPadding: const EdgeInsets.all(16),
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText:widget.firstItemTag,
      ),
    );
    final cash = TextFormField(
      controller: cashController,
      keyboardType: TextInputType.number,
      style: styleElements
          .subtitle1ThemeScalable(context)
          .copyWith(color: HexColor(AppColors.appColorBlack65)),
      decoration: InputDecoration(
        fillColor: Colors.black12,
        filled: true,
        prefixIcon: widget.secondItemIcon,
        hintText:widget.secondItemHint,
        contentPadding: const EdgeInsets.all(16),
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(12)),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: widget.secondItemTag,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.title ?? "-",
                        style: styleElements
                            .headline6ThemeScalable(context)
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: HexColor(AppColors.appColorBlack85)),
                        textAlign: TextAlign.center,
                      )),
                ),
                InkWell(
                  onTap: () {
                    if (
                    widget.isBothValueRequired?
                    cashController.text.isNotEmpty &&
                        coinsController.text.isNotEmpty:


                    cashController.text.isNotEmpty ||
                        coinsController.text.isNotEmpty) {

                      Navigator.pop(context);

                      widget.nextCallBack(
                          cashController.text.isNotEmpty
                              ? int.parse(cashController.text.trim())
                              : 0,
                          coinsController.text.isNotEmpty
                              ? int.parse(coinsController.text)
                              : 0);

                    } else {
                      ToastBuilder().showToast(
                          AppLocalizations.of(context)!.translate(widget.isBothValueRequired?"enter_both":"enter_one"),
                          context,
                          HexColor(AppColors.information));
                    }
                  },
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.translate('next'),
                        style: styleElements
                            .headline6ThemeScalableW(context)
                            .copyWith(color: HexColor(AppColors.blueApp)),
                      ),
                      Icon(Icons.keyboard_arrow_right,
                          color: HexColor(AppColors.blueApp))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              widget.subTitle
             ,
              style: styleElements.captionThemeScalable(context),
            ),
          ),
          Flexible(
              child: Padding(padding: const EdgeInsets.all(8.0), child: coins)),
          const SizedBox(
            width: 20,
          ),
          Flexible(
              child: Padding(padding: const EdgeInsets.all(8.0), child: cash)),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          )
        ],
      ),
    );
  }
}
