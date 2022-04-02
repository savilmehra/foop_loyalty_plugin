class SubscriptionViewResponse {
  String? statusCode;
  String? message;
  Rows? rows;
  int? total;

  SubscriptionViewResponse(
      {this.statusCode, this.message, this.rows, this.total});

  SubscriptionViewResponse.fromJson(Map<String, dynamic> json) {
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
  AccountingDetails? accountingDetails;
  String? partnerDetails;
  List<String>? subscriptionsList;
  String? lastSubscriptionDetails;
  double? outstandingAmount;
  int? subscriptionDemoForDays;

  Rows(
      {this.accountingDetails,
        this.partnerDetails,
        this.subscriptionsList,
        this.lastSubscriptionDetails,
        this.outstandingAmount,
        this.subscriptionDemoForDays});

  Rows.fromJson(Map<String, dynamic> json) {
    accountingDetails = json['accounting_details'] != null
        ? new AccountingDetails.fromJson(json['accounting_details'])
        : null;
    partnerDetails = json['partner_details'];
    subscriptionsList = json['subscriptions_list'].cast<String>();
    lastSubscriptionDetails = json['last_subscription_details'];
    outstandingAmount = json['outstanding_amount'];
    subscriptionDemoForDays = json['subscription_demo_for_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.accountingDetails != null) {
      data['accounting_details'] = this.accountingDetails!.toJson();
    }
    data['partner_details'] = this.partnerDetails;
    data['subscriptions_list'] = this.subscriptionsList;
    data['last_subscription_details'] = this.lastSubscriptionDetails;
    data['outstanding_amount'] = this.outstandingAmount;
    data['subscription_demo_for_days'] = this.subscriptionDemoForDays;
    return data;
  }
}

class AccountingDetails {
  String? accountNumber;
  String? billingAddress;
  String? gst;

  AccountingDetails({this.accountNumber, this.billingAddress, this.gst});

  AccountingDetails.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    billingAddress = json['billing_address'];
    gst = json['gst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_number'] = this.accountNumber;
    data['billing_address'] = this.billingAddress;
    data['gst'] = this.gst;
    return data;
  }
}
