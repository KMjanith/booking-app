// To parse this JSON data, do
//
//     final TrainModel = TrainModelFromJson(jsonString);

import 'dart:convert';

TrainModel TrainModelFromJson(String str) =>
    TrainModel.fromJson(json.decode(str));

String TrainModelToJson(TrainModel data) => json.encode(data.toJson());

class TrainModel {
  //String id;
  String name;
  String from;
  String to;
  int trainNo;
  String dates;
  List<int> routes;
  List<String> stations;
  List<String> arrivalTimes;
  List<String> departureTimes;
  List<String> classTypes;
  List<int> sheetAvailable;
  List<List<int>> sheet_view;

  TrainModel(
      {
      //required this.id,
      required this.name,
      required this.from,
      required this.to,
      required this.trainNo,
      required this.routes,
      required this.dates,
      required this.stations,
      required this.arrivalTimes,
      required this.departureTimes,
      required this.classTypes,
      required this.sheetAvailable,
      required this.sheet_view});

  factory TrainModel.fromJson(Map<String, dynamic> json) => TrainModel(
        //id: json["_id"],
        name: json["trainName"],
        from: json["origin"],
        to: json["destination"],
        dates: json["dates"],
        trainNo: json["trainNo"],
        routes: List<int>.from(json["routes"].map((x) => x)),
        stations: List<String>.from(json["stations"].map((x) => x)),
        arrivalTimes: List<String>.from(json["arrivalTimes"].map((x) => x)),
        departureTimes:
            List<String>.from(json["departureTimes"].map((x) => x)),
        classTypes: List<String>.from(json["class"].map((x) => x)),
        sheetAvailable: List<int>.from(json["seatsAvailability"].map((x) => x)),
        sheet_view: List<List<int>>.from(
            json["seatsArrangement"].map((x) => List<int>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        //"_id": id,
        "name": name,
        "from": from,
        "to": to,
        "train_no": trainNo,
        "dates": dates,
        "routes": List<String>.from(routes.map((x) => x)),
        "stations": List<String>.from(stations.map((x) => x)),
        "arrival_times": List<double>.from(arrivalTimes.map((x) => x)),
        "departure_times": List<double>.from(departureTimes.map((x) => x)),
        "class_types": List<String>.from(classTypes.map((x) => x)),
        "sheet_available": List<int>.from(sheetAvailable.map((x) => x)),
        "sheet_view": List<int>.from(
            sheet_view.map((x) => List<int>.from(x.map((x) => x)))),
      };
}
