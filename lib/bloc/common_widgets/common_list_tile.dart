
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foop_loyalty_plugin/bloc/cubits/cubit_main.dart';
import 'package:foop_loyalty_plugin/bloc/rewards_module/pages/rewards_list_page.dart';
import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/circle_text.dart';
import 'package:foop_loyalty_plugin/utils/colors.dart';
import 'package:foop_loyalty_plugin/utils/hexColors.dart';
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/text_styling.dart';

class CommonListTile extends StatefulWidget
{
  final  String ? title;
  final  String ? subTitle;
  final  String ? image;
  final Widget ? trailWidget;
  const CommonListTile({Key? key, this.title, this.subTitle,this.image,this.trailWidget}) : super(key: key);
  @override
  CommonListState createState() => CommonListState();
}


class CommonListState extends State<CommonListTile>


{
  BasicInfo? basicInfo = BasicInfo();

  late TextStyleElements styleElements;
  @override
  Widget build(BuildContext context) {
    styleElements = TextStyleElements(context);
    return    InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => CubitMain(),
                child: RewardsListPage(
                  type: 'post',
                  messageTo: 'team',
                ),
              ),
            ));
      },
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        child: ListTile(
            leading: CircleText(name: widget.title??"-",),
            title: Text(
              widget.title??"-",
              style: styleElements.bodyText1ThemeScalable(context),
            ),
            subtitle: Text(
              widget.subTitle??"-",
              style: styleElements.captionThemeScalable(context),
            ),
            trailing: widget.trailWidget??Container()
        ),
      ),
    );
  }
}