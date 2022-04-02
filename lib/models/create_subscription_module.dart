class CreateSubscriptionPayload {
  String? subscriptionCode;
  int? purchasedForDays;
  int? businessId;
  int? personId;
  String? billId;
  String? appType;
  List<int>? appliedToPersonIds;

  CreateSubscriptionPayload(
      {this.subscriptionCode,
      this.purchasedForDays,
      this.businessId,
      this.personId,
      this.billId,
      this.appType,
      this.appliedToPersonIds});

  CreateSubscriptionPayload.fromJson(Map<String, dynamic> json) {
    subscriptionCode = json['subscription_code'];
    purchasedForDays = json['purchased_for_days'];
    businessId = json['business_id'];
    personId = json['person_id'];
    billId = json['bill_id'];
    appType = json['app_type'];
    appliedToPersonIds = json['applied_to_person_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subscription_code'] = this.subscriptionCode;
    data['purchased_for_days'] = this.purchasedForDays;
    data['business_id'] = this.businessId;
    data['person_id'] = this.personId;
    data['bill_id'] = this.billId;
    data['app_type'] = this.appType;
    data['applied_to_person_ids'] = this.appliedToPersonIds;
    return data;
  }
}
