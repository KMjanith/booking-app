// To parse this JSON data, do
//
//     final StationModel = StationModelFromJson(jsonString);

import 'dart:convert';

/*StationModel StationModelFromJson(String str) => StationModel.fromJson(json.decode(str));

String StationModelToJson(StationModel data) => json.encode(data.toJson());

class StationModel {
    int id;
    String station;
    int routeId;

    StationModel({
        required this.id,
        required this.station,
        required this.routeId,
    });

    factory StationModel.fromJson(Map<String, dynamic> json) => StationModel(
        id: json["_id"],
        station: json["station"],
        routeId: json["route_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "station": station,
        "route_id": routeId,
    };
}
*/

StationModel StationModelFromJson(String str) => StationModel.fromJson(json.decode(str));

String StationModelToJson(StationModel data) => json.encode(data.toJson());

class StationModel {
    int id;
    String station;
    List<int> prices;
    int routeId;

    StationModel({
        required this.id,
        required this.station,
        required this.prices,
        required this.routeId,
    });

    factory StationModel.fromJson(Map<String, dynamic> json) => StationModel(
        id: json["_id"],
        station: json["station"],
        prices: List<int>.from(json["prices"].map((x) => x)),
        routeId: json["route_id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "station": station,
        "prices": List<dynamic>.from(prices.map((x) => x)),
        "route_id": routeId,
    };
}
