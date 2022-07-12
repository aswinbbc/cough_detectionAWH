class Schedule {
  Schedule({
    required this.user,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.doctor,
  });
  late final int user;
  late final String date;
  late final String startTime;
  late final String endTime;
  late final int doctor;
  
  Schedule.fromJson(Map<String, dynamic> json){
    user = json['user'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    doctor = json['doctor'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user;
    _data['date'] = date;
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    _data['doctor'] = doctor;
    return _data;
  }
}