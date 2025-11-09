import "package:flutter/material.dart";
import 'package:mongo_dart/mongo_dart.dart' hide Center, State;

import "../backend/backend_functions.dart";
import "../backend/uris.dart";
import "my_car.dart";




class CarListBuilderStf extends StatefulWidget {
  const CarListBuilderStf({super.key});

  @override
  State<CarListBuilderStf> createState() => _CarListBuilderStfState();
}

class _CarListBuilderStfState extends State<CarListBuilderStf> {
  late Db db;
  Stream? changeStream;
  Stream? stream;
  bool allowStream = true;

  @override
  void initState() {
    super.initState();
    _initMongoDBStream();
  }

  Future<void> _initMongoDBStream() async {

    db = await Db.create(
      mongo_db,
    );
    await db.open();

    final collection = db.collection('cars');

    final pipeline = [
      {
        '\$match': {
          '\$or': [
            {'operationType': 'insert'},
            {'operationType': 'delete'},
            {'operationType': 'update'},
          ],
        },
      },
    ];

    // Checks for deletions
    changeStream = collection.watch(pipeline);

    var controller2 = changeStream?.listen((changeEvent) async {
      allowStream = true;
      print("Change Happened");
    });

    print("Set up streaming");


  }

  // Will only return when allowStream is true
  Future<bool> getCanStream() async {
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      if (allowStream == true) {
        return allowStream;
      }
    }
  }

  // Will return a stream of the cars to allow for live updating
  Stream<Map<dynamic, dynamic>> streamCars () async* {
    while (true) {
      await getCanStream(); // Waits until allowStream changes to true
      await Future.delayed(Duration(milliseconds: 200));
      allowStream = false;
      var cars = await backend_get_cars();
      yield cars; // Sends back stream of cars
      }
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: streamCars(),
      builder: (context, snapshot) {

        if (snapshot.data == null) {
          return Column(
            children: [
              SizedBox(height: 20,),
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          );
        }

        List carList = snapshot.data?["cars"];

        return Expanded(
          child: ListView.builder(
            itemCount: carList.length,
            itemBuilder: (context, index) {
              List<dynamic> stringList = carList[index]["warningLightIndicators"];

              if (index == carList.length - 1) {
                return Container(
                  padding: EdgeInsets.only(top: 10, bottom: 40),

                  child: Column(
                    children: [
                      MyCar(
                        carType: carList[index]["carType"],
                        licensePlate: carList[index]["licensePlate"],
                        year: carList[index]["year"],
                        mileage: carList[index]["mileage"],
                        make: carList[index]["make"],
                        model: carList[index]["model"],
                        color: carList[index]["color"],
                        VIN: carList[index]["vehicleIdentificationNumber"],
                        rentalStatus: carList[index]["rentalStatus"],
                        warningLightIndicators: stringList,
                        carID: carList[index]["_id"],
                      ),
                    ],
                  ),
                );
              }

              return Container(
                padding: EdgeInsets.only(top: 10),

                child: Column(
                  children: [
                    MyCar(
                      carType: carList[index]["carType"],
                      licensePlate: carList[index]["licensePlate"],
                      year: carList[index]["year"],
                      mileage: carList[index]["mileage"],
                      make: carList[index]["make"],
                      model: carList[index]["model"],
                      color: carList[index]["color"],
                      VIN: carList[index]["vehicleIdentificationNumber"],
                      rentalStatus: carList[index]["rentalStatus"],
                      warningLightIndicators: stringList,
                      carID: carList[index]["_id"],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}