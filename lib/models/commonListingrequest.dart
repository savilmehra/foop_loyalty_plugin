

class CommonListRequestPayload {
  String? searchVal;
  List<String>? personType;
  int? pageNumber;
  int? pageSize;
  String? requestedByType;
  String? listType;
  String? personId;
  int? businessId;

  CommonListRequestPayload(
      {this.searchVal,
      this.personType,
      this.pageNumber,
      this.pageSize,
      this.requestedByType,
      this.listType,
      this.personId,
      this.businessId});

  CommonListRequestPayload.fromJson(Map<String, dynamic> json) {
    searchVal = json['searchVal'];
    personType = json['person_type'].cast<String>();
    pageNumber = json['page_number'];
    pageSize = json['page_size'];
    requestedByType = json['requested_by_type'];
    listType = json['list_type'];
    personId = json['person_id'];
    businessId = json['business_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchVal'] = this.searchVal;
    data['person_type'] = this.personType;
    data['page_number'] = this.pageNumber;
    data['page_size'] = this.pageSize;
    data['requested_by_type'] = this.requestedByType;
    data['list_type'] = this.listType;
    data['person_id'] = this.personId;
    data['business_id'] = this.businessId;
    return data;
  }
}

class CommonListResponse {
  String? statusCode;
  String? message;
  int? total;
  List<CommonListResponseItem>? rows;

  CommonListResponse({this.statusCode, this.message, this.rows, this.total});

  CommonListResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
    total = json['total'];
    if (json['rows'] != null) {
      rows = []; //CommonListResponseItem>();
      json['rows'].forEach((v) {
        rows!.add(new CommonListResponseItem.fromJson(v));
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

class CommonListResponseItem {
  int? id;
  String? avatar;
  String? title;
  String? businessName;
  String? department;
  SubTitle1? subTitle1;
  SubTitle1? subTitle2;
  String? subTitle;
  List<String>? action;
  String? dateTime;
  bool? isFollower;
  bool? isFollowing;
  bool? isSelected = false;
  bool? isLoading = false;
  bool? foop_permission = false;
  List<String> ? role;
  bool? foopPermission;
  String? employeeId;
  String? assignmentStatus;
  int? companyId;

  CommonListResponseItem(
      {
      this.id,
        this.role,
        this.companyId,

this.department,
      this.avatar,
      this.title,
      this.foopPermission,
      this.employeeId,
      this.assignmentStatus,
      this.subTitle1,
      this.subTitle2,
      this.isLoading,
      this.action,
      this.foop_permission,
      this.subTitle,
      this.businessName,
      this.isSelected,
      this.dateTime,
      this.isFollower,

      this.isFollowing});

  CommonListResponseItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    department=json['department'];
    if (json['person_type_name'] != null)
    role=json['person_type_name'].cast<String>();
    companyId=json['company_id'];


    foopPermission = json['foop_permission'];
    employeeId = json['employee_id'];
    assignmentStatus = json['assignment_status'];
    foop_permission = json['foop_permission'];
    businessName = json['business_name'];
    avatar = json['avatar'];
    title = json['title'];
    subTitle = json['sub_title'];
    subTitle1 = json['sub_title_1'] != null
        ? new SubTitle1.fromJson(json['sub_title_1'])
        : null;
    subTitle2 = json['sub_title_2'] != null
        ? new SubTitle1.fromJson(json['sub_title_2'])
        : null;
    action = json['action'] != null ? json['action'].cast<String>() : null;
    dateTime = json['date_time'];
    isFollower = json['is_follower'];
    isFollowing = json['is_following'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_title'] = this.subTitle;
    data['avatar'] = this.avatar;
    data['department']=this.department;
    data['company_id']=this.companyId;
    data['person_type_name']=this.role;

    data['foop_permission'] = this.foopPermission;
    data['employee_id'] = this.employeeId;
    data['assignment_status'] = this.assignmentStatus;
    data['foop_permission'] = this.foop_permission;
    data['business_name'] = this.businessName;
    data['title'] = this.title;
    if (this.subTitle1 != null) {
      data['sub_title_1'] = this.subTitle1!.toJson();
    }
    if (this.subTitle2 != null) {
      data['sub_title_2'] = this.subTitle2!.toJson();
    }
    data['action'] = this.action;
    data['date_time'] = this.dateTime;
    data['is_following'] = this.isFollowing;
    data['is_follower'] = this.isFollower;

    return data;
  }
}

class SubTitle1 {
  String? designation;
  String? location;
  String? status;
  String? networkStatus;
  String? lastMessageLine;
  String? contact;

  SubTitle1(
      {this.designation,
      this.location,
      this.status,
      this.networkStatus,
      this.lastMessageLine,
      this.contact});

  SubTitle1.fromJson(Map<String, dynamic> json) {
    designation = json['designation'];
    location = json['location'];
    status = json['status'];
    networkStatus = json['network_status'];
    lastMessageLine = json['last_message_line'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['designation'] = this.designation;
    data['location'] = this.location;
    data['status'] = this.status;
    data['network_status'] = this.networkStatus;
    data['last_message_line'] = this.lastMessageLine;
    data['contact'] = this.contact;
    return data;
  }
}
