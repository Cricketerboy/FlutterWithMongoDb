import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:tailorapp_assignment/const_uri.dart';
import 'package:tailorapp_assignment/insertdataModel.dart';

class MongoService {
  static late Db _db;
  static late DbCollection userCollection;

  static Future<void> connect() async {
    _db = await Db.create(MONGO_URL);
    await _db.open();
    print("connection established");
    userCollection = _db.collection(USER_COLLECTION);
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "Data inserted";
      } else {
        return "Something wrong while inserting data";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  static Future<List<Map<String, dynamic>>> fetchData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<void> closeConnection() async {
    await _db.close();
  }
}
