class ChatUser {
  ChatUser({
    required this.image,
    required this.uid,
    required this.firstname,
    required this.isOnline,
    required this.userName,
    required this.email,
    required this.lastname,
  });
  late final String image;
  late final String uid;
  late final String firstname;
  late final bool isOnline;
  late final String userName;
  late final String email;
  late final String lastname;

  ChatUser.fromJson(Map<String, dynamic> json){
    image = json['image'] ?? '';
    uid = json['uid'] ?? '';
    firstname = json['firstname'] ?? '';
    isOnline = json['isOnline'] ?? '';
    userName = json['userName'] ?? '';
    email = json['email'] ?? '';
    lastname = json['lastname'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['uid'] = uid;
    data['firstname'] = firstname;
    data['isOnline'] = isOnline;
    data['userName'] = userName;
    data['email'] = email;
    data['lastname'] = lastname;
    return data;
  }
}