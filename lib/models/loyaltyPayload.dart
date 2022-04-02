class LoyaltyCreatePayload {
  String? loyaltyTypeName;
  int? loyaltyTypeId;
  String? loyaltyTypeDescription;
  String? imageUrl;
  int? businessId;

  LoyaltyCreatePayload(
      {this.loyaltyTypeName,
      this.loyaltyTypeId,
      this.loyaltyTypeDescription,
      this.imageUrl,
      this.businessId});

  LoyaltyCreatePayload.fromJson(Map<String, dynamic> json) {
    loyaltyTypeName = json['loyalty_type_name'];
    loyaltyTypeId = json['loyalty_type_id'];
    loyaltyTypeDescription = json['loyalty_type_description'];
    imageUrl = json['image_url'];
    businessId = json['entity_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loyalty_type_name'] = this.loyaltyTypeName;
    data['loyalty_type_id'] = this.loyaltyTypeId;
    data['loyalty_type_description'] = this.loyaltyTypeDescription;
    data['image_url'] = this.imageUrl;
    data['entity_id'] = this.businessId;
    return data;
  }
}

class LoyaltyUpdateRequest {
  int? businessId;
  List<int>? partnerBusinessIds;
  String? loyaltyTypeCode;

  LoyaltyUpdateRequest(
      {this.businessId, this.partnerBusinessIds, this.loyaltyTypeCode});

  LoyaltyUpdateRequest.fromJson(Map<String, dynamic> json) {
    businessId = json['business_id'];
    partnerBusinessIds = json['partner_business_ids'].cast<int>();
    loyaltyTypeCode = json['loyalty_type_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_id'] = this.businessId;
    data['partner_business_ids'] = this.partnerBusinessIds;
    data['loyalty_type_code'] = this.loyaltyTypeCode;
    return data;
  }
}
