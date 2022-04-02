import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:foop_loyalty_plugin/utils/basicInfo.dart';
import 'package:foop_loyalty_plugin/utils/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

import 'NetworkUtils.dart';
class Calls {
  NetworkUtil _netUtil = new NetworkUtil();
  SharedPreferences? prefs = locatorRewards<SharedPreferences>();
  BasicInfo? basicInfo = BasicInfo();
  final JsonDecoder _decoder = new JsonDecoder();


  Future<dynamic> call(String data, BuildContext? context, String url,
      {

      Function? noNetworkCallBack}) async {
    prefs = await SharedPreferences.getInstance();
    var headers;

      headers = {"Content-Type": 'application/json', "Authorization":"Token " +basicInfo!.token};

      return _netUtil
        .post(context, basicInfo!.baseUrl+url,
            body: data, headers: headers, noNetworkCallBack: noNetworkCallBack)
        .then((dynamic res) {

          log(res.toString());
      return _decoder.convert(res.toString());
    });
  }

  Future<dynamic> calWithoutToken(
      String data, BuildContext context, String url) async {
    prefs = await SharedPreferences.getInstance();
    var headers;
    if (prefs!.getString("token") != null) {
      headers = {
        "Content-Type": 'application/json',
      };

    } else {

      headers = {
        "Content-Type": 'application/json',
      };
    }

    return _netUtil
        .post(context, url, body: data, headers: headers)
        .then((dynamic res) {
      return _decoder.convert(res.toString());
    });
  }


  Future<dynamic> getRequest(BuildContext context, String url) async {

    return _netUtil.get(url).then((dynamic res) {
      return _decoder.convert(res.toString());
    });
  }

  Future<dynamic> getQueryrequest(BuildContext context, String authority,
      String url, Map<String, dynamic> params) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs!.getString("token");
    Map<String, String> headers = {
      "Content-Type": 'application/json',
      "Authorization": token!
    };
    var uri = Uri.https(authority, url, params);

    return _netUtil.getWithQueryParams(uri, headers).then((dynamic res) {
      return _decoder.convert(res.toString());
    });
  }

//
// Future<dynamic> createActivityToken(BuildContext context,String activityCode) async{
//   prefs= await SharedPreferences.getInstance();
//   print(data);
//   var headers;
//   if(prefs.getString("token")!=null)
//   {
//     headers = {
//       "Content-Type": 'application/json',
//       "Authorization":  ('Token'+" "+prefs.getString("token"))
//     };
//     print('Token'+" "+prefs.getString("token"));
//     print(url);
//   }
//   else{
//     headers = {
//       "Content-Type": 'application/json',
//
//     };
//     print('Token'+ "Nooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo");
//   }
//
//
//   return _netUtil.post(context,url, body: data,headers:headers).then((dynamic res) {
//     return _decoder.convert(res.toString());
//   });
// }

}
