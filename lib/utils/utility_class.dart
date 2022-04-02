import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:html/parser.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import 'package:foop_loyalty_plugin/NetworkFile/calls.dart';
import 'package:foop_loyalty_plugin/models/translate_model.dart';
import 'package:foop_loyalty_plugin/utils/resolutionenums.dart';
import 'package:foop_loyalty_plugin/utils/serviceTypeEnums.dart';
import 'package:path/path.dart' as p;

import 'basicInfo.dart';
import 'colors.dart';
import 'hexColors.dart';
import 'locator.dart';

class Utility {
  static const platform = MethodChannel('samples.flutter.io/email');
  BasicInfo? basicInfo = BasicInfo();


  String getUrlForImage(
      String? url, RESOLUTION_TYPE? resolution, SERVICE_TYPE? service_type,
      {bool shouldprint = false}) {
    String? imageName;
    if (url != null) {
      var s = url.split('/');
      imageName = s[s.length - 1];
    }
    var queryParameters = {
      'name': imageName,
      'resolution': resolution.type,
      'service_type': service_type.type
    };
    var uri = Uri.https(basicInfo!.BASE_URL_WITHOUT_HTTP, basicInfo!.DYNAMIC_IMAGE_URL,
        queryParameters)
        .toString();



    return uri;
  }
  Future<String> getFormattedDate(
      BuildContext context, DateTime date, String localeType) async {
    await initializeDateFormatting(localeType, "");
    var formatter = DateFormat.yMMMd(localeType);

    return formatter.format(date);
  }

  String toCamelCase(String text) {
    if (text.length <= 1) return text.toUpperCase();
    var words = text.split(' ');
    var capitalized = words.map((word) {
      var first = word.substring(0, 1).toUpperCase();
      var rest = word.substring(1);
      return '$first$rest';
    });
    return capitalized.join(' ');
  }

  getCurrency(BuildContext context, num value) {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());

    return (NumberFormat.simpleCurrency(locale: format.locale).format(value));
  }

  getNumberBasedOnLocale(BuildContext context, num value) {
    Locale locale = Localizations.localeOf(context);
    var format = NumberFormat.simpleCurrency(locale: locale.toString());
    final oCcy = new NumberFormat("#,##0.00", format.locale);
    return oCcy.format(num);
  }

  String getCompatNumber(number) {
    return NumberFormat.compact().format(number);
  }

  String getDateFormat(String pattern, DateTime date) {
    var formatter = DateFormat(pattern);
    return formatter.format(date);
  }


  Future<String> recognizeText(File f) async {
    /*  // return true;
    final textDetector = GoogleMlKit.vision.textDetector();

    final inputImage = InputImage.fromFile(f);
    print("**** REACHED HEREEEEEEE******");
    final RecognisedText recognisedText = await textDetector.processImage(inputImage);
    print("**** REACHED HERE******");*/
    return "";
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  void screenUtilInit(BuildContext context) {

  }





  String matchLinkRegex(String text) {
    var regex = new RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))?[\w\-?=%.][-a-zA-Z0-9@:%.\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%\+.~#?&\/=]*)?");
    if (regex.hasMatch(text)) {
      var matchRegex = regex.firstMatch(text)!;
      return text.substring(matchRegex.start, matchRegex.end);
    } else {
      return "";
    }
  }

  int getWordsCountFromRegex(String str) {
    var length = str.split(" ").length;
    return length;
    // var regex = new RegExp(r"[\u0900-\u097F]|\W+");
    // return regex.allMatches(str).length;
  }

  int getWordsCountFromRegexPost(String str) {
    var strs = _parseHtmlString(str);
    var length = strs!.split(" ").length;
    return length;
    // var regex = new RegExp(r"[\u0900-\u097F]|\W+");
    // return regex.allMatches(str).length;
  }

  String? _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String? parsedString =
        parse(document.body!.text).documentElement?.text;
    return parsedString;
  }



  bool checkFileMimeType(String? mimeType) {
    return (mimeType == 'pdf' ||
        mimeType == 'ppt' ||
        mimeType == 'pptx' ||
        mimeType == 'docx' ||
        mimeType == 'doc' ||
        mimeType == 'jpg' ||
        mimeType == 'png' ||
        mimeType == 'jpeg' ||
        mimeType == 'mp4' ||
        mimeType == 'xlsx' ||
        mimeType == 'xls');
  }

  String getExtension(BuildContext context, String path, [int level = 1]) {

    return p.context.extension(path, level).substring(1);
  }

  String getFirstName(String title) {
    var str = title.split(' ');
    return str[0];
  }

  int getTotalMinutes(int totalMinutes, DateTime enterTime) {
    var dateNow = DateTime.now();
    var diff = dateNow.difference(enterTime).inMinutes;

    return diff + totalMinutes;
  }

  Future<String?> translate(BuildContext context, String source,
      String? input_lan_code, String output_lan_code, String type) async {
    final body = jsonEncode({
      "q": source,
      "source": input_lan_code,
      "target": output_lan_code,
      "format": type,
      "key": basicInfo!.GOOGLE_TRANSLATION_KEY,
    });

    var res = await Calls().call(body, context,
        basicInfo!.TRANSLATE + "?key=" +basicInfo!.GOOGLE_TRANSLATION_KEY);
    var response = TranslateResponse.fromJson(res);
    return response.data!.translations![0].translatedText;
  }


  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
