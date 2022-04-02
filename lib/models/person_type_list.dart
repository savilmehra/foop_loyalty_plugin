class PersonTypeList {
  String? statusCode;
  String? message;
  List<PersonItem>? rows;
  int? total;
  PersonTypeList({this.statusCode, this.message, this.rows, this.total});

  PersonTypeList.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    total = json['total'];
    if (json['rows'] != null) {
      rows = []; //PersonItem>();
      json['rows'].forEach((v) {
        rows!.add(new PersonItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['total'] = this.total;
    if (this.rows != null) {
      data['rows'] = this.rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PersonItem {
  String? personTypeName;
  String? personTypeCode;
  String? personTypeDescription;
  String? imageUrl;
  int? personTypeId;
  String? level_type;
  bool? isSelected=false;

  PersonItem(
      {this.personTypeName,
      this.personTypeCode,
      this.personTypeDescription,
      this.imageUrl,
        this.level_type,
      this.isSelected,
      this.personTypeId});

  PersonItem.fromJson(Map<String, dynamic> json) {
    personTypeName = json['person_type_name'];
    personTypeCode = json['person_type_code'];
    level_type=json["level_type"];
    personTypeDescription = json['person_type_description'];
    imageUrl = json['image_url'];
    personTypeId = json['person_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person_type_name'] = this.personTypeName;
    data['person_type_code'] = this.personTypeCode;
    data['level_type']=this.level_type;
    data['person_type_description'] = this.personTypeDescription;
    data['image_url'] = this.imageUrl;
    data['person_type_id'] = this.personTypeId;
    return data;
  }
}
