class CountryStatePayload {
  int? businessId;
  String? searchVal;
  int? pageNumber;
  int? pageSize;
  String? entityType;
  List<String?>? personTypes;
  List<String?>? countryCode;
  List<String?>? stateCode;
  List<String?>? city;

  CountryStatePayload(
      {this.businessId,
      this.searchVal,
      this.pageNumber,
      this.pageSize,
      this.entityType,
      this.personTypes,
      this.countryCode,
      this.stateCode,
      this.city});

  CountryStatePayload.fromJson(Map<String, dynamic> json) {
    businessId = json['business_id'];
    searchVal = json['search_val'];
    pageNumber = json['page_number'];
    pageSize = json['page_size'];
    entityType = json['entity_type'];
    personTypes = json['person_types'].cast<String>();
    countryCode = json['country_code'].cast<String>();
    stateCode = json['state_code'].cast<String>();
    city = json['city'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_id'] = this.businessId;
    data['search_val'] = this.searchVal;
    data['page_number'] = this.pageNumber;
    data['page_size'] = this.pageSize;
    data['entity_type'] = this.entityType;
    data['person_types'] = this.personTypes;
    data['country_code'] = this.countryCode;
    data['state_code'] = this.stateCode;
    data['city'] = this.city;
    return data;
  }
}
