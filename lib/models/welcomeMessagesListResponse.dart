
import 'package:foop_loyalty_plugin/models/postlist.dart';

class WelcomeMessagesListResponse {
  String? statusCode;
  String? message;
  List<WelcomeMessageItem>? rows;
  int? total;

  WelcomeMessagesListResponse(
      {this.statusCode, this.message, this.rows, this.total});

  WelcomeMessagesListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['rows'] != null) {
      rows = <WelcomeMessageItem>[];
      json['rows'].forEach((v) {
        rows!.add(new WelcomeMessageItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class WelcomeMessageItem {
  int? id;
  int? businessId;
  String? messageType;
  String? applicableTo;
  String? avatar;
  String? name;
  MessageDetails? messageDetails;
  String? status;

  WelcomeMessageItem(
      {this.id,
        this.avatar,
        this.name,
        this.businessId,
        this.messageType,
        this.applicableTo,
        this.messageDetails,
        this.status});

  WelcomeMessageItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessId = json['business_id'];
    messageType = json['message_type'];
    applicableTo = json['applicable_to'];
    messageDetails = json['message_details'] != null
        ? new MessageDetails.fromJson(json['message_details'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_id'] = this.businessId;
    data['message_type'] = this.messageType;
    data['applicable_to'] = this.applicableTo;
    if (this.messageDetails != null) {
      data['message_details'] = this.messageDetails!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class MessageDetails {
  ContentMeta? contentMeta;
  List<Media>? mediaDetails;


  String? message;
  String? messageAttachment;
  String? messageAttachmentName;
  String? messageAttachmentType;
  String? messageAttachmentMIMEType;
  String? messageAttachmentThumbnail;

  MessageDetails({this.contentMeta, this.mediaDetails,

    this.message,
    this.messageAttachment,
    this.messageAttachmentName,
    this.messageAttachmentType,
    this.messageAttachmentMIMEType,
    this.messageAttachmentThumbnail


  });

  MessageDetails.fromJson(Map<String, dynamic> json) {


    message = json['message'];
    messageAttachment = json['messageAttachment'];
    messageAttachmentName = json['messageAttachmentName'];
    messageAttachmentType = json['messageAttachmentType'];
    messageAttachmentMIMEType = json['messageAttachmentMIMEType'];
    messageAttachmentThumbnail = json['messageAttachmentThumbnail'];
    contentMeta = json['content_meta'] != null
        ? new ContentMeta.fromJson(json['content_meta'])
        : null;
    if (json['media_details'] != null) {
      mediaDetails = <Media>[];
      json['media_details'].forEach((v) {
        mediaDetails!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();


    data['message'] = this.message;
    data['messageAttachment'] = this.messageAttachment;
    data['messageAttachmentName'] = this.messageAttachmentName;
    data['messageAttachmentType'] = this.messageAttachmentType;
    data['messageAttachmentMIMEType'] = this.messageAttachmentMIMEType;
    data['messageAttachmentThumbnail'] = this.messageAttachmentThumbnail;
    if (this.contentMeta != null) {
      data['content_meta'] = this.contentMeta!.toJson();
    }
    if (this.mediaDetails != null) {
      data['media_details'] =
          this.mediaDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}





