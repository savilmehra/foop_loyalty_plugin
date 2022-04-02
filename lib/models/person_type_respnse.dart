class PersonListResponse {
  String? statusCode;
  String? message;
  List<Rows>? rows;
  int? total;

  PersonListResponse({this.statusCode, this.message, this.rows, this.total});

  PersonListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['rows'] != null) {
      rows = [];
      json['rows'].forEach((v) {
        rows!.add(new Rows.fromJson(v));
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

class Rows {
  int? id;
  bool  isPartnerAssigned=false;
  String? type;
  String? title;
  String? subtitle;
  String? avatar;
  String? mobile;
  String? email;
  String? personAvatar;
  int? contactId;
  int? companyId;
  List<String>? role;
  String? partnerId;
  List<String>? personType;
  String? latitude;
  String? longitude;
  String? business_mobile;
  bool? selected=false;
  LevelDetails? levelDetails;
  Rows(
      {this.id,
        this.type,
        this.title,
        this.isPartnerAssigned=false,
        this.personAvatar,
        this.subtitle,
        this.avatar,
        this.contactId,
        this.companyId,
        this.partnerId,
        this.role,
        this.email,
        this.mobile,
        this.latitude,
        this.longitude,
        this.selected=false,
        this.business_mobile,
        this.personType,
        this.levelDetails
      });

  Rows.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isPartnerAssigned=json['is_partner_assigned']??false;
    type = json['type'];
    mobile = json['mobile'];
    email = json['email'];
    title = json['title'];
    personAvatar = json['person_avatar'];
    role = json['person_type_name'].cast<String>();
    subtitle = json['subtitle'];
    avatar = json['avatar'];
    contactId = json['contact_id'];
    companyId = json['company_id'];
    partnerId = json['partner_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    business_mobile = json['business_mobile'];
    personType = json['person_type'].cast<String>();
    levelDetails = json['level_details'] != null
        ? new LevelDetails.fromJson(json['level_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['title'] = this.title;
    data['is_partner_assigned']=this.isPartnerAssigned;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['person_avatar'] = this.personAvatar;
    data['subtitle'] = this.subtitle;
    data['avatar'] = this.avatar;
    data['person_type_name'] = this.role;
    data['contact_id'] = this.contactId;
    data['company_id'] = this.companyId;
    data['partner_id'] = this.partnerId;
    data['person_type'] = this.personType;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['business_mobile'] = this.business_mobile;
    if (this.levelDetails != null) {
      data['level_details'] = this.levelDetails!.toJson();
    }
    return data;
  }
}

class LevelDetails {
  String? levelType;
  String? parentLevelType;
  String ? bottomLevel;

  LevelDetails({this.levelType, this.parentLevelType});

  LevelDetails.fromJson(Map<String, dynamic> json) {
    levelType = json['level_type'];
    parentLevelType = json['parent_level_type'];

    bottomLevel = json['bottom_level_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level_type'] = this.levelType;
    data['bottom_level_type'] = this.bottomLevel;
    data['parent_level_type'] = this.parentLevelType;
    return data;
  }
}