class UserModel {
  String? id;
  String? name;
  String? email;
  String? profileImage;
  String? phoneNumber;
  String? about;
  String? createdAt;
  String? lastOnlineStatus;
  String? status;
  String? role;
  String? fcmToken;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.profileImage,
      this.phoneNumber,
      this.about,
      this.createdAt,
      this.lastOnlineStatus,
      this.status,
      this.role,
      this.fcmToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    fcmToken = json["fcmToken"];
    email = json["email"];
    profileImage = json["profileImage"];
    phoneNumber = json["phoneNumber"];
    about = json["About"];
    createdAt = json["CreatedAt"];
    lastOnlineStatus = json["LastOnlineStatus"];
    status = json["Status"];
    role = json["role"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["profileImage"] = profileImage;
    _data["phoneNumber"] = phoneNumber;
    _data["About"] = about;
    _data["CreatedAt"] = createdAt;
    _data["LastOnlineStatus"] = lastOnlineStatus;
    _data["Status"] = status;
    _data["role"] = role;
    _data["fcmToken"] = fcmToken;
    return _data;
  }
}
