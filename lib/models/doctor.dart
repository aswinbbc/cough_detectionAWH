class Doctor {
  Doctor({
    required this.id,
    required this.name,
    required this.hospitalName,
    required this.speacialisation,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String hospitalName;
  late final String speacialisation;
  late final String image;
  
  Doctor.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    hospitalName = json['hospital_name'];
    speacialisation = json['speacialisation'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['hospital_name'] = hospitalName;
    _data['speacialisation'] = speacialisation;
    _data['image'] = image;
    return _data;
  }
}