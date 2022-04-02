import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foop_loyalty_plugin/utils/resolutionenums.dart';

import 'package:foop_loyalty_plugin/utils/serviceTypeEnums.dart';
import 'package:foop_loyalty_plugin/utils/utility_class.dart';

import 'appAvatar.dart';
import 'colors.dart';
import 'hexColors.dart';

class DpEnlargePage extends StatefulWidget {
  final String? imageUrl;
  final SERVICE_TYPE? service_type;
  final bool? isFullUrl;
  final bool isFromAsset;
  final String? name;
  final Color? color;
  DpEnlargePage(
      {this.imageUrl,
      this.service_type,
      this.color,
      this.isFullUrl,
      this.isFromAsset = false,
      this.name});
  @override
  DpEnlargePageState createState() => DpEnlargePageState();
}

class DpEnlargePageState extends State<DpEnlargePage> {
  @override
  Widget build(BuildContext context) {
    double _sigmaX = 10.0; // from 0-10
    double _sigmaY = 10.0; // from 0-10
    double _opacity = 0.5;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (widget.isFromAsset
                            ? AssetImage(widget.imageUrl!)
                            : CachedNetworkImageProvider(widget.isFullUrl!
                                ? widget.imageUrl!
                                : Utility().getUrlForImage(widget.imageUrl,
                                    RESOLUTION_TYPE.R64, widget.service_type)))
                        as ImageProvider<Object>),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                child: Container(
                  color:
                      HexColor(AppColors.appColorBlack).withOpacity(_opacity),
                ),
              ),
            ),
            Center(
              child: appAvatar(
                key: UniqueKey(),
                imageUrl: widget.imageUrl,
                resolution_type: RESOLUTION_TYPE.R256,
                service_type: widget.service_type,
                size: 256,
                isFullUrl: widget.isFullUrl,
                withBorder: true,
                borderColor: HexColor(AppColors.appColorWhite),
                borderSize: 4,
                isClickable: false,
                isFromAsset: widget.isFromAsset,
                name: widget.name,
                color: widget.color,
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.keyboard_backspace_rounded,
                  color: HexColor(AppColors.appColorWhite),
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }
}
