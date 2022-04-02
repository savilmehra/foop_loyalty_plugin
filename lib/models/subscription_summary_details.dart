class SubscriptionSummaryResponse {
  String? statusCode;
  String? message;
  Rows? rows;
  int? total;

  SubscriptionSummaryResponse(
      {this.statusCode, this.message, this.rows, this.total});

  SubscriptionSummaryResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    rows = json['rows'] != null ? new Rows.fromJson(json['rows']) : null;
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (rows != null) {
      data['rows'] = rows!.toJson();
    }
    data['total'] = total;
    return data;
  }
}

class Rows {
  AccountingDetails? accountingDetails;
  PartnerDetails? partnerDetails;
  List<SubscriptionsList>? subscriptionsList;

  Rows({this.accountingDetails, this.partnerDetails, this.subscriptionsList});

  Rows.fromJson(Map<String, dynamic> json) {
    accountingDetails = json['accounting_details'] != null
        ? new AccountingDetails.fromJson(json['accounting_details'])
        : null;
    partnerDetails = json['partner_details'] != null
        ? new PartnerDetails.fromJson(json['partner_details'])
        : null;
    if (json['subscriptions_list'] != null) {
      subscriptionsList = [];
      json['subscriptions_list'].forEach((v) {
        subscriptionsList!.add(new SubscriptionsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (accountingDetails != null) {
      data['accounting_details'] = this.accountingDetails!.toJson();
    }
    if (partnerDetails != null) {
      data['partner_details'] = this.partnerDetails!.toJson();
    }
    if (subscriptionsList != null) {
      data['subscriptions_list'] =
          this.subscriptionsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountingDetails {
  String? accountingNumber;
  String? billingAddress;
  String? gst;
  double? outstandingAmount;

  AccountingDetails(
      {this.accountingNumber,
      this.billingAddress,
      this.gst,
      this.outstandingAmount});

  AccountingDetails.fromJson(Map<String, dynamic> json) {
    accountingNumber = json['accounting_number'];
    billingAddress = json['billing_address'];
    gst = json['gst'];
    outstandingAmount = json['outstanding_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accounting_number'] = this.accountingNumber;
    data['billing_address'] = this.billingAddress;
    data['gst'] = this.gst;
    data['outstanding_amount'] = this.outstandingAmount;
    return data;
  }
}

class PartnerDetails {
  String? id;
  String? name;

  PartnerDetails({this.id, this.name});

  PartnerDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class SubscriptionsList {
  int? id;
  int? subscriptionActiveFromDate;
  int? subscriptionValidTillDate;
  String? domain;
  String? paymentPlan;
  double? paymentDue;
  SubscriptionType? subscriptionType;
  String? subscriptionStatus;
  int? totalLicences;
  int? usedLicences;

  SubscriptionsList(
      {this.id,
      this.subscriptionActiveFromDate,
      this.subscriptionValidTillDate,
      this.domain,
      this.paymentPlan,
      this.paymentDue,
      this.subscriptionType,
      this.subscriptionStatus,
      this.totalLicences,
      this.usedLicences});

  SubscriptionsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionActiveFromDate = json['subscription_active_from_date'];
    subscriptionValidTillDate = json['subscription_valid_till_date'];
    domain = json['domain'];
    paymentPlan = json['payment_plan'];
    paymentDue = json['payment_due'];
    subscriptionType = json['subscription_type'] != null
        ? new SubscriptionType.fromJson(json['subscription_type'])
        : null;
    subscriptionStatus = json['subscription_status'];
    totalLicences = json['total_licences'];
    usedLicences = json['used_licences'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subscription_active_from_date'] = this.subscriptionActiveFromDate;
    data['subscription_valid_till_date'] = this.subscriptionValidTillDate;
    data['domain'] = this.domain;
    data['payment_plan'] = this.paymentPlan;
    data['payment_due'] = this.paymentDue;
    if (this.subscriptionType != null) {
      data['subscription_type'] = this.subscriptionType!.toJson();
    }
    data['subscription_status'] = this.subscriptionStatus;
    data['total_licences'] = this.totalLicences;
    data['used_licences'] = this.usedLicences;
    return data;
  }
}

class SubscriptionType {
  int? id;
  String? subscriptionCode;
  String? subscriptionDescription;
  String? subscriptionWebDescription;
  String? subscriptionMobileDescription;
  String? subscriptionImage;
  bool? subscriptionIsDefault;
  bool? subscriptionIsDemo;

  SubscriptionType(
      {this.id,
      this.subscriptionCode,
      this.subscriptionDescription,
      this.subscriptionWebDescription,
      this.subscriptionMobileDescription,
      this.subscriptionImage,
      this.subscriptionIsDefault,
      this.subscriptionIsDemo});

  SubscriptionType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subscriptionCode = json['subscription_code'];
    subscriptionDescription = json['subscription_description'];
    subscriptionWebDescription = json['subscription_web_description'];
    subscriptionMobileDescription = json['subscription_mobile_description'];
    subscriptionImage = json['subscription_image'];
    subscriptionIsDefault = json['subscription_is_default'];
    subscriptionIsDemo = json['subscription_is_demo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subscription_code'] = this.subscriptionCode;
    data['subscription_description'] = this.subscriptionDescription;
    data['subscription_web_description'] = this.subscriptionWebDescription;
    data['subscription_mobile_description'] =
        this.subscriptionMobileDescription;
    data['subscription_image'] = this.subscriptionImage;
    data['subscription_is_default'] = this.subscriptionIsDefault;
    data['subscription_is_demo'] = this.subscriptionIsDemo;
    return data;
  }
}
