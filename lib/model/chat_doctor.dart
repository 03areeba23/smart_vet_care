class ChatDoctor {
  ChatDoctor({
    required this.speciality,
    required this.uid,
    required this.firstname,
    required this.hosptialName,
    required this.isOnline,
    required this.userName,
    required this.email,
    required this.lastname,
    required this.image
  });
  late final String speciality;
  late final String uid;
  late final String firstname;
  late final String hosptialName;
  late final bool isOnline;
  late final String userName;
  late final String email;
  late final String lastname;
  late final String image;

  ChatDoctor.fromJson(Map<String, dynamic> json){
    speciality = json['speciality'] ?? '';
    uid = json['uid'] ?? '';
    firstname = json['firstname'] ?? '';
    hosptialName = json['hosptialName'] ?? '';
    isOnline = json['isOnline'] ?? '';
    userName = json['userName'] ?? '';
    email = json['email'] ?? '';
    lastname = json['lastname'] ?? '';
    image = json['image'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['speciality'] = speciality;
    data['uid'] = uid;
    data['firstname'] = firstname;
    data['hosptialName'] = hosptialName;
    data['isOnline'] = isOnline;
    data['userName'] = userName;
    data['email'] = email;
    data['lastname'] = lastname;
    data['image'] = image;
    return data;
  }
}