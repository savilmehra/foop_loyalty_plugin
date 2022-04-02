class SubscriptionListResponse {
  String? statusCode;
  String? message;
  List<SubscriptionItem>? rows;
  int? total;

  SubscriptionListResponse(
      {this.statusCode, this.message, this.rows, this.total});

  SubscriptionListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['rows'] != null) {
      rows = <SubscriptionItem>[];
      json['rows'].forEach((v) {
        rows!.add(new SubscriptionItem.fromJson(v));
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

class SubscriptionItem {
  String? subscriptionCode;
  String? subscriptionDescription;
  String? subscriptionWebDescription;
  String? subscriptionMobileDescription;
  Null? subscriptionImage;
  bool? subscriptionIsDefault;
  bool? subscriptionIsDemo;
  List<SubscriptionPricesList>? subscriptionPricesList;
  List<SubscriptionFeaturesList>? subscriptionFeaturesList;
  int? subscriptionDemoForDays;
  Null? subscriptionRemainingDays;
  bool? isCurrent;
  int? used;

  SubscriptionItem(
      {this.subscriptionCode,
        this.subscriptionDescription,
        this.subscriptionWebDescription,
        this.subscriptionMobileDescription,
        this.subscriptionImage,
        this.subscriptionIsDefault,
        this.subscriptionIsDemo,
        this.subscriptionPricesList,
        this.subscriptionFeaturesList,
        this.subscriptionDemoForDays,
        this.subscriptionRemainingDays,
        this.isCurrent,
        this.used});

  SubscriptionItem.fromJson(Map<String, dynamic> json) {
    subscriptionCode = json['subscription_code'];
    subscriptionDescription = json['subscription_description'];
    subscriptionWebDescription = json['subscription_web_description'];
    subscriptionMobileDescription = json['subscription_mobile_description'];
    subscriptionImage = json['subscription_image'];
    subscriptionIsDefault = json['subscription_is_default'];
    subscriptionIsDemo = json['subscription_is_demo'];
    if (json['subscription_prices_list'] != null) {
      subscriptionPricesList = <SubscriptionPricesList>[];
      json['subscription_prices_list'].forEach((v) {
        subscriptionPricesList!.add(new SubscriptionPricesList.fromJson(v));
      });
    }
    if (json['subscription_features_list'] != null) {
      subscriptionFeaturesList = <SubscriptionFeaturesList>[];
      json['subscription_features_list'].forEach((v) {
        subscriptionFeaturesList!.add(new SubscriptionFeaturesList.fromJson(v));
      });
    }
    subscriptionDemoForDays = json['subscription_demo_for_days'];
    subscriptionRemainingDays = json['subscription_remaining_days'];
    isCurrent = json['is_current'];
    used = json['used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscription_code'] = this.subscriptionCode;
    data['subscription_description'] = this.subscriptionDescription;
    data['subscription_web_description'] = this.subscriptionWebDescription;
    data['subscription_mobile_description'] =
        this.subscriptionMobileDescription;
    data['subscription_image'] = this.subscriptionImage;
    data['subscription_is_default'] = this.subscriptionIsDefault;
    data['subscription_is_demo'] = this.subscriptionIsDemo;
    if (this.subscriptionPricesList != null) {
      data['subscription_prices_list'] =
          this.subscriptionPricesList!.map((v) => v.toJson()).toList();
    }
    if (this.subscriptionFeaturesList != null) {
      data['subscription_features_list'] =
          this.subscriptionFeaturesList!.map((v) => v.toJson()).toList();
    }
    data['subscription_demo_for_days'] = this.subscriptionDemoForDays;
    data['subscription_remaining_days'] = this.subscriptionRemainingDays;
    data['is_current'] = this.isCurrent;
    data['used'] = this.used;
    return data;
  }
}

class SubscriptionPricesList {
  String? currencyTypeCode;
  String? currencyTypeDescription;
  String? pricePerMonth;
  String? pricePerYear;
  String? activityName;
  String? activityCode;
  int? allocated;
  String? balanceType;
  int? usedCount;
  bool? isFree;

  SubscriptionPricesList(
      {this.currencyTypeCode,
        this.currencyTypeDescription,
        this.pricePerMonth,
        this.pricePerYear,
        this.activityName,
        this.activityCode,
        this.allocated,
        this.balanceType,
        this.usedCount,
        this.isFree});

  SubscriptionPricesList.fromJson(Map<String, dynamic> json) {
    currencyTypeCode = json['currency_type_code'];
    currencyTypeDescription = json['currency_type_description'];
    pricePerMonth = json['price_per_month'];
    pricePerYear = json['price_per_year'];
    activityName = json['activity_name'];
    activityCode = json['activity_code'];
    allocated = json['allocated'];
    balanceType = json['balance_type'];
    usedCount = json['used_count'];
    isFree = json['is_free'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_type_code'] = this.currencyTypeCode;
    data['currency_type_description'] = this.currencyTypeDescription;
    data['price_per_month'] = this.pricePerMonth;
    data['price_per_year'] = this.pricePerYear;
    data['activity_name'] = this.activityName;
    data['activity_code'] = this.activityCode;
    data['allocated'] = this.allocated;
    data['balance_type'] = this.balanceType;
    data['used_count'] = this.usedCount;
    data['is_free'] = this.isFree;
    return data;
  }
}

class SubscriptionFeaturesList {
  String? featureCode;
  String? featureDescription;
  int? allocated;
  String? balanceType;
  bool? isAvailable;

  SubscriptionFeaturesList(
      {this.featureCode,
        this.featureDescription,
        this.allocated,
        this.balanceType,
        this.isAvailable});

  SubscriptionFeaturesList.fromJson(Map<String, dynamic> json) {
    featureCode = json['feature_code'];
    featureDescription = json['feature_description'];
    allocated = json['allocated'];
    balanceType = json['balance_type'];
    isAvailable = json['is_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feature_code'] = this.featureCode;
    data['feature_description'] = this.featureDescription;
    data['allocated'] = this.allocated;
    data['balance_type'] = this.balanceType;
    data['is_available'] = this.isAvailable;
    return data;
  }
}
