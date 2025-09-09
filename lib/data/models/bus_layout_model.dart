class BusLayoutModel {
  final List<dynamic> data;

  BusLayoutModel({required this.data});

  factory BusLayoutModel.fromJson(Map<String, dynamic> json) {
    return BusLayoutModel(data: json['record']['data']);
  }
}