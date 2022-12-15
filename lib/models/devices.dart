class Devices {
  int id;
  String created_at;
  String name;
  String devicekey;

  Devices(
      {required this.id,
      required this.created_at,
      required this.name,
      required this.devicekey});

  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
      id: json["id"],
      created_at: json["createdAt"],
      name: json["name"],
      devicekey: json["devicekey"],
    );
  }
}
