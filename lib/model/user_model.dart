class ChatUser {
  ChatUser({
    this.connection,
    this.chatId,
    this.lastTime,
    this.total_unread,
  });

  String? connection;
  String? chatId;
  String? lastTime;
  int? total_unread;

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        connection: json["connection"],
        chatId: json["chat_id"],
        lastTime: json["lastTime"],
        total_unread: json["total_unread"],
      );

  Map<String, dynamic> toJson() => {
        "connection": connection,
        "chat_id": chatId,
        "lastTime": lastTime,
        "total_unread": total_unread,
      };
}

class UserModel {
  String? id;
  String? name;
  String? birthDay;
  String? userRole;
  String? urlImage;
  bool? isSubscribe;
  String? idBin;
  String? email;
  String? creationTime;
  String? lastSignInTime;
  String? status;
  String? updatedTime;
  List<ChatUser>? chats;

  UserModel({
    this.id,
    this.name,
    this.birthDay,
    this.userRole,
    this.urlImage,
    this.isSubscribe,
    this.idBin,
    this.email,
    this.creationTime,
    this.lastSignInTime,
    this.status,
    this.updatedTime,
    this.chats,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["uid"],
      name: map["name"],
      birthDay: map["birthday"],
      userRole: map["user_role"],
      urlImage: map["photoUrl"],
      isSubscribe: map["is_subscribe"],
      idBin: map["id_bin"],
      email: map['email'] ?? '',
      status: map['status'] ?? '',
      creationTime: map['creationTime'] ?? '',
      lastSignInTime: map['lastSignInTime'] ?? '',
      updatedTime: map['updatedTime'] ?? '',
    );
  }
}
