class CreateRewardResponse {
  String? statusCode;
  String? message;
  Rows? rows;
  int? total;

  CreateRewardResponse({this.statusCode, this.message, this.rows, this.total});

  CreateRewardResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    rows = json['rows'] != null ? new Rows.fromJson(json['rows']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.rows != null) {
      data['rows'] = this.rows!.toJson();
    }
    data['total'] = this.total;
    return data;
  }
}

class Rows {
  int? businessId;
  int? standardLoyaltyProgramTypesId;

  String? title;
  String? subtitle;
  List<String>? recipientType;
  List<RecipientDetails>? recipientDetails;
  Null? startDatetime;
  Null? endDatetime;
  int? incentiveCoins;
  int? incentiveCash;
  String? incentiveCurrency;
  RedemptionDetails? redemptionDetails;
  String? status;
  int? id;

  Rows(
      {this.businessId,
        this.standardLoyaltyProgramTypesId,

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
        this.status,
        this.id});

  Rows.fromJson(Map<String, dynamic> json) {
    businessId = json['business_id'];
    standardLoyaltyProgramTypesId = json['standard_loyalty_program_types_id'];

    title = json['title'];
    subtitle = json['subtitle'];
    recipientType = json['recipient_type'].cast<String>();
    if (json['recipient_details'] != null) {
      recipientDetails = <RecipientDetails>[];
      json['recipient_details'].forEach((v) {
        recipientDetails!.add(new RecipientDetails.fromJson(v));
      });
    }
    startDatetime = json['start_datetime'];
    endDatetime = json['end_datetime'];
    incentiveCoins = json['incentive_coins'];
    incentiveCash = json['incentive_cash'];
    incentiveCurrency = json['incentive_currency'];
    redemptionDetails = json['redemption_details'] != null
        ? new RedemptionDetails.fromJson(json['redemption_details'])
        : null;
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_id'] = this.businessId;
    data['standard_loyalty_program_types_id'] =
        this.standardLoyaltyProgramTypesId;

    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['recipient_type'] = this.recipientType;
    if (this.recipientDetails != null) {
      data['recipient_details'] =
          this.recipientDetails!.map((v) => v.toJson()).toList();
    }
    data['start_datetime'] = this.startDatetime;
    data['end_datetime'] = this.endDatetime;
    data['incentive_coins'] = this.incentiveCoins;
    data['incentive_cash'] = this.incentiveCash;
    data['incentive_currency'] = this.incentiveCurrency;
    if (this.redemptionDetails != null) {
      data['redemption_details'] = this.redemptionDetails!.toJson();
    }
    data['status'] = this.status;
    data['id'] = this.id;
    return data;
  }
}

class RecipientDetails {
  String? type;
  int? id;

  RecipientDetails({this.type, this.id});

  RecipientDetails.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
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
