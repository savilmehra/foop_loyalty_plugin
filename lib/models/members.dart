class MemberAddPayload {
  int? roomId;
  int? roomBusinessId;
  bool? isAddAllMembers;
  List<MembersItem>? members;
  List<String?>? recipientType;
  List<dynamic>? recipientDetails;
  MemberAddPayload(
      {this.roomId, this.roomBusinessId, this.isAddAllMembers, this.members,     this.recipientType,
        this.recipientDetails,});

  MemberAddPayload.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    recipientType = json['recipient_type'].cast<String>();

    recipientDetails = json['recipient_type_details'];
    roomBusinessId = json['room_business_id'];
    isAddAllMembers = json['is_add_all_members'];
    if (json['members'] != null) {
      members = []; //MembersItem>();
      json['members'].forEach((v) {
        members!.add(new MembersItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['recipient_type'] = this.recipientType;
    data['recipient_type_details'] = this.recipientDetails;
    data['room_business_id'] = this.roomBusinessId;
    data['is_add_all_members'] = this.isAddAllMembers;
    if (this.members != null) {
      data['members'] = this.members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MembersItem {
  int? memberId;
  String? memberType;
  String? addMethod;
  String? profileImage;
  String? memberName;
  String? roleType;

  MembersItem(
      {this.memberId,
        this.memberType,
        this.addMethod,
        this.profileImage,
        this.memberName,
        this.roleType});

  MembersItem.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    memberType = json['member_type'];
    addMethod = json['add_method'];
    roleType = json['role_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_id'] = this.memberId;
    data['member_type'] = this.memberType;
    data['add_method'] = this.addMethod;
    data['role_type'] = this.roleType;
    return data;
  }
}
