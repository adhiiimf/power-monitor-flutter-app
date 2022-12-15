class Logs {
  int id;
  String date;
  String timestamp;
  num voltage;
  num current;
  num power;
  num energy;
  String devicekey;
  bool isactive;

  Logs(
      {required this.id,
      required this.date,
      required this.timestamp,
      required this.voltage,
      required this.current,
      required this.power,
      required this.energy,
      required this.devicekey,
      required this.isactive});

  factory Logs.fromJson(Map<String, dynamic> json) {
    return Logs(
      id: json["id"],
      timestamp: json["timestamp"],
      voltage: json["voltage"],
      current: json["current"],
      power: json["power"],
      energy: json["energy"],
      devicekey: json["devicekey"],
      isactive: json["isactive"],
      date: json["date"].toString(),
    );
  }
}

class ActiveLog {
  String id, starttime, endtime, kwh;
  ActiveLog(
      {required this.id,
      required this.starttime,
      required this.endtime,
      required this.kwh});
  factory ActiveLog.fromJson(Map<String, dynamic> json) {
    return ActiveLog(
        id: json["id"] as String,
        starttime: json["starttime"] as String,
        endtime: json["endtime"] as String,
        kwh: json["kwh"] as String);
  }
}
