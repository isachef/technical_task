import 'dart:convert';

class QrModel {
  String? title;
  String? data;

  QrModel({required this.data,required this.title});


  factory QrModel.fromRawJson(String str) => QrModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QrModel.fromJson(Map<String, dynamic> json) =>
      QrModel(
        data: json["data"] == null ? null : json["data"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() =>
      {
        "data": data == null ? null : data,
        "title": title == null ? null : title,
      };
}
List<QrModel> QrModelList=[
  QrModel(data: '12345',title: "Моя машина"),
  QrModel(data: '123456',title: "Мой ребенок"),
  QrModel(data: '123457',title: "Мой телефон"),
  QrModel(data: '123458',title: "Мой кошелек"),
  QrModel(data: '123459',title: "Моя квартира"),
];