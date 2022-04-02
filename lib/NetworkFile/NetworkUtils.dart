import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:foop_loyalty_plugin/utils/localization.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';


class NetworkUtil {
  // next three lines makes this class a Singleton
  static final NetworkUtil _instance = NetworkUtil.internal();
  BuildContext? context;
  late SharedPreferences prefs;

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url) async {
    return http
        .get(Uri.parse(url))
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 400) {
        throw new Exception(_decoder.convert(res)['error']['message']);
      }
      return res;
    })
        .catchError((onError) {
      if (onError.toString().toLowerCase().contains("socket")) {
        throw Exception("Server timeout");
      } else {
        throw Exception(
            onError.toString().replaceAll("Exception:", ""));
      }
    })
        .timeout(const Duration(seconds: 10))
        .catchError((onError) {
      if (onError.toString().toLowerCase().contains("timeout")) {
        throw Exception("Server timeout");
      } else {
        throw Exception(
            onError.toString().replaceAll("Exception:", ""));
      }
    });
  }

  Future<dynamic> getWithQueryParams(
      Uri uri, Map<String, String> headers) async {
    return http
        .get(uri, headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode >= 400) {
        throw new Exception(_decoder.convert(res)['error']['message']);
      }
      return res;
    })
        .catchError((onError) {
      if (onError.toString().toLowerCase().contains("socket")) {
        throw Exception("Server timeout");
      } else {
        throw Exception(
            onError.toString().replaceAll("Exception:", ""));
      }
    })
        .timeout(const Duration(seconds: 10))
        .catchError((onError) {
      if (onError.toString().toLowerCase().contains("timeout")) {
        throw Exception("Server timeout");
      } else {
        throw Exception(
            onError.toString().replaceAll("Exception:", ""));
      }
    });
  }

  Future<dynamic> post(BuildContext? context, String url,
      {Map? headers, body, encoding, Function? noNetworkCallBack}) async {
    try {

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        this.context = context;
        log('###########################net post...body....$body');
        return http
            .post(Uri.parse( url),
            body: body,
            headers: headers as Map<String, String>?,
            encoding: encoding)
            .then((http.Response response) async {
          final String res = response.body;

          log('res#####################  $url##################$res');
          final int statusCode = response.statusCode;
          final body = jsonDecode(response.body);
          String? stCode = body["statusCode"];
          if (body["detail"] != null && body["detail"] == "Invalid token.") {
            prefs = await SharedPreferences.getInstance();

            await prefs.clear();

          } else if (stCode != null && stCode.startsWith("F")) {

            print(stCode.toString());
            throw Exception("Something is wrong !! please try later");
          } else if (statusCode < 200) {
            throw Exception(_decoder.convert(res)['error']['message']);
          } else if (statusCode >= 400) {
            throw Exception("Something Went Wrong!!");
          }
          return res;
        }).catchError((onError) {
          print(onError.toString());
          if (onError.toString().toLowerCase().contains("timeout"))
            throw new Exception("Server timeout");
          else
            throw new Exception("Something Went Wrong!!");
        });
      }
    } on SocketException catch (_) {
      if (noNetworkCallBack != null) {
        noNetworkCallBack();
      }

      throw Exception(
            AppLocalizations.of(context!)!.translate("no_internet"));
    }
  }


  static Future<String> readResponseAsString(HttpClientResponse response) {
    var completer = new Completer<String>();
    var contents = new StringBuffer();
    response.transform(utf8.decoder).listen((String data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }
}
