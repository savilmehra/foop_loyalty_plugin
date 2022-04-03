import 'package:foop_loyalty_plugin/models/postcreate.dart';
import 'package:foop_loyalty_plugin/models/postlist.dart';

class CreateRewardPayload {
  int? businessId;
  int? standardLoyaltyProgramTypesId;
  List<MediaDetails>? mediaUrls;
  String? title;
  String? subtitle;
  List<String?>? recipientType;
  List<PostRecipientDetailItem?>? recipientDetails;
  int? startDatetime;
  int? endDatetime;
  int? incentiveCoins;
  int? incentiveCash;
  String? incentiveCurrency;
  RedemptionDetails? redemptionDetails;
  String? status;

  CreateRewardPayload(
      {this.businessId,
        this.standardLoyaltyProgramTypesId,
        this.mediaUrls,
        this.title,
        this.subtitle,
        this.recipientType,
        this.recipientDetails,
        this.startDatetime,
        this.endDatetime,
        this.incentiveCoins,
        this.incentiveCash,
        this.incentiveCurrency,
        this.redemptionDetails,
        this.status});

  CreateRewardPayload.fromJson(Map<String, dynamic> json) {
    businessId = json['business_id'];
    standardLoyaltyProgramTypesId = json['standard_loyalty_program_types_id'];
    if (json['media_urls'] != null) {
      mediaUrls = []; //MediaDetails>();
      json['media_urls'].forEach((v) {
        mediaUrls!.add(MediaDetails.fromJson(v));
      });
    }
    title = json['title'];
    subtitle = json['subtitle'];
    recipientType = json['recipient_type'].cast<String>();
    recipientDetails = json['recipient_details'].cast<String>();
    startDatetime = json['start_datetime'];
    endDatetime = json['end_datetime'];
    incentiveCoins = json['incentive_coins'];
    incentiveCash = json['incentive_cash'];
    incentiveCurrency = json['incentive_currency'];
    redemptionDetails = json['redemption_details'] != null
        ? new RedemptionDetails.fromJson(json['redemption_details'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_id'] = this.businessId;
    data['standard_loyalty_program_types_id'] =
        this.standardLoyaltyProgramTypesId;
    if (this.mediaUrls != null) {
      data['media_urls'] = this.mediaUrls!.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['recipient_type'] = this.recipientType;
    data['recipient_details'] = this.recipientDetails;
    data['start_datetime'] = this.startDatetime;
    data['end_datetime'] = this.endDatetime;
    data['incentive_coins'] = this.incentiveCoins;
    data['incentive_cash'] = this.incentiveCash;
    data['incentive_currency'] = this.incentiveCurrency;
    if (this.redemptionDetails != null) {
      data['redemption_details'] = this.redemptionDetails!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class RedemptionDetails {
  int? couponDiscountPercentage;
  int? couponCoinsForDiscountPercentage;
  int? giftCash;
  int? giftCoinsForCash;

  RedemptionDetails(
      {this.couponDiscountPercentage,
        this.couponCoinsForDiscountPercentage,
        this.giftCash,
        this.giftCoinsForCash});

  RedemptionDetails.fromJson(Map<String, dynamic> json) {
    couponDiscountPercentage = json['coupon_discount_percentage'];
    couponCoinsForDiscountPercentage =
    json['coupon_coins for_discount_percentage'];
    giftCash = json['gift_cash'];
    giftCoinsForCash = json['gift_coins_for_cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_discount_percentage'] = this.couponDiscountPercentage;
    data['coupon_coins for_discount_percentage'] =
        this.couponCoinsForDiscountPercentage;
    data['gift_cash'] = this.giftCash;
    data['gift_coins_for_cash'] = this.giftCoinsForCash;
    return data;
  }
}
