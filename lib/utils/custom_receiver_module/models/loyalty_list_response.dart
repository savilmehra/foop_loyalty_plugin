class LoyaltyListResponse {
  String? statusCode;
  String? message;
  List<LoyaltyItem>? rows;
  int? total;

  LoyaltyListResponse({this.statusCode, this.message, this.rows, this.total});

  LoyaltyListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['rows'] != null) {
      rows = [];
      json['rows'].forEach((v) {
        rows!.add(new LoyaltyItem.fromJson(v));
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

class LoyaltyItem {
  String? loyaltyTypeName;
  String? loyaltyTypeCode;
  String? loyaltyTypeDescription;
  String? imageUrl;
  int? loyaltyTypeId;
  bool? isSelected = false;

  LoyaltyItem(
      {this.loyaltyTypeName,
      this.loyaltyTypeCode,
      this.loyaltyTypeDescription,
      this.imageUrl,
      this.isSelected,
      this.loyaltyTypeId});

  LoyaltyItem.fromJson(Map<String, dynamic> json) {
    loyaltyTypeName = json['loyalty_type_name'];
    loyaltyTypeCode = json['loyalty_type_code'];
    loyaltyTypeDescription = json['loyalty_type_description'];
    imageUrl = json['image_url'];
    loyaltyTypeId = json['loyalty_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['loyalty_type_name'] = this.loyaltyTypeName;
    data['loyalty_type_code'] = this.loyaltyTypeCode;
    data['loyalty_type_description'] = this.loyaltyTypeDescription;
    data['image_url'] = this.imageUrl;
    data['loyalty_type_id'] = this.loyaltyTypeId;
    return data;
  }
}
