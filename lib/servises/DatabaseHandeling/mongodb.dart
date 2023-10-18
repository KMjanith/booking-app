import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'constant.dart';

class mongoDatabase {
  static var trainCollection;
  static var stationCollecton;
  static var routeCollecton;
  

  static connect() async {
    
    var db = await Db.create(mongoURL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    trainCollection = db.collection(Collection_Name_1);
    stationCollecton = db.collection(Collection_name_2);
    routeCollecton = db.collection(Collection_Name_3);

    //print(await userCollection.find().toList());
  }

  // static Future<List<Map<String, dynamic>>> getDataStation(
    
  //     String from, String to, List<String> dates) async {
  //   final routeQuery = where.oneFrom('station', [from, to]);
  //   final routeArr = await stationCollecton.find(routeQuery).toList();

  //   print("routeArr $routeArr");

  //   final routeIDArr = routeArr.map((routeData) {
  //     //route ID array
  //     return routeData['route_id'];
  //   }).toList();

  //   final PriceArr = routeArr.map((routeData) {
  //     //price of the region of the station
  //     return routeData['prices'];
  //   }).toList();

  //   print(" PriceArr $PriceArr");
  //   print(routeIDArr);

  //   if (routeIDArr[0] == routeIDArr[1]) {
  //     routeIDArr.removeAt(0);
  //   }

  //   print(routeIDArr);

  //   final query = where.eq("routeNo", routeIDArr[0]);
  //   final routeDetails = await routeCollecton.findOne(query);

  //   // Retrieve the "prices" array from the document
  //   var RegionPricesArray = routeDetails['prices'];

  //   //fair calculation for all classes
  //   final firstClassPrice = priceCalculator(RegionPricesArray, PriceArr, 1);
  //   print(firstClassPrice);
  //   final secondClassPrice = priceCalculator(RegionPricesArray, PriceArr, 2);
  //   print(secondClassPrice);
  //   final thirdClassPrice = priceCalculator(RegionPricesArray, PriceArr, 3);
  //   print(thirdClassPrice);

  //   final classPrices = [
  //     {
  //       "ticketPrices": [firstClassPrice, secondClassPrice, thirdClassPrice]
  //     }
  //   ];

  //   // Step 2: Filter trains based on route IDs, station, date
  //   final trainQuery = {
  //     'routes': {
  //       '\$all': routeIDArr,
  //     },
  //     'stations': {
  //       '\$all': [from, to],
  //     },
  //     'dates': {
  //       '\$in': dates,
  //     },
  //   };

  //   var TrainListFinal =
  //       await trainCollection.find(trainQuery).toList(); //train objects array
  //   //print(TrainListFinal);

  //   TrainListFinal = TrainListFinal + classPrices;
  //   print(TrainListFinal.runtimeType);


  //   return TrainListFinal;
  // }

  // static Future<void> updateTrainSheetView(
  //     ObjectId trainId, List<int> newSheetView, int index) async {
  //   final updateResult = await trainCollection.update(
  //     where.id(trainId),
  //     modify.set('seatsArrangement.$index', newSheetView),
  //   );

  //   print('Update result: $updateResult');
  // }

  //fair calculation method
  static int priceCalculator(var RegionPricesArray, var PriceArr, int clasNo) {
    print(RegionPricesArray);
    print(PriceArr);
    print(clasNo);
    var fromtemp =
        RegionPricesArray[clasNo - 1].indexOf(PriceArr[0][clasNo - 1]);
    var totemp = RegionPricesArray[clasNo - 1].indexOf(PriceArr[1][clasNo - 1]);
    var deference = (fromtemp - totemp).abs();
    return RegionPricesArray[clasNo - 1][deference];
  }
}
