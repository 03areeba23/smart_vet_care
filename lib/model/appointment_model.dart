class Appointments {
  Appointments({
    required this.date,
    required this.description,
    required this.doctor,
    required this.name,
    required this.pet,
    required this.time
  });
  late final String date;
  late final String description;
  late final String doctor;
  late final String name;
  late final String pet;
  late final String time;

  Appointments.fromJson(Map<String, dynamic> json){
    date = json['date'].toString();
    description = json['description'].toString();
    doctor = json['doctor'].toString();
    name = json['name'].toString();
    pet = json['pet'].toString();
    time = json['time'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['description'] = description;
    data['doctor'] = doctor;
    data['name'] = name;
    data['pet'] = pet;
    data['time'] = time;
    return data;
  }
}