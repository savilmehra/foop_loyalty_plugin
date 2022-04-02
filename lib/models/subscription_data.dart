class SubscriptionData {
  String? statusCode;
  String? message;
  List<SubscriptionItem>? rows;
  int? total;

  SubscriptionData({this.statusCode, this.message, this.rows, this.total});

  SubscriptionData.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['rows'] != null) {
      rows = [];
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
  String? subscriptionImage;
  int? used;
  bool? subscriptionIsDefault;
  bool? subscriptionIsDemo;
  List<SubscriptionPricesList>? subscriptionPricesList;
  List<SubscriptionFeaturesList>? subscriptionFeaturesList;

  SubscriptionItem(
      {this.subscriptionCode,
      this.subscriptionDescription,
      this.subscriptionWebDescription,
      this.subscriptionMobileDescription,
      this.subscriptionImage,
      this.subscriptionIsDefault,
      this.subscriptionIsDemo,
      this.subscriptionPricesList,
      this.used,
      this.subscriptionFeaturesList});

  SubscriptionItem.fromJson(Map<String, dynamic> json) {
    subscriptionCode = json['subscription_code'];
    used = json['used'];
    subscriptionDescription = json['subscription_description'];
    subscriptionWebDescription = json['subscription_web_description'];
    subscriptionMobileDescription = json['subscription_mobile_description'];
    subscriptionImage = json['subscription_image'];
    subscriptionIsDefault = json['subscription_is_default'];
    subscriptionIsDemo = json['subscription_is_demo'];
    if (json['subscription_prices_list'] != null) {
      subscriptionPricesList = [];
      json['subscription_prices_list'].forEach((v) {
        subscriptionPricesList!.add(new SubscriptionPricesList.fromJson(v));
      });
    }
    if (json['subscription_features_list'] != null) {
      subscriptionFeaturesList = [];
      json['subscription_features_list'].forEach((v) {
        subscriptionFeaturesList!.add(new SubscriptionFeaturesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscription_code'] = this.subscriptionCode;

    data['used'] = this.used;
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
    return data;
  }
}

class SubscriptionPricesList {
  String? currencyTypeCode;
  String? currencyTypeDescription;
  String? pricePerMonth;
  String? pricePerYear;

  SubscriptionPricesList(
      {this.currencyTypeCode,
      this.currencyTypeDescription,
      this.pricePerMonth,
      this.pricePerYear});

  SubscriptionPricesList.fromJson(Map<String, dynamic> json) {
    currencyTypeCode = json['currency_type_code'];
    currencyTypeDescription = json['currency_type_description'];
    pricePerMonth = json['price_per_month'];
    pricePerYear = json['price_per_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_type_code'] = this.currencyTypeCode;
    data['currency_type_description'] = this.currencyTypeDescription;
    data['price_per_month'] = this.pricePerMonth;
    data['price_per_year'] = this.pricePerYear;
    return data;
  }
}

class SubscriptionFeaturesList {
  String? featureCode;
  String? featureDescription;

  SubscriptionFeaturesList({this.featureCode, this.featureDescription});

  SubscriptionFeaturesList.fromJson(Map<String, dynamic> json) {
    featureCode = json['feature_code'];
    featureDescription = json['feature_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feature_code'] = this.featureCode;
    data['feature_description'] = this.featureDescription;
    return data;
  }
}
