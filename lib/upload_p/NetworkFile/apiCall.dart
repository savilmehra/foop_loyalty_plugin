import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'NetworkUtils.dart';


class ApiCall {
  NetworkUtils _netUtil = new NetworkUtils();
  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> upload(
      BuildContext context,
      String url,
      String filePath,
      String? token,
      String ownerType,
      String ownerId,
      String contextType,
      String? contextId,
      String subContextType,
      String subContextId,
      String? contentType,
      Function(int progress)? onProgressCallback,

      String? mimeType,
      Function()? networkCallBack,) async {
    return _netUtil
        .upload(
            context,
            url,
            token,
            filePath,
            ownerType,
            ownerId,
            contextType,
            contextId,
            subContextType,
            subContextId,
            contentType,
            onProgressCallback,
            mimeType,
        networkCallBack)
        .then((dynamic res) {
      return _decoder.convert(res.toString());
    });
  }

  Future<dynamic> uploadFolderFile(
    BuildContext context,
    String url,
    String filePath,
    String token,
    String ownerType,
    String ownerId,
    String? id,
    String contentType,
    Function(int progress) onProgressCallback,
    String mimeType,
    Function(String bytes)? onByteUpload,
      Function()? networkCallBack,
  ) async {
    return _netUtil
        .uploadF(context, url, token, filePath, ownerType, ownerId, id,
            contentType, onProgressCallback, mimeType, onByteUpload,networkCallBack)
        .then((dynamic res) {
      return _decoder.convert(res.toString());
    });
  }
}
